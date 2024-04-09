part of 'chats_list_bloc.dart';

abstract class ChatsListState extends Equatable {}

class ChatsListInitial extends ChatsListState {
  @override
  List<Object?> get props => [];
}

class ChatsListLoading extends ChatsListState {
  @override
  List<Object?> get props => [];
}

class ChatsListLoaded extends ChatsListState {
  ChatsListLoaded({required this.chatsList});
  final List<Chat> chatsList;

  @override
  List<Object?> get props => [chatsList];
}

class ChatsListLoadingFailure extends ChatsListState {
  ChatsListLoadingFailure({required this.exception});
  final Object? exception;

  @override
  List<Object?> get props => [exception];
}
