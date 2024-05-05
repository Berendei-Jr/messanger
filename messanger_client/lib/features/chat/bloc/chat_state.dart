part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {}

class ChatInitial extends ChatState {
  @override
  List<Object?> get props => [];
}

class ChatLoading extends ChatState {
  @override
  List<Object?> get props => [];
}

class ChatLoaded extends ChatState {
  ChatLoaded(this.messages, {required this.chat});
  final Chat chat;
  final List<Message> messages;

  @override
  List<Object?> get props => [chat, messages];
}

class ChatUpdated extends ChatState {
  ChatUpdated({required this.messages});
  final List<Message> messages;

  @override
  List<Object?> get props => [messages];
}

class ChatLoadingFailure extends ChatState {
  ChatLoadingFailure({required this.exception});
  final Object? exception;

  @override
  List<Object?> get props => [exception];
}
