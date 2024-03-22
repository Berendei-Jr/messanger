import 'package:messanger_client/repositories/chat/models/models.dart';

abstract class AbstractChatsRepository {
  Future<List<Chat>> getChatsList();
}
