import 'package:messanger_client/repositories/chat/models/models.dart';
import 'package:messanger_client/repositories/message/models/message.dart';

abstract class AbstractChatsRepository {
  Future<List<Chat>> getChatsList();

  Future<Chat> sendMessage(Message message, String chatName);
}
