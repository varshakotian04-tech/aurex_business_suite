import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static SharedPreferences? _prefs;

  /// Initialize once
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveData(String key, String value) async {
    await _prefs?.setString(key, value);
  }

  Future<String?> readData(String key) async {
    return _prefs?.getString(key);
  }

  Future<void> removeData(String key) async {
    await _prefs?.remove(key);
  }
}