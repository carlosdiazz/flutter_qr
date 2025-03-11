import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr/src/src.dart';

final itemsRepositoryProvider = Provider<ItemRepository>((ref) {
  final itemRepository = ItemRepositoyImpl(datasource: ItemDatasouceImpl());

  return itemRepository;
});
