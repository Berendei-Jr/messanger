import 'package:flutter/material.dart';
import 'package:messanger_client/features/chat/bloc/chat_bloc.dart';
import 'package:messanger_client/repositories/chat/models/chat.dart';

class MessageInput extends StatefulWidget {
  const MessageInput({
    super.key,
    required this.bloc,
    required this.chat,
  });

  final Chat chat;
  final ChatBloc bloc;

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Row(
      children: [
        TextField(
          decoration: InputDecoration(
            fillColor: Colors.grey.shade200,
            filled: true,
            constraints: BoxConstraints(maxWidth: width * 0.89),
            hintText: 'Message',
          ),
          controller: textController,
        ),
        Container(
            color: Colors.grey.shade200,
            child: IconButton(
              onPressed: () {
                widget.bloc.add(SendMessage(
                  message: textController.text,
                  target: widget.chat.getChatName(),
                  chatName: widget.chat.name,
                  isBroadcast: widget.chat.isGroup,
                ));
                textController.clear();
              },
              icon: const Icon(Icons.send),
            ))
      ],
    );
  }
}
