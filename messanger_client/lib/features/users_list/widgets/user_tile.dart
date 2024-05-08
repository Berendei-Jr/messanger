import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:messanger_client/features/users_list/bloc/users_list_bloc.dart';
import 'package:messanger_client/repositories/user/user.dart';

class UserTile extends StatelessWidget {
  const UserTile({
    super.key,
    required this.user,
    required this.theme,
    required this.block,
  });

  final UsersListBloc block;
  final User user;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.person_3),
      title: Text(
        user.name,
        style: theme.textTheme.bodyMedium,
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        block.add(CreateChat(user: user));
      },
    );
  }
}
