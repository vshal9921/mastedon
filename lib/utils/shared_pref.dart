import 'package:shared_preferences/shared_preferences.dart';

class SharedPref{

  static const String email = 'email';
  static const String userHandle = 'userHandle';
  static const String name = 'name';
  static const String userImage = 'userImage';
  //static const String email = 'email';

  static SharedPreferences? _preferences;

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // Setters
  static Future setString(String key, String value) async {
    await _preferences?.setString(key, value);
  }

  static Future setInt(String key, int value) async {
    await _preferences?.setInt(key, value);
  }

  static Future setBool(String key, bool value) async {
    await _preferences?.setBool(key, value);
  }

  // Getters
  static String? getString(String key) {
    return _preferences?.getString(key);
  }

  static int? getInt(String key) {
    return _preferences?.getInt(key);
  }

  static bool? getBool(String key) {
    return _preferences?.getBool(key);
  }

  // Clear

  static void clear() async{
    _preferences?.clear();
  }

}