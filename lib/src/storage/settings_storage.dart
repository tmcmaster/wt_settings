import 'package:wt_logging/wt_logging.dart';
import 'package:wt_settings/src/storage/settings_storage_memory_cache.dart';
import 'package:wt_settings/src/storage/settings_storage_shared_preferences.dart';

mixin SettingsStorage {
  static final log = logger(SettingsStorage);

  Future<bool> remove(String key);
  Future<bool> setString(String key, String value);
  Future<bool> clear();
  Set<String> getKeys();
  Object? get(String key);
  String? getString(String key);
  bool? getBool(String key);
  int? getInt(String key);
  double? getDouble(String key);
  bool containsKey(String key);

  static SettingsStorage? _instance;

  static Future<SettingsStorage> instance() async {
    return await SettingsStorage.sharedPreferences();
  }

  static Future<SettingsStorage> init(
    Future<SettingsStorage> Function() settingStorage,
  ) async {
    log.d('Initialising SettingsStorage');
    _instance = await settingStorage();
    log.i('SettingsStorage is of type: ${_instance.runtimeType}');
    return _instance!;
  }

  static Future<SettingsStorage> Function() memoryCache = () => SettingsStorageMemoryCache.instance();

  static Future<SettingsStorage> Function() sharedPreferences = () => SettingsStorageSharedPreferences.instance();

  // TODO: add SettingsStorage support for firebase. (the implementation should be in Firepod).
}
