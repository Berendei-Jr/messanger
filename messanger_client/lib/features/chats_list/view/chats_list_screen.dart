import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

class ChatsListScreen extends StatefulWidget {
  const ChatsListScreen({super.key});

  @override
  State<ChatsListScreen> createState() => _ChatsListScreenState();
}

class _ChatsListScreenState extends State<ChatsListScreen> {
  final _ChatsListBloc = ChatsListBloc(GetIt.I<AbstractCoinsRepository>());

  @override
  void initState() {
    _ChatsListBloc.add(LoadCryptoList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TalkerScreen(
                      talker: GetIt.I<Talker>(),
                    ),
                  ),
                );
              },
              icon: const Icon(
                Icons.document_scanner_outlined,
              ),
            )
          ],
        ),
        body: RefreshIndicator(
            onRefresh: () async {
              final completer = Completer();
              _ChatsListBloc.add(LoadCryptoList(completer: completer));
              return completer.future;
            },
            child: BlocBuilder<ChatsListBloc, CryptoListState>(
                bloc: _ChatsListBloc,
                builder: (context, state) {
                  if (state is CryptoListLoaded) {
                    return ListView.separated(
                      itemCount: state.cryptoCoinsList.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, i) {
                        final coin = state.cryptoCoinsList[i];
                        return CryptoCoinTile(coin: coin, theme: theme);
                      },
                    );
                  }
                  if (state is CryptoListLoadingFailure) {
                    return Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Something went wrong... ${state.exception.toString()}',
                          style: theme.textTheme.headlineMedium
                              ?.copyWith(fontSize: 24, color: Colors.white70),
                        ),
                        Text(
                          'Please try again later',
                          style: theme.textTheme.labelSmall
                              ?.copyWith(fontSize: 16),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        OutlinedButton(
                            onPressed: () {
                              _ChatsListBloc.add(LoadCryptoList());
                            },
                            child: const Text(
                              'Try again',
                              style: TextStyle(color: Colors.yellow),
                            ))
                      ],
                    ));
                  }
                  return const Center(child: CircularProgressIndicator());
                })));
  }
}
