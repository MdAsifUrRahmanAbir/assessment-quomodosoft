import 'package:shared_preferences/shared_preferences.dart';

/// Static local storage utility backed by SharedPreferences.
///
/// Initialise once in `main()` before `runApp`:
///   await LocalStorage.init();
///
/// Then use anywhere:
///   LocalStorage.saveToken(token: 'abc');
///   String? token = LocalStorage.getToken();
///   LocalStorage.signOut();
class LocalStorage {
  LocalStorage._();

  static late SharedPreferences _prefs;

  /// Initializes the underlying SharedPreferences instance.
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ── Keys ─────────────────────────────────────────────────────────────────
  static const String _tokenKey = 'auth_token';
  static const String _userJsonKey = 'user_json';
  static const String _servicesJsonKey = 'cached_services';

  // ── Token ────────────────────────────────────────────────────────────────
  static Future<bool> saveToken({required String token}) =>
      _prefs.setString(_tokenKey, token);

  static String? getToken() => _prefs.getString(_tokenKey);

  static bool hasToken() => getToken() != null && getToken()!.isNotEmpty;

  // ── User ─────────────────────────────────────────────────────────────────
  static Future<bool> saveUserJson({required String json}) =>
      _prefs.setString(_userJsonKey, json);

  static String? getUserJson() => _prefs.getString(_userJsonKey);

  // ── Services Cache ────────────────────────────────────────────────────────
  static Future<bool> cacheServicesJson({required String json}) =>
      _prefs.setString(_servicesJsonKey, json);

  static String? getCachedServicesJson() => _prefs.getString(_servicesJsonKey);

  // ── Sign Out ──────────────────────────────────────────────────────────────
  static Future<bool> signOut() async {
    final tOk = await _prefs.remove(_tokenKey);
    final uOk = await _prefs.remove(_userJsonKey);
    return tOk && uOk;
  }

  static Future<bool> clearAll() => _prefs.clear();
}
