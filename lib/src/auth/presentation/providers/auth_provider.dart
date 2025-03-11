import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';
import 'package:qr/src/auth/auth.dart';

enum AuthStatus { checking, authenticated, notAuthenticated }

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);

  return AuthNotifier(authRepository: authRepository);
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;

  AuthNotifier({required this.authRepository}) : super(const AuthState()) {
    checkAuthStatus();
  }

  Future<void> login(
    String password,
  ) async {
    try {
      final authEntity = await authRepository.login(
        password,
      );
      _setLoggedUser(authEntity);
    } catch (e) {
      _setError();
    }
  }

  Future<void> logout() async {
    try {
      state = state.copyWith(
          authEntity: null,
          authStatus: AuthStatus.notAuthenticated,
          isError: false,
          loading: false,
          message: "Logout");
    } catch (e) {
      _setError();
    }
  }

  Future<void> loginBiometric() async {
    try {
      final authEntity = await authRepository.loginBiometric();
      _setLoggedUser(authEntity);
    } catch (e) {
      _setError();
    }
  }

  Future<void> checkAuthStatus() async {
    state = state.copyWith(loading: true);
    try {
      final authEntity = await authRepository.checkAuthStatus();
      _setLoggedUser(authEntity);
    } catch (e) {
      _setError();
    }
  }

  void _setLoggedUser(AuthEntity authEntity) async {
    state = state.copyWith(
        authEntity: authEntity,
        message: "ok",
        isError: false,
        loading: false,
        authStatus: AuthStatus.authenticated);
  }

  void _setError() async {
    state = state.copyWith(
        authEntity: null,
        authStatus: AuthStatus.notAuthenticated,
        isError: true,
        loading: false,
        message: "Error");
  }
}

class AuthState extends Equatable {
  final AuthStatus authStatus;
  final AuthEntity? authEntity;
  final String message;
  final bool isError;
  final bool loading;

  const AuthState({
    this.authStatus = AuthStatus.checking,
    this.authEntity,
    this.message = "",
    this.isError = false,
    this.loading = false,
  });

  AuthState copyWith(
          {AuthStatus? authStatus,
          AuthEntity? authEntity,
          String? message,
          bool? loading,
          bool? isError}) =>
      AuthState(
          authStatus: authStatus ?? this.authStatus,
          authEntity: authEntity ?? this.authEntity,
          loading: loading ?? this.loading,
          message: message ?? this.message,
          isError: isError ?? this.isError);

  @override
  List<Object?> get props => [
        authStatus,
        authEntity,
        message,
        isError,
        loading,
      ];
}
