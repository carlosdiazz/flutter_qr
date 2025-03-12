import 'dart:developer';

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr/src/src.dart';

class ItemDatasouceImpl extends ItemDatasource {
  late Future<Isar> db;

  ItemDatasouceImpl() {
    db = openDB();
  }

  ///  Función para abrir la base de datos de forma segura
  Future<Isar> openDB() async {
    try {
      final dir = await getApplicationDocumentsDirectory();

      // Si ya hay una instancia abierta, la usamos
      if (Isar.instanceNames.isNotEmpty) {
        log("🔄 Reutilizando instancia existente de Isar");
        return Future.value(Isar.getInstance());
      }

      // Cerrar Isar si ya estaba abierta
      await Isar.getInstance()?.close();

      // Abrir una nueva instancia
      log("📂 Abriendo Isar en: ${dir.path}");
      return await Isar.open(
        [ItemEntitySchema],
        directory: dir.path,
        inspector: false, //  Deshabilitar Inspector en producción
      );
    } catch (e) {
      log("Error al abrir la base de datos Isar: $e");
      rethrow;
    }
  }

  ///  Insertar o actualizar un item
  @override
  Future<void> createItem(ItemEntity entity) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.itemEntitys.put(entity);
    });

    final existingItem = await isar.itemEntitys.get(entity.isarId!);
    log("Item guardado: ${existingItem?.isarId}");
  }

  ///  Eliminar todos los elementos
  @override
  Future<void> deleteAllItem() async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.itemEntitys.clear();
    });
    log(" Todos los elementos han sido eliminados");
  }

  ///  Eliminar un elemento por UUID
  @override
  Future<void> deleteOneItem(String uuid) async {
    final isar = await db;
    await isar.writeTxn(() async {
      final item =
          await isar.itemEntitys.filter().uuidEqualTo(uuid).findFirst();
      if (item != null) {
        await isar.itemEntitys.delete(item.isarId!);
        log(" Eliminado item con UUID: $uuid");
      } else {
        log(" No se encontró el item con UUID: $uuid");
      }
    });
  }

  ///  Obtener todos los elementos
  @override
  Future<List<ItemEntity>> getAllItem() async {
    final isar = await db;
    return await isar.itemEntitys.where().findAll();
  }
}
