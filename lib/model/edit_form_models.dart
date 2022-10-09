import 'package:flutter/material.dart';

abstract class FormViewType {
  FormViewModel getFormViewModel();
}

class FormCurrencyInputViewType extends FormViewType {
  final String key;
  final Icon? icon;
  final String label;
  final double? defaultValue;
  final String? Function(String?)? additionalValidator;

  FormCurrencyInputViewType({
    required this.key,
    this.icon,
    required this.label,
    this.defaultValue,
    this.additionalValidator,
  });

  @override
  FormViewModel getFormViewModel() {
    return FormViewModel(
        key: key,
        type: FormViewModelType.TEXT,
        keyboardType:
            const TextInputType.numberWithOptions(signed: true, decimal: true),
        icon: icon,
        label: label,
        defaultValue: defaultValue?.toString() ?? "0.00",
        validator: (value) {
          if (value == null ||
              value.isEmpty ||
              double.tryParse(value) == null) {
            return 'Please enter a correct price';
          }

          if (additionalValidator != null) {
            return additionalValidator!(value);
          }

          return null;
        });
  }
}

class FormNumberInputViewType extends FormViewType {
  final String key;
  final Icon? icon;
  final String label;
  final int? defaultValue;
  final String? Function(String?)? additionalValidator;

  FormNumberInputViewType({
    required this.key,
    this.icon,
    required this.label,
    this.defaultValue,
    this.additionalValidator,
  });

  @override
  FormViewModel getFormViewModel() {
    return FormViewModel(
        key: key,
        type: FormViewModelType.TEXT,
        keyboardType: const TextInputType.numberWithOptions(
            signed: false, decimal: false),
        icon: icon,
        label: label,
        defaultValue: defaultValue?.toString() ?? "0",
        validator: (value) {
          if (value == null ||
              value.isEmpty ||
              double.tryParse(value) == null) {
            return 'Please enter a correct number';
          }

          if (additionalValidator != null) {
            return additionalValidator!(value);
          }

          return null;
        });
  }
}

class FormTextInputViewType extends FormViewType {
  final String key;
  final Icon? icon;
  final String label;
  final String? defaultValue;
  final String? Function(String?)? additionalValidator;

  FormTextInputViewType({
    required this.key,
    this.icon,
    required this.label,
    this.defaultValue,
    this.additionalValidator,
  });

  @override
  FormViewModel getFormViewModel() {
    return FormViewModel(
        key: key,
        type: FormViewModelType.TEXT,
        keyboardType: TextInputType.text,
        icon: icon,
        label: label,
        defaultValue: defaultValue ?? "",
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a correct value';
          }

          if (additionalValidator != null) {
            return additionalValidator!(value);
          }

          return null;
        });
  }
}

class FormEmailInputViewType extends FormViewType {
  final String key;
  final Icon? icon;
  final String label;
  final String? defaultValue;

  FormEmailInputViewType({
    required this.key,
    this.icon,
    required this.label,
    this.defaultValue,
  });

  @override
  FormViewModel getFormViewModel() {
    return FormViewModel(
        key: key,
        type: FormViewModelType.TEXT,
        keyboardType: TextInputType.text,
        icon: icon,
        label: label,
        defaultValue: defaultValue ?? "",
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter an email address';
          }

          if (!RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(value)) {
            return 'Please enter a valid email address';
          }

          return null;
        });
  }
}

class FormSelectorInputViewType extends FormViewType {
  final String key;
  final List<String> items;
  final Icon? icon;
  final String label;
  final String? defaultValue;

  FormSelectorInputViewType({
    required this.key,
    required this.items,
    this.icon,
    required this.label,
    this.defaultValue,
  });

  @override
  FormViewModel getFormViewModel() {
    return FormViewModel(
        key: key,
        type: FormViewModelType.SELECTOR,
        keyboardType: TextInputType.text,
        icon: icon,
        label: label,
        defaultValue: items.contains(defaultValue) ? defaultValue : null,
        selectorItems: items,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select an item from the list';
          }

          return null;
        });
  }
}

class FormYearPickerViewType extends FormViewType {
  final String key;
  final Icon? icon;
  final String label;
  final int? defaultValue;

  FormYearPickerViewType({
    required this.key,
    this.icon,
    required this.label,
    this.defaultValue,
  });

  @override
  FormViewModel getFormViewModel() {
    return FormViewModel(
      key: key,
      type: FormViewModelType.YEAR_PICKER,
      keyboardType: TextInputType.text,
      icon: icon,
      label: label,
      defaultValue: defaultValue?.toString() ?? "0",
      validator: (value) {
        if (value == null || value.isEmpty || int.tryParse(value) == null) {
          return 'Please select a year';
        }

        return null;
      },
    );
  }
}

class FormViewModel {
  final String key;
  final FormViewModelType type;
  final TextInputType keyboardType;
  final Icon? icon;
  final String label;
  final String? defaultValue;
  final List<String> selectorItems;
  final String? Function(String?)? validator;

  FormViewModel({
    required this.key,
    required this.type,
    required this.keyboardType,
    this.icon,
    required this.label,
    this.defaultValue,
    this.selectorItems = const [],
    this.validator,
  });
}

enum FormViewModelType {
  TEXT,
  SELECTOR,
  YEAR_PICKER,
}
