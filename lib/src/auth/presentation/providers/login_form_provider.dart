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
  final Function(String, String) loginUserCallback;

  LoginFormNotifier({required this.loginUserCallback})
      : super(const LoginFormState());

  onNameChange(String value) {
    final name = NameInput.dirty(value);
    state = state.copyWith(
        name: name, isValid: Formz.validate([name, state.password]));
  }

  onPasswordChange(String value) {
    final newPassword = PasswordInput.dirty(value);
    state = state.copyWith(
        password: newPassword,
        isValid: Formz.validate([newPassword, state.name]));
  }

  _manipularValoresIniciales() {
    final name = NameInput.dirty(state.name.value);
    final password = PasswordInput.dirty(state.password.value);
    state = state.copyWith(
        isFormPosted: true,
        name: name,
        password: password,
        isValid: Formz.validate([name, password]));
  }

  Future<bool> onFormSubmitLogin() async {
    try {
      state = state.copyWith(isError: false);
      _manipularValoresIniciales();
      if (!state.isValid) return false;
      state = state.copyWith(isPosting: true);
      await loginUserCallback(state.name.value, state.password.value);
      state = state.copyWith(isPosting: false);
      return true;
    } catch (e) {
      print("Error en $e");
      state = state.copyWith(isError: true, isPosting: false);
      return false;
    }
  }
}

class LoginFormState extends Equatable {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final NameInput name;
  final PasswordInput password;
  final bool isError;

  const LoginFormState(
      {this.isPosting = false,
      this.isFormPosted = false,
      this.isValid = false,
      this.isError = false,
      this.name = const NameInput.pure(),
      this.password = const PasswordInput.pure()});

  LoginFormState copyWith(
          {bool? isPosting,
          bool? isFormPosted,
          bool? isValid,
          NameInput? name,
          PasswordInput? password,
          bool? isError}) =>
      LoginFormState(
          isPosting: isPosting ?? this.isPosting,
          isFormPosted: isFormPosted ?? this.isFormPosted,
          isValid: isValid ?? this.isValid,
          name: name ?? this.name,
          password: password ?? this.password,
          isError: isError ?? this.isError);

  @override
  List<Object?> get props =>
      [isPosting, isFormPosted, isValid, name, password, isError];
}
