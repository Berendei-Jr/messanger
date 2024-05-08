part of 'login_bloc.dart';

abstract class LoginState extends Equatable {}

class LoginInitial extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginWaitingForInput extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginLoading extends LoginState {
  LoginLoading();

  @override
  List<Object?> get props => [];
}

class LoginLoaded extends LoginState {
  LoginLoaded();

  @override
  List<Object?> get props => [];
}

class LoginLoadingFailure extends LoginState {
  LoginLoadingFailure({required this.exception});
  final Object? exception;

  String getErrorMessage() {
    final dioException = exception as DioException;
    final excMsg = dioException.message;
    if (excMsg != null && excMsg.startsWith('The connection errored')) {
      return 'Unable to conenct to server...';
    }
    return dioException.response.toString();
  }

  @override
  List<Object?> get props => [exception];
}
