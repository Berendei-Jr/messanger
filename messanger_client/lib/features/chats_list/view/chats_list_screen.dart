import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:messanger_client/features/chats_list/bloc/chats_list_bloc.dart';
import 'package:messanger_client/features/chats_list/widgets/widgets.dart';
import 'package:messanger_client/repositories/chat/abstract_chats_repository.dart';
import 'package:messanger_client/router/router.dart';
import 'package:talker_flutter/talker_flutter.dart';

@RoutePage()
class ChatsListScreen extends StatefulWidget {
  const ChatsListScreen({super.key});

  @override
  State<ChatsListScreen> createState() => _ChatsListScreenState();
}

class _ChatsListScreenState extends State<ChatsListScreen> {
  final _chatsListBloc = ChatsListBloc(GetIt.I<AbstractChatsRepository>());

  @override
  void initState() {
    _chatsListBloc.add(LoadChatsList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TalkerScreen(
                    talker: GetIt.I<Talker>(),
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.developer_mode,
            ),
          )
        ],
      ),
      body: RefreshIndicator(
          onRefresh: () async {
            final completer = Completer();
            _chatsListBloc.add(LoadChatsList(completer: completer));
            return completer.future;
          },
          child: BlocBuilder<ChatsListBloc, ChatsListState>(
              bloc: _chatsListBloc,
              builder: (context, state) {
                if (state is ChatsListLoaded) {
                  return ListView.separated(
                    itemCount: state.chatsList.length,
                    separatorBuilder: (context, index) => const Divider(
                      color: Colors.white70,
                      height: 1,
                    ),
                    itemBuilder: (context, i) {
                      final chat = state.chatsList[i];
                      return ChatTile(chat: chat, theme: theme);
                    },
                  );
                }
                if (state is ChatsListLoadingFailure) {
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Something went wrong... ${state.exception.toString()}',
                        style: theme.textTheme.headlineMedium
                            ?.copyWith(fontSize: 24, color: Colors.white70),
                      ),
                      Text(
                        'Please try again later',
                        style:
                            theme.textTheme.labelSmall?.copyWith(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      OutlinedButton(
                          onPressed: () {
                            _chatsListBloc.add(LoadChatsList());
                          },
                          child: const Text(
                            'Try again',
                            style: TextStyle(color: Colors.yellow),
                          ))
                    ],
                  ));
                }
                return const Center(child: CircularProgressIndicator());
              })),
      floatingActionButton: IconButton(
        color: Colors.white,
        iconSize: 40,
        tooltip: 'Create new chat',
        icon: const Icon(Icons.message),
        onPressed: () {
          AutoRouter.of(context).push(const UsersListRoute());
        },
      ),
    );
  }
}
