import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qr/config/config.dart';

import '../presentation.dart';

class LoginFormScreen extends StatelessWidget {
  const LoginFormScreen({super.key});

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
    final loginForm = ref.watch(loginFormProvider);

    final colors = Theme.of(context).colorScheme;
    final form = ref.read(loginFormProvider.notifier);

    return Padding(
      padding: const EdgeInsets.all(30),
      child: ListView(
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
          const SizedBox(height: 40),
          CustomTextFormField(
            label: 'Name',
            keyboardType: TextInputType.name,
            onChanged: form.onNameChange,
            errorMessage:
                loginForm.isFormPosted ? loginForm.name.errorMessage : null,
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            label: 'Contraseña',
            obscureText: true,
            onChanged: form.onPasswordChange,
            onFieldSubmitted: (_) => form.onFormSubmitLogin(),
            errorMessage:
                loginForm.isFormPosted ? loginForm.password.errorMessage : null,
          ),
          const SizedBox(height: 30),
          SizedBox(
              width: double.infinity,
              height: 60,
              child: FilledButton(
                onPressed: () {
                  if (loginForm.isPosting) return;
                  ref.read(loginFormProvider.notifier).onFormSubmitLogin();
                },
                child: const Text("Ingresar"),
              )),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Ingresar con Datos Biometricos'),
              TextButton(
                  onPressed: () {
                    context.pushNamed(NamesRouter.loginBiometricScreen);
                  },
                  child: const Text('Cambiar'))
            ],
          ),
        ],
      ),
    );
  }
}
