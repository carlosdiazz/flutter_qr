import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr/shared/widgets/empty_entity.dart';
import 'package:qr/src/src.dart';

class ItemsView extends ConsumerWidget {
  const ItemsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsState = ref.watch(itemsProvider);

    if (itemsState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (itemsState.isError) {
      return const Center(child: Text('Error loading items'));
    }

    if (itemsState.items.isEmpty) {
      return const EmptyEntity(message: "No tienes QrCode escaneado");
    }

    return ListView.builder(
      itemCount: itemsState.items.length,
      itemBuilder: (context, index) {
        final item = itemsState.items[index];
        return _Item(item: item);
      },
    );
  }
}

class _Item extends ConsumerWidget {
  const _Item({
    required this.item,
  });

  final ItemEntity item;

  @override
  Widget build(BuildContext context, ref) {
    final itemsProviderNotifier = ref.read(itemsProvider.notifier);
    return FadeIn(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  item.text,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete_forever_outlined),
                onPressed: () {
                  _borrar(context, itemsProviderNotifier, item.uuid);
                },
              ),
            ],
          ),
        ),
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
