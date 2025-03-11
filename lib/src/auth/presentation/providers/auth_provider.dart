import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';
import 'package:qr/src/auth/auth.dart';

enum AuthStatus { checking, authenticated, notAuthenticated }

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState());
}

class AuthState extends Equatable {
  final AuthStatus authStatus;
  final AuthEntity? authEntity;
  final String message;
  final bool isError;

  const AuthState(
      {this.authStatus = AuthStatus.checking,
      this.authEntity,
      this.message = "",
      this.isError = false});

  AuthState copyWith(
          {AuthStatus? authStatus,
          AuthEntity? authEntity,
          String? message,
          bool? isError}) =>
      AuthState(
          authStatus: authStatus ?? this.authStatus,
          authEntity: authEntity ?? this.authEntity,
          message: message ?? this.message,
          isError: isError ?? this.isError);

  @override
  List<Object?> get props => [
        authStatus,
        authEntity,
        message,
        isError,
      ];
}
