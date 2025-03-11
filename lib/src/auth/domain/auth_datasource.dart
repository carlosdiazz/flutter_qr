import 'auth_entity.dart';

abstract class AuthDatasource {
  Future<AuthEntity> login(String password);
  Future<AuthEntity> register(String password);

  Future<AuthEntity> loginBiometric();
  Future<AuthEntity> checkAuthStatus();
}
