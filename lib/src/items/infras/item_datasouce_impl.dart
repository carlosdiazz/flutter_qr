import 'dart:developer';

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr/src/src.dart';

class ItemDatasouceImpl extends ItemDatasource {
  late Future<Isar> db;

  ItemDatasouceImpl() {
    db = openDB();
  }
  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([ItemEntitySchema], directory: dir.path);
    }
    return Future.value(Isar.getInstance());
  }

  @override
  Future<void> createItem(ItemEntity entity) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.itemEntitys.put(entity); // insert & update
    });
    final existingUser = await isar.itemEntitys.get(entity.isarId!);
    log("🚀 => ItemDatasouceImpl => Future<void>createItem => existingUser: ${existingUser?.isarId}");
  }

  @override
  Future<void> deleteAllItem() async {}

  @override
  Future<void> deleteOneItem(String uuid) async {}

  @override
  Future<List<ItemEntity>> getAllItem() async {
    final isar = await db;
    return await isar.itemEntitys.where().findAll();
  }
}
