import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr/src/src.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(datasource: AuthDatasourceImpl());
});
