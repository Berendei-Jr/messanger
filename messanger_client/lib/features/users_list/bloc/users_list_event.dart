part of 'users_list_bloc.dart';

abstract class UsersListEvent extends Equatable {}

class LoadUsersList extends UsersListEvent {
  LoadUsersList({this.completer});

  final Completer? completer;

  @override
  List<Object?> get props => [completer];
}

class CreateChat extends UsersListEvent {
  CreateChat({this.user});

  final User? user;

  @override
  List<Object?> get props => [user];
}
