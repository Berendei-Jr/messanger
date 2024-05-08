part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {}

class TryLoginWithCachedCredentials extends LoginEvent {
  @override
  List<Object?> get props => [];
}

class WaitForInput extends LoginEvent {
  @override
  List<Object?> get props => [];
}

class LoginEventWithUserInput extends LoginEvent {
  LoginEventWithUserInput(
      {this.completer, required this.login, required this.password});
  final Completer? completer;
  final String login;
  final String password;

  @override
  List<Object?> get props => [];
}

class TryLogin extends LoginEventWithUserInput {
  TryLogin({super.completer, required super.login, required super.password});

  @override
  List<Object?> get props => [completer, login, password];
}

class TryRegister extends LoginEventWithUserInput {
  TryRegister({super.completer, required super.login, required super.password});

  @override
  List<Object?> get props => [completer, login, password];
}
