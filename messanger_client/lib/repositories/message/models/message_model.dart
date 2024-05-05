import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:messanger_client/repositories/user/abstarct_user_repository.dart';

part 'message_model.g.dart';

@HiveType(typeId: 2)
@JsonSerializable()
class Message extends Equatable {
  @JsonKey(name: 'author_id')
  @HiveField(0)
  final int authorId;

  @JsonKey(name: 'chat_id')
  @HiveField(1)
  final int targetId;

  @JsonKey(name: 'is_group_message')
  @HiveField(2)
  final bool isBroadcast;

  @JsonKey(name: 'message_text')
  @HiveField(3)
  final String message;

  @JsonKey(name: 'timestamp')
  @HiveField(4)
  final DateTime timestamp;

  const Message({
    required this.authorId,
    required this.targetId,
    required this.isBroadcast,
    required this.message,
    required this.timestamp,
  });

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  @override
  List<Object?> get props => [authorId, targetId, isBroadcast, timestamp];
}
