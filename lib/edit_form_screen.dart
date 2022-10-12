import 'package:architecture/extension/widget_extensions.dart';
import 'package:architecture/ui_extensions.dart';
import 'package:architecture/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'model/edit_form_models.dart';
import 'edit_form_ui_delegate.dart';
import 'model/editable_model.dart';

class EditFormScreen<T> extends StatelessWidget {
  final String title;
  final EditableModel<T> editableModel;
  final bool showPreview;
  final Function(T) onSubmit;
  late final EditFormUiDelegate<T> _delegate;

  EditFormScreen({
    super.key,
    required this.title,
    required this.editableModel,
    this.showPreview = false,
    required this.onSubmit,
  }) {
    _delegate = EditFormUiDelegate<T>(
      editableModel: editableModel,
      onSubmit: onSubmit,
      showNonEditableFields: showPreview,
    );
    _delegate.init();
  }

  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _textControllers = {};

  @override
  Widget build(BuildContext context) {
    return _delegate.getBuilder(
      builder: (uiState) => uiState
          .when(
            showLoading: () => UIUtils.getLoadingWidget(),
            showContent: (viewModels, showNonEditableFields) => Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ).padding(vertical: 16, horizontal: 16),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        _delegate.toggleShowNonEditableFields();
                      },
                    ).changeVisibility(isVisible: showNonEditableFields),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: viewModels
                          .map<Widget>(
                            (formViewmodel) => _convertViewModelToFormField(
                              context,
                              formViewmodel,
                              showNonEditableFields,
                            ),
                          )
                          .toList(),
                    ),
                    ElevatedButton(
                      onPressed: (() {
                        if (_isFormValid()) {
                          debugPrint("form is valid");
                          _delegate.submit(
                            _textControllers.map(
                              (key, value) => MapEntry(key, value.text),
                            ),
                          );
                        }
                      }),
                      child: const Text("Submit"),
                    )
                        .padding(top: 16, horizontal: 8)
                        .changeVisibility(isVisible: !showNonEditableFields)
                  ],
                ),
              ),
            ),
          )
          .padding(horizontal: 16),
    );
  }

  Widget _convertViewModelToFormField(
    BuildContext context,
    FormViewModel formViewModel,
    bool showNonEditableFields,
  ) {
    _makeControllerForIndexIfPossible(
      formViewModel.key,
      formViewModel.defaultValue,
    );

    if (showNonEditableFields) {
      switch (formViewModel.type) {
        case FormViewModelType.YEAR_PICKER:
        case FormViewModelType.SELECTOR:
        case FormViewModelType.BOOLEAN:
        case FormViewModelType.TEXT_LIST:
        case FormViewModelType.RICH_TEXT:
        case FormViewModelType.TEXT:
          return Text(
            "${formViewModel.label}: ${formViewModel.defaultValue}",
          );
        case FormViewModelType.LINK:
          return TextButton(
            onPressed: () {
              if (formViewModel.previewPrefix != null) {
                launchUrl(Uri.parse(
                    "${formViewModel.previewPrefix}${formViewModel.defaultValue}"));
              } else {
                final urlWithHttps = makeSureThatUrlHasHttps(
                  formViewModel.defaultValue ?? "",
                );
                launchUrl(urlWithHttps);
              }
            },
            child: Text(
              "${formViewModel.label}: ${formViewModel.defaultValue}",
            ),
          );
      }
    }

    switch (formViewModel.type) {
      case FormViewModelType.TEXT:
        return TextFormField(
          controller: _textControllers[formViewModel.key],
          validator: formViewModel.validator,
          keyboardType: formViewModel.keyboardType,
          decoration: InputDecoration(
            icon: formViewModel.icon,
            labelText: formViewModel.label,
          ),
        );
      case FormViewModelType.LINK:
        return TextFormField(
          controller: _textControllers[formViewModel.key],
          validator: formViewModel.validator,
          keyboardType: formViewModel.keyboardType,
          decoration: InputDecoration(
            icon: formViewModel.icon,
            labelText: formViewModel.label,
          ),
        );
      case FormViewModelType.RICH_TEXT:
        return TextFormField(
          controller: _textControllers[formViewModel.key],
          validator: formViewModel.validator,
          keyboardType: formViewModel.keyboardType,
          decoration: InputDecoration(
            icon: formViewModel.icon,
            labelText: formViewModel.label,
          ),
          maxLines: 10,
        );
      case FormViewModelType.TEXT_LIST:
        return TextFormField(
          controller: _textControllers[formViewModel.key],
          validator: formViewModel.validator,
          keyboardType: formViewModel.keyboardType,
          decoration: InputDecoration(
            icon: formViewModel.icon,
            labelText: formViewModel.label,
          ),
        );
      case FormViewModelType.BOOLEAN:
        return CheckboxListTile(
          value: _textControllers[formViewModel.key]?.text == "true",
          onChanged: (value) {
            _textControllers[formViewModel.key]?.text = value.toString();
          },
          title: Text(formViewModel.label),
        );
      case FormViewModelType.SELECTOR:
        return DropdownButtonFormField(
          value: formViewModel.defaultValue,
          hint: const Text(
            'Select...',
          ),
          isExpanded: true,
          items: formViewModel.selectorItems
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ))
              .toList(),
          onChanged: (value) {
            _textControllers[formViewModel.key]!.text = value ?? "";
          },
          validator: (value) {
            if (formViewModel.validator != null && value is String) {
              return formViewModel.validator!(value);
            }
            return null;
          },
          decoration: InputDecoration(
            icon: formViewModel.icon,
            labelText: formViewModel.label,
          ),
        );
      case FormViewModelType.YEAR_PICKER:
        return TextFormField(
          controller: _textControllers[formViewModel.key],
          validator: formViewModel.validator,
          readOnly: true,
          decoration: InputDecoration(
            icon: formViewModel.icon,
            labelText: formViewModel.label,
          ),
          onTap: () async {
            debugPrint("year picker tapped");
            final selectedYear =
                int.tryParse(_textControllers[formViewModel.key]!.text);
            showYearPicckerBottomSheet(
              context,
              selectedYear ?? DateTime.now().year,
              (pickedDate) {
                _textControllers[formViewModel.key]!.text =
                    pickedDate.year.toString();
              },
            );
          },
        );
      default:
        throw Exception(
            "not a valid type: ${formViewModel.type} - ${formViewModel.runtimeType}");
    }
  }

  Uri makeSureThatUrlHasHttps(String url) {
    if (url.startsWith("http://")) {
      return Uri.parse(url.replaceFirst("http://", "https://"));
    } else if (url.startsWith("https://")) {
      return Uri.parse(url);
    } else {
      return Uri.parse("https://$url");
    }
  }

  void showYearPicckerBottomSheet(
    BuildContext context,
    int selectedYear,
    Function(DateTime) onDatePicked,
  ) {
    showBottomSheet(
        context: context,
        builder: (BuildContext context) => SizedBox(
              width: MediaQuery.of(context).size.width,
              child: YearPicker(
                selectedDate: DateTime(selectedYear),
                firstDate: DateTime(2000),
                lastDate: DateTime.now(),
                onChanged: (val) {
                  onDatePicked(val);
                  Navigator.pop(context);
                },
              ),
            ));
  }

  _makeControllerForIndexIfPossible(String key, String? defaultValue) {
    if (!_textControllers.containsKey(key)) {
      _textControllers[key] = TextEditingController(text: defaultValue);
    }
  }

  bool _isFormValid() => _formKey.currentState!.validate();
}
