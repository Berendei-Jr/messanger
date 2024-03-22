import 'package:crypto_monitor/features/crypto_coin/crypto_coin.dart';
import 'package:crypto_monitor/features/crypto_list/crypto_list.dart';
import 'package:crypto_monitor/repositories/crypto_coins/models/crypto_coin_model.dart';
import 'package:flutter/material.dart';

final routes = {
  '/': (context) => const CryptoListScreen(title: 'Crypto Monitor'),
  '/coin': (context) => CoinScreen(
      coin: ModalRoute.of(context)?.settings.arguments as CryptoCoin),
};
