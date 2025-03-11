import 'package:qr/src/auth/auth.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDatasource datasource;

  AuthRepositoryImpl({required this.datasource});

  @override
  Future<AuthEntity> checkAuthStatus() async {
    return await datasource.checkAuthStatus();
  }

  @override
  Future<AuthEntity> login(String password, String name) async {
    return await datasource.login(password, name);
  }

  @override
  Future<AuthEntity> register(String password, String name) async {
    return await datasource.register(password, name);
  }

  @override
  Future<AuthEntity> loginBiometric() async {
    return await datasource.loginBiometric();
  }
}
