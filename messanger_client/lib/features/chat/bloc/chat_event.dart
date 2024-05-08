part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {}

class LoadChat extends ChatEvent {
  LoadChat({this.completer, required this.chatName});

  final Completer? completer;
  final String chatName;

  @override
  List<Object?> get props => [completer, chatName];
}

class SendMessage extends ChatEvent {
  SendMessage(
      {required this.targetId,
      required this.message,
      required this.isBroadcast});

  final int targetId;
  final String message;
  final bool isBroadcast;

  @override
  List<Object?> get props => [message, targetId, isBroadcast];
}
