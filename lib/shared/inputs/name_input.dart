import 'package:formz/formz.dart';
import 'package:qr/config/config.dart';

enum NameError { empty, length, format }

class NameInput extends FormzInput<String, NameError> {
  static final RegExp nameRegExp = RegExp(
    r'^[a-zA-Z0-9\s,.:-]*$',
  );

  const NameInput.pure() : super.pure('');

  const NameInput.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == NameError.empty) return MessageErros.campoRequerido;
    if (displayError == NameError.length) return MessageErros.minimo2caracteres;
    if (displayError == NameError.format) return MessageErros.invalidName;

    return null;
  }

  @override
  NameError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return NameError.empty;
    if (value.length < 2) return NameError.length;
    if (!nameRegExp.hasMatch(value)) return NameError.format;

    return null;
  }
}
