import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message_model.g.dart';

@HiveType(typeId: 2)
@JsonSerializable()
class Message extends Equatable {
  @JsonKey(name: 'author_id', fromJson: _getAuthorName)
  @HiveField(0)
  final String author;

  @JsonKey(name: 'target_id', fromJson: _getTargetName)
  @HiveField(1)
  final String target;

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
    required this.author,
    required this.target,
    required this.isBroadcast,
    required this.message,
    required this.timestamp,
  });

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  static String _getAuthorName(int id) {
    return id.toString();
  }

  static String _getTargetName(int id) {
    return id.toString();
  }

  @override
  List<Object?> get props => [author, target, isBroadcast, timestamp];
}
