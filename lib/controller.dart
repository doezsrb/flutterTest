import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/user.dart';

class Controller extends GetxController {
  RxBool loginUser = false.obs;
  RxBool loading = false.obs;
  String fakeUsername = 'doezSrb';
  String fakePassword = '21031997';

  Future<bool> login(String username, String password) {
    loading.value = true;
    return Future<bool>.delayed(const Duration(seconds: 3), () {
      loading.value = false;
      if (fakeUsername == username && fakePassword == password) {
        loginUser.value = true;
        return true;
      } else {
        return false;
      }
    });
  }

  Future<void> saveUser(User user) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setInt('id', user.id);
    sharedPreferences.setString('username', user.username);
    sharedPreferences.setString('token', user.token);
  }

  Future<void> removeUser() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.remove('id');
    sharedPreferences.remove('username');
    sharedPreferences.remove('token');
  }

  Future<User?> getUser() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final int? id = sharedPreferences.getInt('id');
    final String? username = sharedPreferences.getString('username');
    final String? token = sharedPreferences.getString('token');

    if (token != null && username != null && id != null) {
      loginUser.value = true;
      final User user = User(id: id, username: username, token: token);
      return user;
    } else {
      loginUser.value = false;
      return null;
    }
  }
}
