// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_form_ui_state.dart';

// **************************************************************************
// Generator: sealed_class_creators
// **************************************************************************

/// [EditFormUIState] {
///
/// ([EditFormUIStateShowLoading] showLoading){} with data equality
///
/// ([EditFormUIStateShowContent] showContent){[List<FormViewModel>] viewModels} with data equality
///
/// }
@SealedManifest(_EditFormUIState)
abstract class EditFormUIState {
  const EditFormUIState._internal();

  const factory EditFormUIState.showLoading() = EditFormUIStateShowLoading;

  const factory EditFormUIState.showContent({
    required List<FormViewModel> viewModels,
  }) = EditFormUIStateShowContent;

  bool get isShowLoading => this is EditFormUIStateShowLoading;

  bool get isShowContent => this is EditFormUIStateShowContent;

  EditFormUIStateShowLoading get asShowLoading =>
      this as EditFormUIStateShowLoading;

  EditFormUIStateShowContent get asShowContent =>
      this as EditFormUIStateShowContent;

  EditFormUIStateShowLoading? get asShowLoadingOrNull {
    final editFormUIState = this;
    return editFormUIState is EditFormUIStateShowLoading
        ? editFormUIState
        : null;
  }

  EditFormUIStateShowContent? get asShowContentOrNull {
    final editFormUIState = this;
    return editFormUIState is EditFormUIStateShowContent
        ? editFormUIState
        : null;
  }

  R when<R extends Object?>({
    required R Function() showLoading,
    required R Function(List<FormViewModel> viewModels) showContent,
  }) {
    final editFormUIState = this;
    if (editFormUIState is EditFormUIStateShowLoading) {
      return showLoading();
    } else if (editFormUIState is EditFormUIStateShowContent) {
      return showContent(editFormUIState.viewModels);
    } else {
      throw AssertionError();
    }
  }

  R maybeWhen<R extends Object?>({
    R Function()? showLoading,
    R Function(List<FormViewModel> viewModels)? showContent,
    required R Function(EditFormUIState editFormUIState) orElse,
  }) {
    final editFormUIState = this;
    if (editFormUIState is EditFormUIStateShowLoading) {
      return showLoading != null ? showLoading() : orElse(editFormUIState);
    } else if (editFormUIState is EditFormUIStateShowContent) {
      return showContent != null
          ? showContent(editFormUIState.viewModels)
          : orElse(editFormUIState);
    } else {
      throw AssertionError();
    }
  }

  @Deprecated('Use `whenOrNull` instead. Will be removed by next release.')
  void partialWhen({
    void Function()? showLoading,
    void Function(List<FormViewModel> viewModels)? showContent,
    void Function(EditFormUIState editFormUIState)? orElse,
  }) {
    final editFormUIState = this;
    if (editFormUIState is EditFormUIStateShowLoading) {
      if (showLoading != null) {
        showLoading();
      } else if (orElse != null) {
        orElse(editFormUIState);
      }
    } else if (editFormUIState is EditFormUIStateShowContent) {
      if (showContent != null) {
        showContent(editFormUIState.viewModels);
      } else if (orElse != null) {
        orElse(editFormUIState);
      }
    } else {
      throw AssertionError();
    }
  }

  R? whenOrNull<R extends Object?>({
    R Function()? showLoading,
    R Function(List<FormViewModel> viewModels)? showContent,
    R Function(EditFormUIState editFormUIState)? orElse,
  }) {
    final editFormUIState = this;
    if (editFormUIState is EditFormUIStateShowLoading) {
      return showLoading != null
          ? showLoading()
          : orElse?.call(editFormUIState);
    } else if (editFormUIState is EditFormUIStateShowContent) {
      return showContent != null
          ? showContent(editFormUIState.viewModels)
          : orElse?.call(editFormUIState);
    } else {
      throw AssertionError();
    }
  }

  R map<R extends Object?>({
    required R Function(EditFormUIStateShowLoading showLoading) showLoading,
    required R Function(EditFormUIStateShowContent showContent) showContent,
  }) {
    final editFormUIState = this;
    if (editFormUIState is EditFormUIStateShowLoading) {
      return showLoading(editFormUIState);
    } else if (editFormUIState is EditFormUIStateShowContent) {
      return showContent(editFormUIState);
    } else {
      throw AssertionError();
    }
  }

  R maybeMap<R extends Object?>({
    R Function(EditFormUIStateShowLoading showLoading)? showLoading,
    R Function(EditFormUIStateShowContent showContent)? showContent,
    required R Function(EditFormUIState editFormUIState) orElse,
  }) {
    final editFormUIState = this;
    if (editFormUIState is EditFormUIStateShowLoading) {
      return showLoading != null
          ? showLoading(editFormUIState)
          : orElse(editFormUIState);
    } else if (editFormUIState is EditFormUIStateShowContent) {
      return showContent != null
          ? showContent(editFormUIState)
          : orElse(editFormUIState);
    } else {
      throw AssertionError();
    }
  }

  @Deprecated('Use `mapOrNull` instead. Will be removed by next release.')
  void partialMap({
    void Function(EditFormUIStateShowLoading showLoading)? showLoading,
    void Function(EditFormUIStateShowContent showContent)? showContent,
    void Function(EditFormUIState editFormUIState)? orElse,
  }) {
    final editFormUIState = this;
    if (editFormUIState is EditFormUIStateShowLoading) {
      if (showLoading != null) {
        showLoading(editFormUIState);
      } else if (orElse != null) {
        orElse(editFormUIState);
      }
    } else if (editFormUIState is EditFormUIStateShowContent) {
      if (showContent != null) {
        showContent(editFormUIState);
      } else if (orElse != null) {
        orElse(editFormUIState);
      }
    } else {
      throw AssertionError();
    }
  }

  R? mapOrNull<R extends Object?>({
    R Function(EditFormUIStateShowLoading showLoading)? showLoading,
    R Function(EditFormUIStateShowContent showContent)? showContent,
    R Function(EditFormUIState editFormUIState)? orElse,
  }) {
    final editFormUIState = this;
    if (editFormUIState is EditFormUIStateShowLoading) {
      return showLoading != null
          ? showLoading(editFormUIState)
          : orElse?.call(editFormUIState);
    } else if (editFormUIState is EditFormUIStateShowContent) {
      return showContent != null
          ? showContent(editFormUIState)
          : orElse?.call(editFormUIState);
    } else {
      throw AssertionError();
    }
  }
}

/// (([EditFormUIStateShowLoading] : [EditFormUIState]) showLoading){}
///
/// with data equality
class EditFormUIStateShowLoading extends EditFormUIState with EquatableMixin {
  const EditFormUIStateShowLoading() : super._internal();

  @override
  String toString() => 'EditFormUIState.showLoading()';

  @override
  List<Object?> get props => [];
}

/// (([EditFormUIStateShowContent] : [EditFormUIState]) showContent){[List<FormViewModel>] viewModels}
///
/// with data equality
class EditFormUIStateShowContent extends EditFormUIState with EquatableMixin {
  const EditFormUIStateShowContent({
    required this.viewModels,
  }) : super._internal();

  final List<FormViewModel> viewModels;

  @override
  String toString() => 'EditFormUIState.showContent(viewModels: $viewModels)';

  @override
  List<Object?> get props => [
        viewModels,
      ];
}

/// [EditFormUIAction] {
///
/// ([EditFormUIActionDoNothing] doNothing){} with data equality
///
/// }
@SealedManifest(_EditFormUIAction)
abstract class EditFormUIAction {
  const EditFormUIAction._internal();

  const factory EditFormUIAction.doNothing() = EditFormUIActionDoNothing;

  bool get isDoNothing => this is EditFormUIActionDoNothing;

  EditFormUIActionDoNothing get asDoNothing =>
      this as EditFormUIActionDoNothing;

  EditFormUIActionDoNothing? get asDoNothingOrNull {
    final editFormUIAction = this;
    return editFormUIAction is EditFormUIActionDoNothing
        ? editFormUIAction
        : null;
  }

  R when<R extends Object?>({
    required R Function() doNothing,
  }) {
    final editFormUIAction = this;
    if (editFormUIAction is EditFormUIActionDoNothing) {
      return doNothing();
    } else {
      throw AssertionError();
    }
  }

  R maybeWhen<R extends Object?>({
    R Function()? doNothing,
    required R Function(EditFormUIAction editFormUIAction) orElse,
  }) {
    final editFormUIAction = this;
    if (editFormUIAction is EditFormUIActionDoNothing) {
      return doNothing != null ? doNothing() : orElse(editFormUIAction);
    } else {
      throw AssertionError();
    }
  }

  @Deprecated('Use `whenOrNull` instead. Will be removed by next release.')
  void partialWhen({
    void Function()? doNothing,
    void Function(EditFormUIAction editFormUIAction)? orElse,
  }) {
    final editFormUIAction = this;
    if (editFormUIAction is EditFormUIActionDoNothing) {
      if (doNothing != null) {
        doNothing();
      } else if (orElse != null) {
        orElse(editFormUIAction);
      }
    } else {
      throw AssertionError();
    }
  }

  R? whenOrNull<R extends Object?>({
    R Function()? doNothing,
    R Function(EditFormUIAction editFormUIAction)? orElse,
  }) {
    final editFormUIAction = this;
    if (editFormUIAction is EditFormUIActionDoNothing) {
      return doNothing != null ? doNothing() : orElse?.call(editFormUIAction);
    } else {
      throw AssertionError();
    }
  }

  R map<R extends Object?>({
    required R Function(EditFormUIActionDoNothing doNothing) doNothing,
  }) {
    final editFormUIAction = this;
    if (editFormUIAction is EditFormUIActionDoNothing) {
      return doNothing(editFormUIAction);
    } else {
      throw AssertionError();
    }
  }

  R maybeMap<R extends Object?>({
    R Function(EditFormUIActionDoNothing doNothing)? doNothing,
    required R Function(EditFormUIAction editFormUIAction) orElse,
  }) {
    final editFormUIAction = this;
    if (editFormUIAction is EditFormUIActionDoNothing) {
      return doNothing != null
          ? doNothing(editFormUIAction)
          : orElse(editFormUIAction);
    } else {
      throw AssertionError();
    }
  }

  @Deprecated('Use `mapOrNull` instead. Will be removed by next release.')
  void partialMap({
    void Function(EditFormUIActionDoNothing doNothing)? doNothing,
    void Function(EditFormUIAction editFormUIAction)? orElse,
  }) {
    final editFormUIAction = this;
    if (editFormUIAction is EditFormUIActionDoNothing) {
      if (doNothing != null) {
        doNothing(editFormUIAction);
      } else if (orElse != null) {
        orElse(editFormUIAction);
      }
    } else {
      throw AssertionError();
    }
  }

  R? mapOrNull<R extends Object?>({
    R Function(EditFormUIActionDoNothing doNothing)? doNothing,
    R Function(EditFormUIAction editFormUIAction)? orElse,
  }) {
    final editFormUIAction = this;
    if (editFormUIAction is EditFormUIActionDoNothing) {
      return doNothing != null
          ? doNothing(editFormUIAction)
          : orElse?.call(editFormUIAction);
    } else {
      throw AssertionError();
    }
  }
}

/// (([EditFormUIActionDoNothing] : [EditFormUIAction]) doNothing){}
///
/// with data equality
class EditFormUIActionDoNothing extends EditFormUIAction with EquatableMixin {
  const EditFormUIActionDoNothing() : super._internal();

  @override
  String toString() => 'EditFormUIAction.doNothing()';

  @override
  List<Object?> get props => [];
}
