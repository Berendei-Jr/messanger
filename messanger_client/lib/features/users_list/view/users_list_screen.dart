import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:messanger_client/features/users_list/bloc/users_list_bloc.dart';
import 'package:messanger_client/features/users_list/widgets/widgets.dart';
import 'package:messanger_client/repositories/chat/abstract_chats_repository.dart';
import 'package:messanger_client/repositories/user/abstarct_user_repository.dart';
import 'package:messanger_client/router/router.dart';

@RoutePage()
class UsersListScreen extends StatefulWidget {
  const UsersListScreen({super.key});

  @override
  State<UsersListScreen> createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  final _UsersListBloc = UsersListBloc(
      GetIt.I<AbstractChatsRepository>(), GetIt.I<AbstractUserRepository>());

  @override
  void initState() {
    _UsersListBloc.add(LoadUsersList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Available users'),
        ),
        body: RefreshIndicator(
            onRefresh: () async {
              final completer = Completer();
              _UsersListBloc.add(LoadUsersList(completer: completer));
              return completer.future;
            },
            child: BlocBuilder<UsersListBloc, UsersListState>(
                bloc: _UsersListBloc,
                builder: (context, state) {
                  if (state is UsersListLoaded) {
                    return ListView.separated(
                      itemCount: state.usersList.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, i) {
                        final user = state.usersList[i];
                        return UserTile(
                            block: _UsersListBloc, user: user, theme: theme);
                      },
                    );
                  }
                  if (state is NewChatCreated) {
                    AutoRouter.of(context).push(ChatRoute(chat: state.chat));
                  }
                  if (state is UsersListLoadingFailure) {
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
                          style: theme.textTheme.labelSmall
                              ?.copyWith(fontSize: 16),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        OutlinedButton(
                            onPressed: () {
                              _UsersListBloc.add(LoadUsersList());
                            },
                            child: const Text(
                              'Try again',
                              style: TextStyle(color: Colors.yellow),
                            ))
                      ],
                    ));
                  }
                  return const Center(child: CircularProgressIndicator());
                })));
  }
}
