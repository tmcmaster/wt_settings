import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_logging/wt_logging.dart';
import 'package:wt_provider_manager/wt_provider_manager.dart';
import 'package:wt_settings/src/storage/settings_storage.dart';

abstract class LocalStorageStateNotifier<T> extends StateNotifier<T> with WaitForIsReady {
  static final log = logger(LocalStorageStateNotifier);

  final String key;
  final T none;

  @override
  late final Future isReady;

  Completer<void> _loaded = Completer<void>();

  LocalStorageStateNotifier({
    required this.key,
    required this.none,
    required T initialValue,
  }) : super(initialValue) {
    log.d('About to load values: $key');
    isReady = _loaded.future;
    if (!_loaded.isCompleted) {
      Future.delayed(const Duration(milliseconds: 1), _load);
    }
  }

  Future<SettingsStorage> get settingStorage => SettingsStorage.instance();

  Future<bool> reload() {
    log.d('Reloading the settings: $key');
    if (_loaded.isCompleted) {
      _loaded = Completer<void>();
      return _load();
    } else {
      log.w('There setting is already in the process of being loaded: $key');
      return Future.value(false);
    }
  }

  Future<bool> _load() async {
    if (_loaded.isCompleted) {
      log.w('The setting has already loaded: $key');
      return true;
    }
    try {
      final encodedValue = (await settingStorage).getString(key);
      if (encodedValue == null) {
        log.d('Object has been loaded, but it was null. Setting $key to "none".');
        state = none;
        _loaded.complete();
        return true;
      } else {
        final decodedValue = decode(encodedValue);
        if (decodedValue == null) {
          log.e('Could not decode data from Key($key).');
          state = none;
          if (!_loaded.isCompleted) {
            _loaded.completeError('Could not decode data from Key($key): $encodedValue');
          }
          return false;
        } else {
          log.d('Loaded data for Key($key): Encoded($encodedValue), Decoded($decodedValue)');
          state = decodedValue;
          log.d('Key($key) values have been loaded: $encodedValue');
          if (!_loaded.isCompleted) {
            _loaded.complete();
          }
          return true;
        }
      }
    } catch (error) {
      log.e('Could not load settings for Key($key): $error');
      _loaded.completeError('Could not decode data from Key($key): $error');
      return false;
    }
  }

  Future<void> replaceValue(T newValue) async {
    if (!_loaded.isCompleted) {
      await _loaded.future;
    }
    log.d('Replacing data with Key($key): $newValue');
    state = newValue;
    _persistState();
  }

  Future<void> _persistState() async {
    final encodedValue = encode(state);
    log.d('Saving data with Key($key): Encoded($encodedValue), Decoded($state)');
    if (encodedValue == null) {
      log.d('Removing value from SettingsStorage: $key');
      (await settingStorage).remove(key);
    } else {
      log.d('Saving new value to SettingsStorage with Key($key): $encodedValue');
      (await settingStorage).setString(key, encodedValue);
    }
  }

  String? encode(T value);
  T decode(String? value);
}
