import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qr/config/config.dart';
import 'package:qr/src/auth/auth.dart';

class LoginBiometricScreen extends ConsumerStatefulWidget {
  const LoginBiometricScreen({super.key});

  @override
  ConsumerState<LoginBiometricScreen> createState() =>
      _LoginBiometricScreenState();
}

class _LoginBiometricScreenState extends ConsumerState<LoginBiometricScreen> {
  @override
  void initState() {
    ref.read(authProvider.notifier).loginBiometric();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _LoginForm(),
    );
  }
}

class _LoginForm extends ConsumerWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context, ref) {
    ref.read(goRouterNotifierProvider).authStatus;

    final colors = Theme.of(context).colorScheme;
    final authNotifier = ref.read(authProvider.notifier);

    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          const SizedBox(
            height: 150,
          ),
          const Icon(
            Icons.person,
            size: 150,
          ),
          Text(
            'Login',
            style: TextStyle(color: colors.primary, fontSize: 30),
          ),
          const SizedBox(height: 100),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: FilledButton(
              onPressed: () async {
                await authNotifier.loginBiometric();
              },
              child: const Text("Ingresar con Biometría"),
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Ingresar con clave'),
              TextButton(
                  onPressed: () {
                    context.pushNamed(NamesRouter.loginFormScreen);
                  },
                  child: const Text('Cambiar a clave'))
            ],
          ),
        ],
      ),
    );
  }
}
