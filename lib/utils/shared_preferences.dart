import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static Future<bool> setPrefInt(String key, int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(key, value) ?? false;
  }

  static Future<int> getPrefInt(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.get(key) ?? null;
  }

  static Future<bool> setPrefString(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value) ?? false;
  }

  static Future<String> getPrefString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.get(key) ?? null;
  }

  static Future<bool> setPrefStringList(String key, List<String> value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setStringList(key, value) ?? false;
  }

  static Future<List<String>> getPrefStringList(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.get(key) ?? null;
  }
}
