import 'package:qr/src/auth/auth.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDatasource datasource;

  AuthRepositoryImpl({required this.datasource});

  @override
  Future<AuthEntity> checkAuthStatus() async {
    return await datasource.checkAuthStatus();
  }

  @override
  Future<AuthEntity> login(String password) async {
    return await datasource.login(
      password,
    );
  }

  @override
  Future<AuthEntity> register(
    String password,
  ) async {
    return await datasource.register(password);
  }

  @override
  Future<AuthEntity> loginBiometric() async {
    return await datasource.loginBiometric();
  }
}
