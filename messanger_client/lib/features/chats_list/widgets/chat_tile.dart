import 'package:flutter/material.dart';
import 'package:messanger_client/repositories/chat/chat.dart';

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
      leading: const Icon(
        Icons.account_circle,
      ),
      title: Text(
        chat.id.toString(),
        style: theme.textTheme.bodyMedium,
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {},
    );
  }
}
