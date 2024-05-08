import 'package:messanger_client/repositories/message/message.dart';

abstract class AbstractMessageRepository {
  void addMessage(Message message);
  List<Message> getMessagesList(int chatId);
}
