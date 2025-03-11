import 'package:local_auth/local_auth.dart';
import 'package:qr/src/auth/auth.dart';

class AuthDatasourceImpl extends AuthDatasource {
  final LocalAuthentication auth = LocalAuthentication();

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

  @override
  Future<AuthEntity> loginBiometric() async {
    try {
      bool canCheckBiometrics = await auth.canCheckBiometrics;
      bool isDeviceSupported = await auth.isDeviceSupported();

      if (!canCheckBiometrics || !isDeviceSupported) {
        throw Exception("Biometría no soportada");
      }

      bool authenticated = await auth.authenticate(
        localizedReason: 'Escanea tu huella para ingresar',
        options: const AuthenticationOptions(biometricOnly: true),
      );

      if (authenticated) {
        return const AuthEntity(name: "Usuario Biometrico");
      } else {
        throw Exception("Autenticación fallida");
      }
    } catch (e) {
      throw Exception("Error en biometría: ");
    }
  }
}
