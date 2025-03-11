import 'auth_entity.dart';

abstract class AuthRepository {
  Future<AuthEntity> login(String password);
  Future<AuthEntity> register(String password);
  Future<AuthEntity> checkAuthStatus();
  Future<AuthEntity> loginBiometric();
}
