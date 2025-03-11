import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';
part 'item_entity.g.dart';

@collection
class ItemEntity {
  Id? isarId;
  final String text;
  final String uuid;

  ItemEntity({required this.text, required this.uuid});
  // Convierte el objeto a un Map
  // Map<String, dynamic> toJson() {
  //   return {
  //     'text': text,
  //     'uuid': uuid,
  //   };
  // }

  // Crea un objeto desde un Map
  // factory ItemEntity.fromJson(Map<String, dynamic> json) {
  //   return ItemEntity(
  //     text: json['text'],
  //     uuid: json['uuid'],
  //   );
  // }
  // @ignore
  // @override
  // List<Object?> get props => [text, uuid];
}
