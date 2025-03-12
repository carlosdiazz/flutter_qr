import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmptyEntity extends ConsumerWidget {
  final String message;
  final IconData icon;
  const EmptyEntity(
      {super.key, required this.message, this.icon = Icons.gamepad});

  @override
  Widget build(BuildContext context, ref) {
    final colors = Theme.of(context).colorScheme;
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spin(
              infinite: true,
              child: Icon(
                icon,
                size: 60,
                color: colors.primary,
              ),
            ),
            Text(
              "Ohhh noo!!",
              style: TextStyle(fontSize: 20, color: colors.primary),
            ),
            Text(
              message,
              style: TextStyle(fontSize: 15, color: colors.secondary),
            ),
          ]),
    );
  }
}
