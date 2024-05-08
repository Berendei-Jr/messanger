import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messanger_client/features/login/bloc/login_bloc.dart';
import 'package:messanger_client/features/login/widget/widgets.dart';
import 'package:messanger_client/router/router.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _LoginBloc = LoginBloc();

  @override
  void initState() {
    _LoginBloc.add(TryLoginWithCachedCredentials());
    super.initState();
  }

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
        body: _page(context),
      ),
    );
  }

  Widget _page(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<LoginBloc, LoginState>(
        bloc: _LoginBloc,
        builder: (context, state) {
          if (state is LoginWaitingForInput) {
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
                    inputField("Username", usernameController,
                        theme: Theme.of(context)),
                    const SizedBox(
                      height: 10,
                    ),
                    inputField("Password", passwordController,
                        isPassword: true, theme: Theme.of(context)),
                    const SizedBox(
                      height: 30,
                    ),
                    loginButton(
                        _LoginBloc, usernameController, passwordController),
                    const SizedBox(
                      height: 15,
                    ),
                    registerButton(
                        _LoginBloc, usernameController, passwordController),
                  ],
                )));
          }
          if (state is LoginLoaded) {
            AutoRouter.of(context).push(const ChatsListRoute());
          }
          if (state is LoginLoadingFailure) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Something went wrong:',
                  style: theme.textTheme.headlineMedium
                      ?.copyWith(fontSize: 24, color: Colors.white70),
                ),
                Text(
                  state.getErrorMessage(),
                  style: theme.textTheme.labelSmall?.copyWith(fontSize: 16),
                ),
                const SizedBox(
                  height: 30,
                ),
                OutlinedButton(
                    onPressed: () {
                      _LoginBloc.add(WaitForInput());
                    },
                    child: const Text(
                      'Try again',
                      style: TextStyle(color: Colors.yellow),
                    ))
              ],
            ));
          }
          return const Center(child: CircularProgressIndicator());
        });
  }

  Widget _icon() {
    return const Icon(Icons.person, size: 120, color: Colors.white);
  }
}
