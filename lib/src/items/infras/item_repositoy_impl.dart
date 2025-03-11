import 'package:qr/src/src.dart';

class ItemRepositoyImpl extends ItemRepository {
  final ItemDatasource datasource;

  ItemRepositoyImpl({required this.datasource});

  @override
  Future<void> deleteAllItem() async {
    return await datasource.deleteAllItem();
  }

  @override
  Future<void> deleteOneItem(String uuid) async {
    return await datasource.deleteOneItem(uuid);
  }

  @override
  Future<List<ItemEntity>> getAllItem() async {
    return await datasource.getAllItem();
  }

  @override
  Future<void> createItem(ItemEntity entity) async {
    return await datasource.createItem(entity);
  }
}
