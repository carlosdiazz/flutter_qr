import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:qr/config/config.dart';
import 'package:qr/src/src.dart';

class SideMenu extends ConsumerWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final themeState = ref.watch(themeNotifierProvider);
    final themeState = context.watch<ThemeBloc>().state;
    final authNotifier = ref.read(authProvider.notifier);

    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue), child: Center()),

          // Botón Home
          const ListTile(
            leading: Icon(Icons.home),
            title: Text("Home"),
            onTap: null,
          ),

          // Switch para cambiar el tema
          ListTile(
            leading: const Icon(Icons.dark_mode),
            title: const Text("Modo oscuro"),
            trailing: Switch(
              value: themeState.isDarkMode,
              onChanged: (value) {
                // Cambiar el tema usando el Bloc
                context
                    .read<ThemeBloc>()
                    .add(ChangeThemeEvent(isDarkMode: value));
              },
            ),
          ),

          // Botón de Logout
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text("Cerrar sesión"),
            onTap: () {
              authNotifier.logout();
            },
          ),
        ],
      ),
    );
  }
}
