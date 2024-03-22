import 'dart:async';

import 'package:crypto_monitor/repositories/crypto_coins/crypto_coins.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'crypto_coin_event.dart';
part 'crypto_coin_state.dart';

class CryptoCoinBloc extends Bloc<CryptoCoinEvent, CryptoCoinState> {
  CryptoCoinBloc(this.coinsRepo) : super(CryptoCoinInitial()) {
    on<LoadCryptoCoin>((event, emit) async {
      try {
        if (state is! CryptoCoinLoaded) {
          emit(CryptoCoinLoading());
        }

        final coinsList = await coinsRepo.getCoinsList();
        final coin =
            coinsList.firstWhere((coin) => coin.name == event.coinName);
        emit(CryptoCoinLoaded(cryptoCoin: coin));
      } catch (e) {
        emit(CryptoCoinLoadingFailure(exception: e));
      } finally {
        event.completer?.complete();
      }
    });
  }

  final AbstractCoinsRepository coinsRepo;
}
