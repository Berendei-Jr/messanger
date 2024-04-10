import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:messanger_client/repositories/chat/abstract_chats_repository.dart';
import 'package:messanger_client/repositories/chat/models/models.dart';
import 'package:messanger_client/repositories/message/models/models.dart';
import 'package:messanger_client/repositories/user/abstarct_user_repository.dart';
import 'package:messanger_client/repositories/user/user.dart';
import 'package:talker_flutter/talker_flutter.dart';

class ChatsRepository implements AbstractChatsRepository {
  ChatsRepository(
      {required this.dio, required this.serverUrl, required this.chatsBox});

  final Box<Chat> chatsBox;
  final String serverUrl;
  final Dio dio;

  @override
  Future<Chat> sendMessage(Message message, String chatName) async {
    try {
      dio.options.headers['Authorization'] = await _getTokenHeader();

      final response = await dio.post(
        '$serverUrl/message',
        data: {
          'author': message.author,
          'target': message.target,
          'is_group_message': message.isBroadcast,
          'message_text': message.message,
        },
      );

      if (response.statusCode != 202) {
        throw Exception('Server error code: ${response.statusCode}');
      }

      for (var chat in chatsBox.values.toList()) {
        if (chat.name == chatName) {
          chat.messages.add(message);
          return chat;
        }
      }
      throw Exception('Chat not found');
    } catch (e) {
      GetIt.I<Talker>().handle(e);
      rethrow;
    }
  }

  @override
  Future<List<Chat>> getChatsList() async {
    try {
      await _fetchMessagesFromServer();
    } catch (e) {
      GetIt.I<Talker>().handle(e);
    }

    return chatsBox.values.toList();
  }

  Future<void> _fetchMessagesFromServer() async {
    try {
      dio.options.headers['Authorization'] = await _getTokenHeader();

      final response = await dio.post(
        '$serverUrl/get_messages',
        data: {},
      );

      if (response.statusCode == 204) {
        return;
      }

      if (response.statusCode != 200) {
        throw Exception('Server error code: ${response.statusCode}');
      }

      GetIt.I<Talker>().debug(
        response.data.toString(),
      );

      final data = response.data as Map<String, dynamic>;
      final newMessagesList = data.entries.map((e) {
        final details = Message.fromJson(e.value as Map<String, dynamic>);
        return details;
      }).toList();

      var parsedMessages = [];
      for (var message in newMessagesList) {
        for (var chat in chatsBox.values.toList()) {
          if (chat.name == message.author &&
              chat.isGroup == message.isBroadcast) {
            chat.messages.add(message);
            parsedMessages.add(message);
          }
        }
      }

      for (var message in newMessagesList) {
        if (parsedMessages.contains(message)) {
          continue;
        }
        final chat = Chat(
            id: chatsBox.values.length + 1,
            name: message.author,
            messages: [message],
            isGroup: message.isBroadcast,
            users: [User(name: message.author, id: int.parse(message.author))]);
        chatsBox.add(chat);
        parsedMessages.add(message);
      }

      for (var message in newMessagesList) {
        if (parsedMessages.contains(message)) {
          continue;
        }
        for (var chat in chatsBox.values.toList()) {
          if (chat.name == message.author &&
              chat.isGroup == message.isBroadcast) {
            chat.messages.add(message);
            parsedMessages.add(message);
          }
        }
      }
    } catch (e) {
      GetIt.I<Talker>().handle(e);
      rethrow;
    }
  }

  Future<String> _getTokenHeader() async {
    String token = GetIt.I<AbstractUserRepository>().getMe().authToken;
    return 'Token $token';
  }
}


/*
{
    "author": "aboba",
    "target": "chat1",
    "message_text": "Hello World",
    "is_group_message": false
}
*/
