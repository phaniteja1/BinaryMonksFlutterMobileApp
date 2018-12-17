import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static void saveToPrefs(var key, var value, {var type = 'stringList'}) async {
    // obtain shared preferences
    var prefs = await SharedPreferences.getInstance();
    // set value
    prefs.setStringList(key, value);
  }

  static Future<List<String>> getFromPrefs(var key, {var type = 'stringList'}) async {
    final prefs = await SharedPreferences.getInstance();
    // Try reading data from the counter key. If it does not exist, return 0.
    return prefs.getStringList(key) ?? null;
  }
}
