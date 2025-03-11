import 'package:qr/src/src.dart';

class ItemDatasouceImpl extends ItemDatasource {
  @override
  Future<void> createItem(ItemEntity item) async {
    print("IMPORTTtttttttttt!!!!!!!!!!!!!!!");
    print(item);
  }

  @override
  Future<void> deleteAllItem() async {}

  @override
  Future<void> deleteOneItem(String uuid) async {}

  @override
  Future<List<ItemEntity>> getAllItem() async {
    final List<ItemEntity> items = [];
    return items;
  }
}
