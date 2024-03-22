import 'package:crypto_monitor/router/router.dart';
import 'package:crypto_monitor/theme/theme.dart';
import 'package:flutter/material.dart';

class MessangerClientApp extends StatelessWidget {
  const MessangerClientApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto',
      theme: darkTheme,
      routes: routes,
    );
  }
}
