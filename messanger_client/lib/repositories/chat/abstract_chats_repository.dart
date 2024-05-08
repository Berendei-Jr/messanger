import 'package:messanger_client/repositories/chat/models/models.dart';
import 'package:messanger_client/repositories/message/models/message.dart';
import 'package:messanger_client/repositories/user/user.dart';

abstract class AbstractChatsRepository {
  Future<List<Chat>> getChatsList();
  Future<String> getTokenHeader();
  Future<void> sendMessage(Message message, int chatNId);
  Future<Chat> createChat(User user);
}
