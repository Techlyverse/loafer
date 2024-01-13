import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_model.dart';

class Preferences {
  const Preferences._();

  static late final SharedPreferences _preferences;
  static const String _isLoggedIn = "isLoggedIn";
  static const String _userData = "userData";

  static Future<void> initPreferences() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<bool> saveLogin(bool isLoggedIn) async {
    return await _preferences.setBool(_isLoggedIn, isLoggedIn);
  }

  static bool getLogin() {
    return _preferences.getBool(_isLoggedIn) ?? false;
  }

  static Future<bool> saveUser(UserModel userModel) async {
    var data = jsonEncode(userModel).toString();
   // String data = userModel.toJson().toString(); // error
    return await _preferences.setString(_userData, data);
  }

  static UserModel? getUserModel() {
    String? data = _preferences.getString(_userData);
    if (data == null) return null;

    Map<String, dynamic> userData = jsonDecode(data);
    UserModel userModel = UserModel.fromJson(userData);
    return userModel;
  }

  static Future<bool> clear(){
    return _preferences.clear();
  }
}
