import 'package:qr/src/src.dart';

class ItemDatasouceImpl extends ItemDatasource {
  @override
  Future<void> createItem(ItemEntity item) async {}

  @override
  Future<void> deleteAllItem() async {}

  @override
  Future<void> deleteOneItem(String uuid) async {}

  @override
  Future<List<ItemEntity>> getAllItem() async {
    final List<ItemEntity> items = [
      const ItemEntity(text: "1", uuid: "1"),
      const ItemEntity(text: "1", uuid: "1"),
      const ItemEntity(text: "1", uuid: "1"),
      const ItemEntity(text: "1", uuid: "1"),
      const ItemEntity(text: "1", uuid: "1")
    ];
    return items;
  }
}
