import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'user.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class UserPreferences {
  static late SharedPreferences _preferences;

  static const _keyUser = 'user';
  static const myUser = User(
    imageProfile: '',
    username : '',
    description: '',
    isDarkMode: false,
  );

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();
  
  static Future setUser(User user) async {
    final json = jsonEncode(user.toJson());

    await _preferences.setString(_keyUser, json);
  }

  static User getUser() {
    final json = _preferences.getString(_keyUser);
    return myUser;
  }
}


Future<User> getMeObject() async {
  User currentUser;
  final _storage = new FlutterSecureStorage();
  final myaccesstoken = await _storage.read(key: "myaccesstoken");
  http.Response response = await http.get(
    Uri.parse("https://oauth.reddit.com/api/v1/me?raw_json=1"),
    headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": "bearer $myaccesstoken",
    },
  );
  currentUser = User.fromJson(jsonDecode(response.body));
  return currentUser;
}