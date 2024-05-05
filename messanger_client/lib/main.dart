import 'dart:async';

import 'package:dio/dio.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:messanger_client/messanger_client_app.dart';
import 'package:messanger_client/repositories/chat/models/models.dart';
import 'package:messanger_client/repositories/message/abstarct_message_repository.dart';
import 'package:messanger_client/repositories/message/message_repository.dart';
import 'package:messanger_client/repositories/message/models/message_model.dart';
import 'package:messanger_client/repositories/user/abstarct_user_repository.dart';
import 'package:messanger_client/repositories/user/models/models.dart';
import 'package:messanger_client/repositories/user/user_repository.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'repositories/chat/abstract_chats_repository.dart';
import 'repositories/chat/chats_repository.dart';

const ChatsBoxName = 'chats_box';
const MessagesBoxName = 'messages_box';
const UserBoxName = 'user_box';
const UsersBoxName = 'users_box';
const ServerUrl = 'http://192.168.1.73:8000/api/v1';

void main() async {
  final talker = TalkerFlutter.init();
  GetIt.I.registerSingleton(talker);
  GetIt.I<Talker>().debug('Talker started...');

  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(MeAdapter());
  Hive.registerAdapter(ChatAdapter());
  Hive.registerAdapter(MessageAdapter());

  final userBox = await Hive.openBox<Me>(UserBoxName);
  userBox.clear();
  final usersBox = await Hive.openBox<User>(UsersBoxName);
  usersBox.clear();
  final chatsBox = await Hive.openBox<Chat>(ChatsBoxName);
  chatsBox.clear();
  final messagesBox = await Hive.openBox<Message>(MessagesBoxName);
  messagesBox.clear();

  final dio = Dio();
  dio.interceptors.add(
    TalkerDioLogger(
      talker: talker,
      settings: const TalkerDioLoggerSettings(
        printResponseData: true,
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
    UserRepository(
        dio: dio, serverUrl: ServerUrl, userBox: userBox, usersBox: usersBox),
  );

  GetIt.I.registerLazySingleton<AbstractChatsRepository>(
    () => ChatsRepository(
      dio: dio,
      serverUrl: ServerUrl,
      chatsBox: chatsBox,
    ),
  );

  GetIt.I.registerLazySingleton<AbstractMessageRepository>(
    () => MessageRepository(
      messagesBox: messagesBox,
    ),
  );

  FlutterError.onError =
      (details) => GetIt.I<Talker>().handle(details.exception, details.stack);

  runApp(const MessangerClientApp());
}
