import 'package:flutter/material.dart';
import 'package:qr/shared/shared.dart';
import 'package:qr/src/src.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      drawer: const SideMenu(),
      body: const ItemsView(),
    );
  }
}
