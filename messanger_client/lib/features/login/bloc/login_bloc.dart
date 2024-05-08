import 'dart:async';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:messanger_client/repositories/user/abstarct_user_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<WaitForInput>((event, emit) async {
      emit(LoginWaitingForInput());
    });

    on<TryLoginWithCachedCredentials>((event, emit) async {
      emit(LoginLoading());
      if (!GetIt.I<AbstractUserRepository>().loginWithCachedCredentials()) {
        emit(LoginWaitingForInput());
      } else {
        emit(LoginLoaded());
      }
    });

    on<TryLogin>((event, emit) async {
      try {
        if (state is! LoginLoaded) {
          emit(LoginLoading());
        }

        final logginSuccessful = await GetIt.I<AbstractUserRepository>()
            .login(event.login, event.password);

        if (!logginSuccessful) {
          throw Exception('Login failed');
        }

        emit(LoginLoaded());
      } catch (e) {
        emit(LoginLoadingFailure(exception: e));
      } finally {
        event.completer?.complete();
      }
    });

    on<TryRegister>((event, emit) async {
      try {
        if (state is LoginLoaded) {
          emit(LoginLoading());
        }

        final registerSuccessful = await GetIt.I<AbstractUserRepository>()
            .register(event.login, event.password);

        if (!registerSuccessful) {
          throw Exception('Register failed');
        }

        emit(LoginLoaded());
      } catch (e) {
        emit(LoginLoadingFailure(exception: e));
      }
    });
  }
}
