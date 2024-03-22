part of 'crypto_coin_bloc.dart';

abstract class CryptoCoinEvent extends Equatable {}

class LoadCryptoCoin extends CryptoCoinEvent {
  LoadCryptoCoin({this.completer, required this.coinName});

  final Completer? completer;
  final String coinName;

  @override
  List<Object?> get props => [completer, coinName];
}
