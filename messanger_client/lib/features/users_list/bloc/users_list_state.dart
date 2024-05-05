part of 'users_list_bloc.dart';

abstract class UsersListState extends Equatable {}

class UsersListInitial extends UsersListState {
  @override
  List<Object?> get props => [];
}

class UsersListLoading extends UsersListState {
  @override
  List<Object?> get props => [];
}

class UsersListLoaded extends UsersListState {
  UsersListLoaded({required this.usersList});
  final List<User> usersList;

  @override
  List<Object?> get props => [usersList];
}

class UsersListLoadingFailure extends UsersListState {
  UsersListLoadingFailure({required this.exception});
  final Object? exception;

  @override
  List<Object?> get props => [exception];
}

class NewChatCreated extends UsersListState {
  NewChatCreated({required this.chat});
  final Chat chat;

  @override
  List<Object?> get props => [chat];
}
