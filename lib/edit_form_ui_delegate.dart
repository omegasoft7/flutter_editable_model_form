import 'package:architecture/ui_delegate.dart';
import 'package:flutter/material.dart';

import 'edit_form_ui_state.dart';
import 'model/edit_form_models.dart';
import 'model/editable_model.dart';

class EditFormUiDelegate<T>
    extends UIDelegate<EditFormUIState, EditFormUIAction> {
  final EditableModel<T> editableModel;
  final Function(T) onSubmit;
  final bool showNonEditableFields;

  EditFormUiDelegate({
    required this.editableModel,
    required this.onSubmit,
    required this.showNonEditableFields,
  });

  void init() {
    add(const EditFormUIState.showLoading());
    add(
      EditFormUIState.showContent(
        viewModels: editableModel
            .getFormViewTypes()
            .map((formViewType) => formViewType.getFormViewModel())
            .toList(),
        showNonEditableFields: showNonEditableFields,
      ),
    );
  }

  void submit(Map<String, String> inputValues) {
    add(const EditFormUIState.showLoading());

    debugPrint("submit called with $inputValues");

    final map = inputValues.map((key, value) {
      debugPrint("map1 key: $key, value: $value");
      return MapEntry(
          editableModel
              .getFormViewTypes()
              .firstWhere((element) => element.getFormViewModel().key == key),
          value);
    }).map((key, value) {
      debugPrint("map2 key: $key, value: $value");
      switch (key.runtimeType) {
        case FormCurrencyInputViewType:
          return MapEntry(
              key.getFormViewModel().key, (double.parse(value) * 100).round());
        case FormNumberInputViewType:
          return MapEntry(key.getFormViewModel().key, int.parse(value));
        case FormTextInputViewType:
          return MapEntry(key.getFormViewModel().key, value);
        case FormListTextInputViewType:
          return MapEntry(key.getFormViewModel().key, value.split(","));
        case FormBooleanInputViewType:
          return MapEntry(key.getFormViewModel().key, value == "true");
        case FormSelectorInputViewType:
          return MapEntry(key.getFormViewModel().key, value);
        case FormYearPickerViewType:
          return MapEntry(key.getFormViewModel().key, int.parse(value));
        case FormEmailInputViewType:
          return MapEntry(key.getFormViewModel().key, value);
        default:
          throw Exception("invalid type:${key.runtimeType}");
      }
    });

    onSubmit(editableModel.fromEditJson(map));
  }

  void toggleShowNonEditableFields() {
    add(
      EditFormUIState.showContent(
        viewModels: editableModel
            .getFormViewTypes()
            .map((formViewType) => formViewType.getFormViewModel())
            .toList(),
        showNonEditableFields: !showNonEditableFields,
      ),
    );
  }
}
