import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:messanger_client/features/chat/view/view.dart';
import 'package:messanger_client/features/chats_list/view/view.dart';
import 'package:messanger_client/features/login/view/login_screen.dart';
import 'package:messanger_client/features/users_list/crypto_list.dart';
import 'package:messanger_client/repositories/chat/models/models.dart';
import 'package:messanger_client/repositories/user/user.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginRoute.page, path: '/'),
        AutoRoute(page: ChatsListRoute.page),
        AutoRoute(page: ChatRoute.page),
        AutoRoute(page: UsersListRoute.page),
      ];
}
