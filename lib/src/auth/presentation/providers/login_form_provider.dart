import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/shared.dart';
import '../../auth.dart';

final loginFormProvider =
    StateNotifierProvider.autoDispose<LoginFormNotifier, LoginFormState>((ref) {
  final loginUserCallBack = ref.watch(authProvider.notifier).login;

  return LoginFormNotifier(loginUserCallback: loginUserCallBack);
});

class LoginFormNotifier extends StateNotifier<LoginFormState> {
  final Function(String) loginUserCallback;

  LoginFormNotifier({required this.loginUserCallback})
      : super(const LoginFormState());

  onPasswordChange(String value) {
    final newPassword = PasswordInput.dirty(value);
    state = state.copyWith(
        password: newPassword, isValid: Formz.validate([newPassword]));
  }

  Future<ErrorMessageCustom> onFormSubmitLogin() async {
    _resetState();
    try {
      _manipularValoresIniciales();
      if (!state.isValid) {
        return ErrorMessageCustom(
            isError: true, messageError: "Formulario Invalido");
      }

      state = state.copyWith(isPosting: true);
      await loginUserCallback(state.password.value);
      state = state.copyWith(
        isPosting: false,
        isError: false,
        message: "Login Correcto",
      );
      return ErrorMessageCustom(isError: false, messageError: "Login Correcto");
    } catch (e) {
      print("Error en $e");
      state =
          state.copyWith(isError: true, isPosting: false, message: "Error $e");
      //Al cliente solo se le informa que es la clave
      return ErrorMessageCustom(
          isError: true, messageError: "Clave Incorrecta");
    }
  }

  _manipularValoresIniciales() {
    final password = PasswordInput.dirty(state.password.value);
    state = state.copyWith(
        isFormPosted: true,
        password: password,
        isValid: Formz.validate([password]));
  }

  _resetState() {
    state = state.copyWith(
      isError: false,
      message: "",
    );
  }
}

class LoginFormState extends Equatable {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final PasswordInput password;
  final bool isError;
  final String message;

  const LoginFormState(
      {this.isPosting = false,
      this.isFormPosted = false,
      this.isValid = false,
      this.isError = false,
      this.message = "",
      this.password = const PasswordInput.pure()});

  LoginFormState copyWith(
          {bool? isPosting,
          bool? isFormPosted,
          bool? isValid,
          PasswordInput? password,
          String? message,
          bool? isError}) =>
      LoginFormState(
          isPosting: isPosting ?? this.isPosting,
          isFormPosted: isFormPosted ?? this.isFormPosted,
          isValid: isValid ?? this.isValid,
          password: password ?? this.password,
          message: message ?? this.message,
          isError: isError ?? this.isError);

  @override
  List<Object?> get props =>
      [isPosting, isFormPosted, isValid, password, isError, message];
}
