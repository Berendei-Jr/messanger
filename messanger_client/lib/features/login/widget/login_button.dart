import 'dart:async';

import 'package:flutter/material.dart';
import 'package:messanger_client/features/login/bloc/login_bloc.dart';

Widget loginButton(
    LoginBloc loginBloc,
    TextEditingController usernameController,
    TextEditingController passwordController) {
  return ElevatedButton(
    onPressed: () async {
      if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
        throw Exception('Username or password is empty');
      }
      final completer = Completer();
      loginBloc.add(TryLogin(
          completer: completer,
          login: usernameController.text,
          password: passwordController.text));
      return completer.future;
    },
    style: ElevatedButton.styleFrom(
      shape: const StadiumBorder(),
      padding: const EdgeInsets.symmetric(vertical: 15),
    ),
    child: const SizedBox(
        width: double.infinity,
        child: Text(
          "Sign in",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, color: Colors.black),
        )),
  );
}
