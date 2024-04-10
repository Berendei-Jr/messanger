import 'package:hive_flutter/hive_flutter.dart';
import 'package:messanger_client/repositories/user/abstarct_user_repository.dart';
import 'package:messanger_client/repositories/user/models/models.dart';

class UserRepository extends AbstractUserRepository {
  UserRepository({required this.userBox}) {
    if (userBox.isEmpty) {
      userBox.add(const Me(
        id: 0,
        name: 'andrey',
        authToken: '2d55778c072dff49782445f16dfa7ce548c0d4e7',
      ));
    }
  }
  final Box<Me> userBox;

  @override
  Me getMe() {
    return userBox.get(0)!;
  }
}
