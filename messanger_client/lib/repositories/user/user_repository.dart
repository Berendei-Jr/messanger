import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:messanger_client/repositories/chat/abstract_chats_repository.dart';
import 'package:messanger_client/repositories/user/abstarct_user_repository.dart';
import 'package:messanger_client/repositories/user/models/models.dart';

class UserRepository extends AbstractUserRepository {
  UserRepository(
      {required this.dio,
      required this.serverUrl,
      required this.userBox,
      required this.usersBox});

  final String serverUrl;
  final Dio dio;
  final Box<Me> userBox;
  final Box<User> usersBox;

  @override
  User? getUser(int id) {
    return usersBox.get(id);
  }

  @override
  Me getMe() {
    if (userBox.isEmpty) {
      throw Exception('Need to sign in');
    }
    return userBox.get(0)!;
  }

  void addUser(User user) {
    usersBox.put(user.id, user);
  }

  @override
  bool loginWithCachedCredentials() {
    return userBox.isNotEmpty;
  }

  @override
  Future<User> requestUserInfo(int id) async {
    try {
      dio.options.headers['Authorization'] =
          await GetIt.I<AbstractChatsRepository>().getTokenHeader();
      final response = await dio.post(
        '$serverUrl/request_user_info',
        data: {
          'id': id,
        },
      );

      if (response.statusCode != 200) {
        throw Exception(
            'Server error ${response.statusCode}: ${response.data}');
      }

      final data = response.data as Map<String, dynamic>;
      final user = User(
        id: id,
        name: data['username'] as String,
      );
      usersBox.put(
        id,
        user,
      );

      return user;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> login(String login, String password) async {
    if (userBox.values.isNotEmpty) {
      return true;
    } else {
      try {
        final response = await dio.post(
          '$serverUrl/login',
          data: {
            'username': login,
            'password': password,
          },
        );

        if (response.statusCode != 202) {
          throw Exception(
              'Server error ${response.statusCode}: ${response.data}');
        }
        final data = response.data as Map<String, dynamic>;
        userBox.put(
            0,
            Me(
                name: login,
                id: data['id'] as int,
                authToken: data['token'] as String));
        return true;
      } catch (e) {
        rethrow;
      }
    }
  }

  @override
  Future<bool> register(String login, String password) async {
    try {
      userBox.clear();
      final response = await dio.post(
        '$serverUrl/register',
        data: {
          'username': login,
          'password': password,
        },
      );

      if (response.statusCode != 201) {
        throw Exception(
            'Server error ${response.statusCode}: ${response.data}');
      }
      final data = response.data as Map<String, dynamic>;
      userBox.put(
          0,
          Me(
              name: login,
              id: data['id'] as int,
              authToken: data['token'] as String));
      return true;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<User>> getUsersList() async {
    dio.options.headers['Authorization'] =
        await GetIt.I<AbstractChatsRepository>().getTokenHeader();
    final response = await dio.post(
      '$serverUrl/get_users_list',
      data: {},
    );

    if (response.statusCode != 200) {
      throw Exception('Server error ${response.statusCode}: ${response.data}');
    }
    final data = response.data as Map<String, dynamic>;
    final usersList = data.entries.map((e) {
      final user = User.fromJson(e.value as Map<String, dynamic>);
      return user;
    }).toList();

    for (final user in usersList) {
      if (user.id != getMe().id && !usersBox.containsKey(user.id)) {
        addUser(user);
      }
    }
    return usersBox.values.toList();
  }
}
