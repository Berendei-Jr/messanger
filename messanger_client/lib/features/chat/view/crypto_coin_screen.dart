import 'dart:async';

import 'package:crypto_monitor/features/crypto_coin/bloc/crypto_coin_bloc.dart';
import 'package:crypto_monitor/repositories/crypto_coins/crypto_coins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class CoinScreen extends StatefulWidget {
  const CoinScreen({super.key, required this.coin});

  final CryptoCoin coin;

  @override
  State<CoinScreen> createState() => _CoinScreenState();
}

class _CoinScreenState extends State<CoinScreen> {
  final _cryptoCoinBloc = CryptoCoinBloc(GetIt.I<AbstractCoinsRepository>());

  @override
  void initState() {
    _cryptoCoinBloc.add(LoadCryptoCoin(coinName: widget.coin.name));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.coin.name),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            final completer = Completer();
            _cryptoCoinBloc.add(LoadCryptoCoin(
                completer: completer, coinName: widget.coin.name));
            return completer.future;
          },
          child: BlocBuilder<CryptoCoinBloc, CryptoCoinState>(
              bloc: _cryptoCoinBloc,
              builder: (context, state) {
                if (state is CryptoCoinLoaded) {
                  return Stack(children: <Widget>[
                    ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Image.network(state.cryptoCoin.imageUrl),
                          Text(
                            state.cryptoCoin.name,
                            style: theme.textTheme.headlineMedium
                                ?.copyWith(fontSize: 45, color: Colors.white),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Card(
                            color: const Color.fromARGB(255, 68, 68, 68),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Current price in USD: ${state.cryptoCoin.priceInUSD}',
                                style: theme.textTheme.labelSmall?.copyWith(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Card(
                            color: const Color.fromARGB(255, 68, 68, 68),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '24 hour highest price: ${state.cryptoCoin.highest24HoursPrice}',
                                style: theme.textTheme.labelSmall?.copyWith(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ]);
                }
                if (state is CryptoCoinLoadingFailure) {
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Something went wrong...',
                        style: theme.textTheme.headlineMedium
                            ?.copyWith(fontSize: 24, color: Colors.white70),
                      ),
                      Text(
                        'Please try again later',
                        style:
                            theme.textTheme.labelSmall?.copyWith(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      OutlinedButton(
                          onPressed: () {
                            _cryptoCoinBloc.add(
                                LoadCryptoCoin(coinName: widget.coin.name));
                          },
                          child: const Text(
                            'Try again',
                            style: TextStyle(color: Colors.yellow),
                          ))
                    ],
                  ));
                }
                return const Center(child: CircularProgressIndicator());
              }),
        ));
  }
}
