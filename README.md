<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

Make a simple form that can switch between editable and not editable mode from a simple class model.

## Features

Show a form that can be editable or not editable from a simple class model.
Act on result of the submitting the form.
No need to write a lot of code to make a simple form.

## Usage

Create a model class that extends from EditableModel.

```dart
class ForgetPasswordFormModel extends EditableModel<ForgetPasswordFormModel> {
  final String email;

  ForgetPasswordFormModel({required this.email});

  ForgetPasswordFormModel.fromJson(Map<String, Object?>? json)
      : this(
          email: json.getValueOr(
            name: 'email',
            defaultValue: "",
          ),
        );

  @override
  ForgetPasswordFormModel fromEditJson(Map<String, dynamic> json) =>
      ForgetPasswordFormModel.fromJson(json);

  @override
  List<FormViewType> getFormViewTypes() {
    return [
      FormEmailInputViewType(
        key: "email",
        label: "email:",
        icon: const Icon(Icons.email),
        defaultValue: email,
      ),
    ];
  }

  Map<String, Object?> toJson() {
    return {
      'email': email,
    };
  }
}
```

Create the form widget.

```dart
EditFormScreen<ForgetPasswordFormModel>(
          title: "Enter your email address",
          editableModel: ForgetPasswordFormModel(email: ""),
          onSubmit: (result) {
            debugPrint("onSubmit called. result:${result.toJson()}");
            
            // Do the process of submitting the form here.

            Navigator.pop(context);
          },
        ).showInDialog(context: context, title: "Reset Password")
```
