import 'package:sealed_class_annotations/sealed_class_annotations.dart';

import 'model/edit_form_models.dart';

part 'edit_form_ui_state.sealed.dart';

@Sealed()
abstract class _EditFormUIState {
  void showLoading();
  void showContent(
    List<FormViewModel> viewModels,
    bool showNonEditableFields,
  );
}

@Sealed()
abstract class _EditFormUIAction {
  void doNothing();
}
