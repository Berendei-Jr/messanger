import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:messanger_client/repositories/message/message.dart';
import 'package:messanger_client/repositories/user/user.dart';

part 'chat_model.g.dart';

@HiveType(typeId: 2)
class Chat extends Equatable {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final bool isGroup;

  @HiveField(3)
  final List<User> users;

  @HiveField(4)
  final List<Message> messages;

  const Chat({
    required this.id,
    required this.name,
    required this.isGroup,
    required this.users,
    required this.messages,
  });

  String getChatName() {
    if (isGroup) {
      return name;
    } else {
      return users.first.name;
    }
  }

  Widget? getChatIcon() {
    if (isGroup) {
      return const Icon(Icons.group);
    } else {
      return const Icon(Icons.person);
    }
  }

  @override
  List<Object?> get props => [id, name, isGroup, users, messages];
}
