import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messanger_client/repositories/chat/abstract_chats_repository.dart';
import 'package:messanger_client/repositories/chat/chat.dart';
import 'package:messanger_client/repositories/user/abstarct_user_repository.dart';
import 'package:messanger_client/repositories/user/user.dart';

part 'users_list_event.dart';
part 'users_list_state.dart';

class UsersListBloc extends Bloc<UsersListEvent, UsersListState> {
  UsersListBloc(this.chatsRepository, this.usersRepository)
      : super(UsersListInitial()) {
    on<LoadUsersList>((event, emit) async {
      try {
        if (state is! UsersListLoaded) {
          emit(UsersListLoading());
        }

        final usersList = await usersRepository.getUsersList();
        emit(UsersListLoaded(usersList: usersList));
      } catch (e) {
        emit(UsersListLoadingFailure(exception: e));
      } finally {
        event.completer?.complete();
      }
    });

    on<CreateChat>((event, emit) async {
      final chat = await chatsRepository.createChat(event.user!);
      emit(NewChatCreated(chat: chat));
    });
  }

  final AbstractChatsRepository chatsRepository;
  final AbstractUserRepository usersRepository;
}
