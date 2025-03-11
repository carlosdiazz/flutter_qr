import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr/src/src.dart';

class ItemsView extends ConsumerWidget {
  const ItemsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsState = ref.watch(itemsProvider);

    return itemsState.isLoading
        ? const Center(child: CircularProgressIndicator())
        : itemsState.isError
            ? const Center(child: Text('Error loading items'))
            : ListView.builder(
                itemCount: itemsState.items.length,
                itemBuilder: (context, index) {
                  final item = itemsState.items[index];
                  return ListTile(
                    title: Text(item.text),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        ref.read(itemsProvider.notifier).deleteItem(item.uuid);
                      },
                    ),
                  );
                },
              );
  }
}
