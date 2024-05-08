import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:messanger_client/features/login/bloc/login_bloc.dart';

Widget registerButton(
    LoginBloc loginBloc,
    TextEditingController usernameController,
    TextEditingController passwordController) {
  return RichText(
      text: TextSpan(
    children: <TextSpan>[
      TextSpan(
          text: 'Register',
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () async {
              final completer = Completer();
              loginBloc.add(TryRegister(
                  completer: completer,
                  login: usernameController.text,
                  password: passwordController.text));
              return completer.future;
            }),
    ],
  ));
}
