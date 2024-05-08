import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_list_view/flutter_list_view.dart';
import 'package:get_it/get_it.dart';
import 'package:messanger_client/features/chat/bloc/chat_bloc.dart';
import 'package:messanger_client/features/chat/widgets/message.dart';
import 'package:messanger_client/features/chat/widgets/message_input.dart';
import 'package:messanger_client/repositories/chat/abstract_chats_repository.dart';
import 'package:messanger_client/repositories/chat/models/models.dart';
import 'package:messanger_client/repositories/message/message.dart';

@RoutePage()
class ChatScreen extends StatefulWidget {
  ChatScreen({super.key, required this.chat});

  final Chat chat;
  late final Timer timer;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _ChatBloc = ChatBloc(GetIt.I<AbstractChatsRepository>());

  @override
  void initState() {
    _ChatBloc.add(LoadChat(chatName: widget.chat.name));
    widget.timer = Timer.periodic(
        const Duration(seconds: 1),
        (Timer t) => setState(() {
              this._ChatBloc.add(LoadChat(chatName: widget.chat.name));
            }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chat.getChatName()),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          final completer = Completer();
          _ChatBloc.add(
              LoadChat(completer: completer, chatName: widget.chat.name));
          return completer.future;
        },
        child: BlocBuilder<ChatBloc, ChatState>(
            bloc: _ChatBloc,
            builder: (context, state) {
              if (state is ChatLoaded) {
                if (state.messages.isEmpty) {
                  return const Center(child: Text('No messages yet'));
                }
                return _messagesList(state.messages);
              }
              if (state is ChatUpdated) {
                return _messagesList(state.messages);
              }
              if (state is ChatLoadingFailure) {
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Something went wrong...',
                      style: theme.textTheme.headlineMedium
                          ?.copyWith(fontSize: 24, color: Colors.white70),
                    ),
                    Text(
                      'Please try again later',
                      style: theme.textTheme.labelSmall?.copyWith(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    OutlinedButton(
                        onPressed: () {
                          _ChatBloc.add(LoadChat(chatName: widget.chat.name));
                        },
                        child: const Text(
                          'Try again',
                          style: TextStyle(color: Colors.yellow),
                        ))
                  ],
                ));
              }
              return const Center(child: CircularProgressIndicator());
            }),
      ),
      bottomSheet: MessageInput(bloc: _ChatBloc, chat: widget.chat),
    );
  }

  Widget _messagesList(List<Message> messages) {
    return FlutterListView(
        delegate: FlutterListViewDelegate(
      (BuildContext context, int index) => Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: MessageWidget(message: messages[index]),
      ),
      childCount: messages.length,
      initIndex: messages.length - 1,
      initOffset: 0,
    ));
  }

  @override
  void dispose() {
    widget.timer.cancel();
    super.dispose();
  }
}
