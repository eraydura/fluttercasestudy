import 'package:shared_preferences/shared_preferences.dart';

class AppCache {
  static const token = 'token';
  static const id = 'id';

  static Future<void> removeAll() async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Future<void> cacheToken(String tokens) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(token, tokens);
  }

  static Future<String> UserToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(token) ?? "";
  }

  static Future<void> cacheId(int tokens) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(id, tokens);
  }

  static Future<int> UserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(id) ?? 0;
  }


}