import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:messanger_client/repositories/chat/abstract_chats_repository.dart';
import 'package:messanger_client/repositories/chat/models/models.dart';
import 'package:messanger_client/repositories/message/abstarct_message_repository.dart';
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
  Future<void> sendMessage(Message message, int chatId) async {
    try {
      dio.options.headers['Authorization'] = await getTokenHeader();

      final response = await dio.post(
        '$serverUrl/message',
        data: {
          'author_id': GetIt.I<AbstractUserRepository>().getMe().id,
          'target_id': message.targetId,
          'is_group_message': message.isBroadcast,
          'message_text': message.message,
        },
      );

      if (response.statusCode != 202) {
        throw Exception('Server error code: ${response.statusCode}');
      }

      GetIt.I<AbstractMessageRepository>().addMessage(message);
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

    for (var chat in chatsBox.values.toList()) {
      if (!chat.isGroup) {
        User? user =
            GetIt.I.get<AbstractUserRepository>().getUser(chat.users.first.id);

        user ??= await GetIt.I<AbstractUserRepository>()
            .requestUserInfo(chat.users.first.id);
      }
    }

    return chatsBox.values.toList();
  }

  @override
  Future<Chat> createChat(User user) async {
    try {
      dio.options.headers['Authorization'] = await getTokenHeader();

      final response = await dio.post(
        '$serverUrl/create_chat',
        data: {'target_user_id': user.id},
      );

      if (response.statusCode != 201) {
        throw Exception(
            'Server error ${response.statusCode}: ${response.data}');
      }

      final data = response.data as Map<String, dynamic>;
      final chatId = data['chat_id'] as int;
      final chat = Chat(
        id: chatId,
        name: user.name,
        isGroup: false,
        users: [user],
      );
      chatsBox.put(
        chatId,
        chat,
      );

      return chat;
    } catch (e) {
      GetIt.I<Talker>().handle(e);
      rethrow;
    }
  }

  Future<void> _fetchMessagesFromServer() async {
    try {
      dio.options.headers['Authorization'] = await getTokenHeader();

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

      for (var message in newMessagesList) {
        GetIt.I<AbstractMessageRepository>().addMessage(message);
        var chatRecognized = false;

        for (final chat in chatsBox.values.toList()) {
          if (chat.id == message.targetId) {
            chatRecognized = true;
            break;
          }
        }
        if (!chatRecognized) {
          chatsBox.add(await _getChatInfo(message));
        }
      }
    } catch (e) {
      GetIt.I<Talker>().handle(e);
      rethrow;
    }
  }

  @override
  Future<String> getTokenHeader() async {
    String token = GetIt.I<AbstractUserRepository>().getMe().authToken;
    return 'Token $token';
  }

  Future<Chat> _getChatInfo(Message msg) async {
    final isGroup = msg.isBroadcast;

    if (!isGroup) {
      final myMessage =
          msg.authorId == GetIt.I<AbstractUserRepository>().getMe().id;

      if (!myMessage) {
        User? user =
            GetIt.I.get<AbstractUserRepository>().getUser(msg.authorId);

        user ??= await GetIt.I<AbstractUserRepository>()
            .requestUserInfo(msg.authorId);

        return Chat(
          id: msg.targetId,
          name: user.name,
          isGroup: isGroup,
          users: [user],
        );
      } else {
        dio.options.headers['Authorization'] = await getTokenHeader();

        final response = await dio.post(
          '$serverUrl/request_chat_info',
          data: {
            'chat_id': msg.targetId,
            'is_group': msg.isBroadcast,
          },
        );

        var chatName = '';
        final data = response.data as Map<String, dynamic>;
        final users = data['users'] as List<dynamic>;
        for (var u in users) {
          final userMap = u as Map<String, dynamic>;
          if (userMap['id'] != GetIt.I<AbstractUserRepository>().getMe().id) {
            chatName = userMap['username'];
            final User user = User(
              id: userMap['user_id'],
              name: chatName,
            );
            return Chat(
              id: msg.targetId,
              name: chatName,
              isGroup: isGroup,
              users: [user],
            );
          }
        }
      }
    }

    return Chat(
      id: msg.targetId,
      name: '',
      isGroup: isGroup,
      users: [],
    );
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
