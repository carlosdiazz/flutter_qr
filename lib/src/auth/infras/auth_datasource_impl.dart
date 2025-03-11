import 'package:qr/src/auth/auth.dart';

class AuthDatasourceImpl extends AuthDatasource {
  @override
  Future<AuthEntity> checkAuthStatus() {
    // TODO: implement checkAuthStatus
    throw UnimplementedError();
  }

  @override
  Future<AuthEntity> login(String password, String name) async {
    //TODOOoooo
    final AuthEntity auth = AuthEntity(name: "sd");
    return auth;
  }

  @override
  Future<AuthEntity> register(String password, String name) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
