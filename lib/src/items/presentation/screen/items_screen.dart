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
                  return _ListTile(item: item);
                },
              );
  }
}

class _ListTile extends ConsumerWidget {
  const _ListTile({
    required this.item,
  });

  final ItemEntity item;

  @override
  Widget build(BuildContext context, ref) {
    final itemsProviderNotifier = ref.read(itemsProvider.notifier);
    return ListTile(
      title: Text(item.text),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          _borrar(context, itemsProviderNotifier, item.uuid);
        },
      ),
    );
  }

  void _borrar(BuildContext context, ItemsNotifier itemsProviderNotifier,
      String uuid) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final errorMessage = await itemsProviderNotifier.deleteItem(uuid);

    scaffoldMessenger.showSnackBar(
      SnackBar(content: Text(errorMessage.messageError)),
    );
  }
}
