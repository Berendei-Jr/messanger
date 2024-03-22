import 'package:dio/dio.dart';
import 'package:messanger_client/repositories/chat/abstract_chats_repository.dart';
import 'package:messanger_client/repositories/user/user.dart';

import 'models/models.dart';

class ChatsRepository implements AbstractChatsRepository {
  ChatsRepository();

  //final Dio dio;

  @override
  Future<List<Chat>> getChatsList() async {
    return [
      const Chat(id: 69, isGroup: false, users: [
        User(id: 1, name: "Aboba"),
      ], messages: []),
    ];
  }
}
