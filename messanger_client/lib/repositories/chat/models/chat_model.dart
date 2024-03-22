import 'package:equatable/equatable.dart';
import 'package:messanger_client/repositories/message/message.dart';
import 'package:messanger_client/repositories/user/user.dart';

class Chat extends Equatable {
  final int id;
  final bool isGroup;
  final List<User> users;
  final List<Message> messages;

  const Chat({
    required this.id,
    required this.isGroup,
    required this.users,
    required this.messages,
  });

  @override
  List<Object?> get props => [id, isGroup, users, messages];
}
