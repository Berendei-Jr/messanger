import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    color: Color.fromARGB(255, 23, 23, 23),
    elevation: 0,
    titleTextStyle: TextStyle(
        color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 25),
    iconTheme: IconThemeData(color: Colors.white70),
  ),
  scaffoldBackgroundColor: const Color.fromARGB(255, 23, 23, 23),
  colorScheme:
      ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 255, 234, 0)),
  useMaterial3: true,
  listTileTheme: const ListTileThemeData(iconColor: Colors.white),
  textTheme: const TextTheme(
      bodyMedium: TextStyle(
          color: Colors.white, fontWeight: FontWeight.w400, fontSize: 23),
      labelSmall: TextStyle(
          color: Colors.white, fontWeight: FontWeight.w200, fontSize: 15)),
);
