import 'package:architecture/ui_delegate.dart';

import 'edit_form_ui_state.dart';
import 'model/edit_form_models.dart';
import 'model/editable_model.dart';

class EditFormUiDelegate<T>
    extends UIDelegate<EditFormUIState, EditFormUIAction> {
  final EditableModel<T> editableModel;
  final Function(T) onSubmit;

  EditFormUiDelegate({
    required this.editableModel,
    required this.onSubmit,
  });

  void init() {
    add(const EditFormUIState.showLoading());
    add(
      EditFormUIState.showContent(
        viewModels: editableModel
            .getFormViewTypes()
            .map((formViewType) => formViewType.getFormViewModel())
            .toList(),
      ),
    );
  }

  void submit(Map<String, String> inputValues) {
    add(const EditFormUIState.showLoading());

    final map = inputValues
        .map((key, value) => MapEntry(
            editableModel
                .getFormViewTypes()
                .firstWhere((element) => element.getFormViewModel().key == key),
            value))
        .map((key, value) {
      switch (key.runtimeType) {
        case FormCurrencyInputViewType:
          return MapEntry(
              key.getFormViewModel().key, (double.parse(value) * 100).round());
        case FormNumberInputViewType:
          return MapEntry(key.getFormViewModel().key, int.parse(value));
        case FormTextInputViewType:
          return MapEntry(key.getFormViewModel().key, value);
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
}
