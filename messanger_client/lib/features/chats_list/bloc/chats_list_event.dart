part of 'chats_list_bloc.dart';

abstract class ChatsListEvent extends Equatable {}

class LoadChatsList extends ChatsListEvent {
  LoadChatsList({this.completer});

  final Completer? completer;

  @override
  List<Object?> get props => [completer];
}
