import 'package:equatable/equatable.dart';

class ItemEntity extends Equatable {
  final String text;
  final String uuid;

  const ItemEntity({required this.text, required this.uuid});

  @override
  List<Object?> get props => [text, uuid];
}
