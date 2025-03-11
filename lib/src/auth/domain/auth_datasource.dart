import 'auth_entity.dart';

abstract class AuthDatasource {
  Future<AuthEntity> login(String password, String name);
  Future<AuthEntity> register(String password, String name);
  Future<AuthEntity> checkAuthStatus();
}
