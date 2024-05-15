import 'package:shared_preferences/shared_preferences.dart';
import 'package:wt_settings/src/storate/settings_storage.dart';

class SettingsStorageSharedPreferences with SettingsStorage {
  late SharedPreferences _preferences;
  static SettingsStorageSharedPreferences? _instance;

  SettingsStorageSharedPreferences._(SharedPreferences preferences) {
    _preferences = preferences;
  }

  static Future<SettingsStorageSharedPreferences> instance() async {
    return _instance ??= SettingsStorageSharedPreferences._(
      await SharedPreferences.getInstance(),
    );
  }

  @override
  Future<bool> clear() => _preferences.clear();

  @override
  bool containsKey(String key) => _preferences.containsKey(key);

  @override
  Object? get(String key) => _preferences.get(key);

  @override
  bool? getBool(String key) => _preferences.getBool(key);

  @override
  double? getDouble(String key) => _preferences.getDouble(key);

  @override
  int? getInt(String key) => _preferences.getInt(key);

  @override
  Set<String> getKeys() => _preferences.getKeys();

  @override
  String? getString(String key) => _preferences.getString(key);

  @override
  Future<bool> remove(String key) => _preferences.remove(key);

  @override
  Future<bool> setString(String key, String value) => _preferences.setString(key, value);
}
