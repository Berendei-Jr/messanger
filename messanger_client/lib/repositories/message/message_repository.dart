import 'package:hive_flutter/hive_flutter.dart';
import 'package:messanger_client/repositories/message/abstarct_message_repository.dart';
import 'package:messanger_client/repositories/message/message.dart';

class MessageRepository extends AbstractMessageRepository {
  MessageRepository({required this.messagesBox});

  final Box<Message> messagesBox;

  @override
  void addMessage(Message message) {
    messagesBox.add(message);
  }

  @override
  List<Message> getMessagesList(int chatId) {
    List<Message> msgList = [];
    for (final msg in messagesBox.values.toList()) {
      if (msg.targetId == chatId) {
        msgList.add(msg);
      }
    }

    return msgList;
  }
}
