import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
            Color.fromARGB(255, 80, 80, 80),
            Color.fromARGB(255, 26, 25, 24),
          ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: _page(),
      ),
    );
  }

  Widget _page() {
    return Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _icon(),
            const SizedBox(
              height: 30,
            ),
            _inputField("Username", usernameController),
            const SizedBox(
              height: 10,
            ),
            _inputField("Password", passwordController, isPassword: true),
            const SizedBox(
              height: 30,
            ),
            _loginButton(),
            const SizedBox(
              height: 10,
            ),
            _registerButton(),
          ],
        )));
  }

  Widget _icon() {
    return const Icon(Icons.person, size: 120, color: Colors.white);
  }

  Widget _inputField(String hintText, TextEditingController controller,
      {isPassword = false}) {
    final theme = Theme.of(context);
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

  Widget _loginButton() {
    return ElevatedButton(
      onPressed: () {},
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

  Widget _registerButton() {
    return const Text(
      "Register",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 18,
      ),
    );
  }
}
