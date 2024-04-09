import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class User extends Equatable {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final int id;

  const User({
    required this.name,
    required this.id,
  });

  @override
  List<Object?> get props => [
        name,
        id,
      ];
}

class Me extends User {
  final String authToken;

  const Me({
    required super.name,
    required super.id,
    required this.authToken,
  });

  @override
  List<Object?> get props => [
        name,
        id,
        authToken,
      ];
}
