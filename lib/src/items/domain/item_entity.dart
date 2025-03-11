import 'package:equatable/equatable.dart';

class ItemEntity extends Equatable {
  final String text;
  final String uuid;

  const ItemEntity({required this.text, required this.uuid});
  // Convierte el objeto a un Map
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'uuid': uuid,
    };
  }

  // Crea un objeto desde un Map
  factory ItemEntity.fromJson(Map<String, dynamic> json) {
    return ItemEntity(
      text: json['text'],
      uuid: json['uuid'],
    );
  }

  @override
  List<Object?> get props => [text, uuid];
}
