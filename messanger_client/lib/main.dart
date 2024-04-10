import 'dart:async';

import 'package:dio/dio.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:messanger_client/messanger_client_app.dart';
import 'package:messanger_client/repositories/chat/models/models.dart';
import 'package:messanger_client/repositories/message/models/message_model.dart';
import 'package:messanger_client/repositories/user/abstarct_user_repository.dart';
import 'package:messanger_client/repositories/user/models/models.dart';
import 'package:messanger_client/repositories/user/user_repository.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'repositories/chat/abstract_chats_repository.dart';
import 'repositories/chat/chats_repository.dart';

// ignore: constant_identifier_names
const ChatsBoxName = 'chats_box';
const UserBoxName = 'user_box';

void main() async {
  final talker = TalkerFlutter.init();
  GetIt.I.registerSingleton(talker);
  GetIt.I<Talker>().debug('Talker started...');

  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(MeAdapter());
  Hive.registerAdapter(ChatAdapter());
  Hive.registerAdapter(MessageAdapter());

  final chatsBox = await Hive.openBox<Chat>(ChatsBoxName);
  chatsBox.clear();

  final userBox = await Hive.openBox<Me>(UserBoxName);
  userBox.clear();

  final dio = Dio();
  dio.interceptors.add(
    TalkerDioLogger(
      talker: talker,
      settings: const TalkerDioLoggerSettings(
        printResponseData: false,
      ),
    ),
  );

  Bloc.observer = TalkerBlocObserver(
    talker: talker,
    settings: const TalkerBlocLoggerSettings(
      printStateFullData: false,
      printEventFullData: false,
    ),
  );

  GetIt.I.registerSingleton<AbstractUserRepository>(
    UserRepository(userBox: userBox),
  );

  GetIt.I.registerLazySingleton<AbstractChatsRepository>(
    () => ChatsRepository(
      dio: dio,
      serverUrl: 'http://192.168.1.73:8000/api/v1',
      chatsBox: chatsBox,
    ),
  );

  FlutterError.onError =
      (details) => GetIt.I<Talker>().handle(details.exception, details.stack);

  runZonedGuarded(() => runApp(const MessangerClientApp()), (e, st) async {
    /*WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );*/

    GetIt.I<Talker>().handle(e, st);
  });
}
