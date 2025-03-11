import 'package:formz/formz.dart';

import '../constants/message_errors.dart';

//Propio

// Define input validation errors
enum NameError { empty, length, format }

// Extend FormzInput and provide the input type and error type.
class NameInput extends FormzInput<String, NameError> {
  static final RegExp nameRegExp = RegExp(
    r'^[a-zA-Z0-9\s,.:-]*$',
  );
  // Call super.pure to represent an unmodified form input.
  const NameInput.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const NameInput.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == NameError.empty) return MessageErros.campoRequerido;
    if (displayError == NameError.length) return MessageErros.minimo2caracteres;
    if (displayError == NameError.format) return MessageErros.invalidName;

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  NameError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return NameError.empty;
    if (value.length < 2) return NameError.length;
    if (!nameRegExp.hasMatch(value)) return NameError.format;

    return null;
  }
}
