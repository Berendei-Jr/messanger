import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messanger_client/repositories/chat/abstract_chats_repository.dart';
import 'package:messanger_client/repositories/chat/chat.dart';

part 'chats_list_event.dart';
part 'chats_list_state.dart';

class ChatsListBloc extends Bloc<ChatsListEvent, ChatsListState> {
  ChatsListBloc(this.chatsRepository) : super(ChatsListInitial()) {
    on<LoadChatsList>((event, emit) async {
      try {
        if (state is! ChatsListLoaded) {
          emit(ChatsListLoading());
        }

        final chatsList = await chatsRepository.getChatsList();
        emit(ChatsListLoaded(chatsList: chatsList));
      } catch (e) {
        emit(ChatsListLoadingFailure(exception: e));
      } finally {
        event.completer?.complete();
      }
    });
  }

  final AbstractChatsRepository chatsRepository;
}
