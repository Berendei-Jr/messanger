import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:messanger_client/features/chat/widgets/chat_bubble.dart';
import 'package:messanger_client/repositories/message/models/models.dart';
import 'package:messanger_client/repositories/user/abstarct_user_repository.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({
    super.key,
    required this.message,
  });

  final Message message;

  @override
  Widget build(BuildContext context) {
    final myMessage =
        message.authorId == GetIt.I<AbstractUserRepository>().getMe().id;
    final allignment = myMessage ? Alignment.centerRight : Alignment.centerLeft;
    final authorName = myMessage
        ? 'You'
        : GetIt.I<AbstractUserRepository>().getUser(message.authorId)!.name;

    return Container(
        alignment: allignment,
        padding: const EdgeInsets.all(12),
        child: Column(children: [
          Text(
            authorName,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          ChatBubble(
            message: message.message,
          ),
          Text(
            DateFormat.Hm().format(message.timestamp),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ]));
  }
}
