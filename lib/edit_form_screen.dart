import 'package:architecture/extension/widget_extensions.dart';
import 'package:architecture/ui_extensions.dart';
import 'package:architecture/utils/ui_utils.dart';
import 'package:flutter/material.dart';

import 'model/edit_form_models.dart';
import 'edit_form_ui_delegate.dart';
import 'model/editable_model.dart';

class EditFormScreen<T> extends StatelessWidget {
  final String title;
  final EditableModel<T> editableModel;
  final Function(T) onSubmit;
  late final EditFormUiDelegate<T> _delegate;

  EditFormScreen({
    super.key,
    required this.title,
    required this.editableModel,
    required this.onSubmit,
  }) {
    _delegate = EditFormUiDelegate<T>(
      editableModel: editableModel,
      onSubmit: onSubmit,
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
            showContent: (viewModels) => Form(
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
                    ...viewModels.map<Widget>(
                      (formViewmodel) =>
                          _convertViewModelToFormField(context, formViewmodel),
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
                    ).padding(top: 16, horizontal: 8)
                  ],
                ),
              ),
            ),
          )
          .padding(horizontal: 16),
    );
  }

  FormField _convertViewModelToFormField(
    BuildContext context,
    FormViewModel formViewModel,
  ) {
    _makeControllerForIndexIfPossible(
      formViewModel.key,
      formViewModel.defaultValue,
    );

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
            _textControllers[formViewModel.key]!.text = value;
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
        throw Exception("not a valid type: ${formViewModel.runtimeType}");
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