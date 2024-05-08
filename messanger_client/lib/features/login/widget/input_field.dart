import 'package:flutter/material.dart';

Widget inputField(String hintText, TextEditingController controller,
    {isPassword = false, theme}) {
  var border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: const BorderSide(color: Colors.white));
  return TextField(
    style: theme.textTheme.bodyMedium,
    controller: controller,
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: theme.textTheme.bodyMedium,
      enabledBorder: border,
      focusedBorder: border,
    ),
    obscureText: isPassword,
  );
}
