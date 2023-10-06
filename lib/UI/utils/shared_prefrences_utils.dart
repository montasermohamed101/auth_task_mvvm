import 'dart:convert';

import 'package:intern/data/model/auth/auth_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPrefsUtils{
  static Future saveUser(AuthResponse user)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString('current_user', jsonEncode(user.toJson()));
  }

  static Future<AuthResponse?> getUser()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user =  prefs.getString('current_user');
    if(user != null){
      return AuthResponse.fromJson(jsonDecode(user));
    }

  }

  static Future saveToken(String token)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('token', token);
  }

  static Future<String?> getToken()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token =  prefs.getString('token');
     return token;

  }
  static Future<void> clearToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
  static Future<void> clearUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('current_user');
  }

}