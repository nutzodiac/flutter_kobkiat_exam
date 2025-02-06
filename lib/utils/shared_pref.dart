import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static SharedPref? _sharedPref;
  static const String languageKey = "LANGUAGE_KEY";
  static SharedPref getInstance() {
    _sharedPref ??= SharedPref();
    return _sharedPref!;
  }

  save(String key, value) async {
    SharedPreferences spf = await SharedPreferences.getInstance();
    spf.setString(key, json.encode(value));
  }

  Future read(String key) async {
    SharedPreferences spf = await SharedPreferences.getInstance();
    return spf.getString(key);
  }

  exists(String key) async {
    SharedPreferences spf = await SharedPreferences.getInstance();
    return spf.containsKey(key);
  }

  remove(String key) async {
    SharedPreferences spf = await SharedPreferences.getInstance();
    spf.remove(key);
  }
}
