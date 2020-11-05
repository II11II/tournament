import 'package:shared_preferences/shared_preferences.dart';

mixin Cache {
  /// Static user token KEY
  static const String _token = "user_token";


  /// Initialising SharedPreference
  SharedPreferences _sharedPreferences;
  Future<SharedPreferences> get _shared async {
    if (_sharedPreferences == null)
      _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences;
  }

  Future<bool> setUserToken(String token) async {
    var cache = await _shared;
    bool status = await cache.setString("$_token", token);
    return status;
  }

  Future<bool> removeUserToken() async {
    var cache = await _shared;
    bool status = await cache.setString("$_token", null);
    return status;
  }

  Future<bool> isUserRegistered() async {
    var value = await getUserToken();
    if (value == null || value.isEmpty)
      return false;
    else
      return true;
  }

  Future<String> getUserToken() async {
    var prefs = await _shared;
    String value = prefs.getString("$_token");
    return value;
  }
}
