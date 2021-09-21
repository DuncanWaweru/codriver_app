import 'package:shared_preferences/shared_preferences.dart';

class GetSharedPrefs{
  static Future<String> getNamePreference(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(name)==null?'':prefs.getString(name);
  }
  static Future<String> setNamePreference(String name,String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(name, value);
    return prefs.getString(name);
  }

}