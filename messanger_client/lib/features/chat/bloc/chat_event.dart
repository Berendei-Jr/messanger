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
      {required this.target,
      required this.message,
      required this.chatName,
      required this.isBroadcast});

  final String target;
  final String message;
  final String chatName;
  final bool isBroadcast;

  @override
  List<Object?> get props => [message, target, chatName, isBroadcast];
}
