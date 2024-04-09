import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:messanger_client/features/chat/view/view.dart';
import 'package:messanger_client/features/chats_list/view/view.dart';
import 'package:messanger_client/repositories/chat/models/models.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: ChatsListRoute.page, path: '/'),
        AutoRoute(page: ChatRoute.page),
      ];
}
