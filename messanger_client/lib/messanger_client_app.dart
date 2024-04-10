import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:messanger_client/features/login/view/login_page.dart';
import 'package:messanger_client/router/router.dart';
import 'package:messanger_client/theme/theme.dart';
import 'package:talker_flutter/talker_flutter.dart';

class MessangerClientApp extends StatefulWidget {
  const MessangerClientApp({super.key});

  @override
  State<MessangerClientApp> createState() => _MessangerClientAppState();
}

class _MessangerClientAppState extends State<MessangerClientApp> {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Crypto',
      theme: darkTheme,
      routerConfig: _appRouter.config(
        navigatorObservers: () => [TalkerRouteObserver(GetIt.I<Talker>())],
      ),
    );

    /*return MaterialApp(
      title: 'Crypto',
      theme: darkTheme,
      home: LoginPage(),
    );*/
  }
}
