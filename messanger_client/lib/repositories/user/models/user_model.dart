import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class User extends Equatable {
  @JsonKey(name: 'username')
  @HiveField(0)
  final String name;

  @JsonKey(name: 'id')
  @HiveField(1)
  final int id;

  const User({
    required this.name,
    required this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @override
  List<Object?> get props => [
        name,
        id,
      ];
}

@HiveType(typeId: 1)
class Me extends User {
  @HiveField(2)
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
