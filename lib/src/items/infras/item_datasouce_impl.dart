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
  Future<void> deleteAllItem() async {
    final isar = await db;
    // Elimina todos los elementos de la colección
    await isar.writeTxn(() async {
      await isar.itemEntitys.clear();
    });
    log("🚀 => Todos los elementos han sido eliminados");
  }

  @override
  Future<void> deleteOneItem(String uuid) async {
    final isar = await db;
    await isar.writeTxn(() async {
      final item =
          await isar.itemEntitys.filter().uuidEqualTo(uuid).findFirst();
      if (item != null && item.isarId != null) {
        await isar.itemEntitys.delete(item.isarId!);
        log("🚀 => Se eliminó el item con UUID: $uuid");
      } else {
        log("❌ => No se encontró el item con UUID: $uuid");
      }
    });
  }

  @override
  Future<List<ItemEntity>> getAllItem() async {
    final isar = await db;
    return await isar.itemEntitys.where().findAll();
  }
}
