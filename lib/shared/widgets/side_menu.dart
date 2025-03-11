import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qr/config/config.dart';
import 'package:qr/src/src.dart';

class SideMenu extends ConsumerWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeNotifierProvider);
    final authNotifier = ref.read(authProvider.notifier);

    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Center(
                child: Text("Menú",
                    style: TextStyle(color: Colors.white, fontSize: 20))),
          ),

          // Botón Home
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            onTap: () {
              context.push(NamesRouter.homeScreen);
            },
          ),

          // Switch para cambiar el tema
          ListTile(
            leading: const Icon(Icons.dark_mode),
            title: const Text("Modo oscuro"),
            trailing: Switch(
              value: themeState.isDarkMode,
              onChanged: (value) {
                ref
                    .read(themeNotifierProvider.notifier)
                    .changeTheme(isDarkMode: value);
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
