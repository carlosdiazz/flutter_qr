import 'package:qr/src/src.dart';

abstract class ItemDatasource {
  Future<List<ItemEntity>> getAllItem();
  Future<void> deleteAllItem();
  Future<void> deleteOneItem(String uuid);
  Future<void> createItem(ItemEntity item);
}
