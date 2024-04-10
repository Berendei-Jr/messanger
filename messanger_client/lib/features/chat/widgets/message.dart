import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:messanger_client/features/chat/widgets/chat_bubble.dart';
import 'package:messanger_client/repositories/message/models/models.dart';
import 'package:messanger_client/repositories/user/abstarct_user_repository.dart';
import 'package:messanger_client/repositories/user/models/models.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({
    super.key,
    required this.message,
  });

  final Message message;

  @override
  Widget build(BuildContext context) {
    final allignment =
        message.author == GetIt.I<AbstractUserRepository>().getMe().name
            ? Alignment.centerRight
            : Alignment.centerLeft;

    return Container(
        alignment: allignment,
        padding: const EdgeInsets.all(12),
        child: Column(children: [
          Text(
            message.author,
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
