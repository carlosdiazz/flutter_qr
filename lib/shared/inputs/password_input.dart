import 'package:formz/formz.dart';
import 'package:qr/config/config.dart';

enum PasswordError { empty, length, format }

class PasswordInput extends FormzInput<String, PasswordError> {
  static final RegExp passwordRegExp = RegExp(
    r'(?:(?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$',
  );

  const PasswordInput.pure() : super.pure('');

  const PasswordInput.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == PasswordError.empty) return MessageErros.campoRequerido;
    if (displayError == PasswordError.length) {
      return MessageErros.minimo4caracteres;
    }
    if (displayError == PasswordError.format) {
      return MessageErros.invalidPassword;
    }

    return null;
  }

  @override
  PasswordError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return PasswordError.empty;
    if (value.length < 4) return PasswordError.length;

    return null;
  }
}
