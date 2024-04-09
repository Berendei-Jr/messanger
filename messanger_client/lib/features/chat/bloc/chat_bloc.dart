import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:messanger_client/repositories/chat/abstract_chats_repository.dart';
import 'package:messanger_client/repositories/chat/models/models.dart';
import 'package:messanger_client/repositories/message/models/message.dart';
import 'package:messanger_client/repositories/user/models/models.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc(this.chatsRepo) : super(ChatInitial()) {
    on<LoadChat>((event, emit) async {
      try {
        if (state is! ChatLoaded) {
          emit(ChatLoading());
        }

        final chatsList = await chatsRepo.getChatsList();
        final chat =
            chatsList.firstWhere((chat) => chat.name == event.chatName);
        emit(ChatLoaded(chat: chat));
      } catch (e) {
        emit(ChatLoadingFailure(exception: e));
      } finally {
        event.completer?.complete();
      }
    });

    on<SendMessage>((event, emit) async {
      try {
        if (state is ChatLoaded) {
          emit(ChatLoading());
        }

        Message message = Message(
          author: GetIt.I<Me>().name,
          target: event.target,
          message: event.message,
          isBroadcast: event.isBroadcast,
          timestamp: DateTime.now(),
        );

        final chat = await chatsRepo.sendMessage(message, event.chatName);

        emit(ChatLoaded(chat: chat));
      } catch (e) {
        emit(ChatLoadingFailure(exception: e));
      }
    });
  }

  final AbstractChatsRepository chatsRepo;
}
