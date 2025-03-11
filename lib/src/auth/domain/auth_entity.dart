import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String name;

  const AuthEntity({required this.name});

  @override
  List<Object?> get props => [name];
}
