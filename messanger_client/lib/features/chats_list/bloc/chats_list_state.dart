part of 'chats_list_bloc.dart';

abstract class ChatsListState extends Equatable {}

class CryptoListInitial extends ChatsListState {
  @override
  List<Object?> get props => [];
}

class CryptoListLoading extends ChatsListState {
  @override
  List<Object?> get props => [];
}

class CryptoListLoaded extends ChatsListState {
  CryptoListLoaded({required this.cryptoCoinsList});
  final List<CryptoCoin> cryptoCoinsList;

  @override
  List<Object?> get props => [cryptoCoinsList];
}

class CryptoListLoadingFailure extends ChatsListState {
  CryptoListLoadingFailure({required this.exception});
  final Object? exception;

  @override
  List<Object?> get props => [exception];
}
