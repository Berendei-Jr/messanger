import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:messanger_client/repositories/chat/abstract_chats_repository.dart';
import 'package:messanger_client/repositories/chat/models/models.dart';
import 'package:messanger_client/repositories/message/abstarct_message_repository.dart';
import 'package:messanger_client/repositories/message/models/message.dart';
import 'package:messanger_client/repositories/user/abstarct_user_repository.dart';
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
        final messages =
            GetIt.I<AbstractMessageRepository>().getMessagesList(chat.id);

        emit(ChatLoaded(chat: chat, messages));
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
          authorId: GetIt.I<AbstractUserRepository>().getMe().id,
          targetId: event.targetId,
          message: event.message,
          isBroadcast: event.isBroadcast,
          timestamp: DateTime.now(),
        );

        await chatsRepo.sendMessage(message, event.targetId);
        final messages = GetIt.I<AbstractMessageRepository>()
            .getMessagesList(event.targetId);

        emit(ChatUpdated(messages: messages));
      } catch (e) {
        emit(ChatLoadingFailure(exception: e));
      }
    });
  }

  final AbstractChatsRepository chatsRepo;
}
