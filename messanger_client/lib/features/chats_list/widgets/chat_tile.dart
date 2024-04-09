import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:messanger_client/repositories/chat/chat.dart';
import 'package:messanger_client/router/router.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({
    super.key,
    required this.chat,
    required this.theme,
  });

  final Chat chat;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: chat.getChatIcon(),
      title: Text(
        chat.getChatName(),
        style: theme.textTheme.bodyMedium,
      ),
      onTap: () {
        AutoRouter.of(context).push(ChatRoute(chat: chat));
      },
    );
  }
}
