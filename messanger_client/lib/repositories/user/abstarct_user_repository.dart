import 'package:messanger_client/repositories/user/models/models.dart';

abstract class AbstractUserRepository {
  User? getUser(int id);
  Me getMe();
  bool loginWithCachedCredentials();
  Future<User> requestUserInfo(int id);
  Future<bool> login(String login, String password);
  Future<bool> register(String login, String password);
  Future<List<User>> getUsersList();
}
