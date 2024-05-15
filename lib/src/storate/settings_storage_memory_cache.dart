import 'package:wt_settings/src/storate/settings_storage.dart';

class SettingsStorageMemoryCache with SettingsStorage {
  final Map<String, dynamic> _preferences;
  static SettingsStorageMemoryCache? _instance;

  SettingsStorageMemoryCache._() : _preferences = {};

  static Future<SettingsStorageMemoryCache> instance() async {
    return _instance ??= SettingsStorageMemoryCache._();
  }

  @override
  Future<bool> clear() {
    _preferences.clear();
    return Future.value(true);
  }

  @override
  bool containsKey(String key) => _preferences.containsKey(key);

  @override
  Object? get(String key) => _preferences[key];

  @override
  bool? getBool(String key) =>
      _preferences.containsKey(key) ? bool.parse(_preferences[key].toString()) : null;

  @override
  double? getDouble(String key) =>
      _preferences.containsKey(key) ? double.parse(_preferences[key].toString()) : null;

  @override
  int? getInt(String key) =>
      _preferences.containsKey(key) ? int.parse(_preferences[key].toString()) : null;

  @override
  Set<String> getKeys() => _preferences.keys.toSet();

  @override
  String? getString(String key) =>
      _preferences.containsKey(key) ? _preferences[key].toString() : null;

  @override
  Future<bool> remove(String key) {
    _preferences.remove(key);
    return Future.value(true);
  }

  @override
  Future<bool> setString(String key, String value) {
    _preferences[key] = value;
    return Future.value(true);
  }

  @override
  String toString() => _preferences.toString();
}
