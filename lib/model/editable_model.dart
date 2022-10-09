import 'edit_form_models.dart';

abstract class EditableModel<T> {
  List<FormViewType> getFormViewTypes();

  T fromEditJson(Map<String, dynamic> json);
}
