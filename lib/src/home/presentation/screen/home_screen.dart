import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr/shared/shared.dart';
import 'package:qr/src/src.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          // Icono de zafacón en la esquina
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => {ref.read(itemsProvider.notifier).deleteAlltems()},
          ),
        ],
      ),
      drawer: const SideMenu(),
      body: const ItemsView(),
      floatingActionButton: const ScanButton(), //TODO
    );
  }
}
