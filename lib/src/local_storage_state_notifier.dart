import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_logging/wt_logging.dart';
import 'package:wt_settings/src/storate/settings_storage.dart';

abstract class LocalStorageStateNotifier<T> extends StateNotifier<T> {
  static final log = logger('LocalStorageStateNotifier', level: Level.debug);

  final String key;
  final T none;
  bool _loaded = false;
  LocalStorageStateNotifier({
    required this.key,
    required this.none,
    required T initialValue,
  }) : super(initialValue) {
    log.d('About to load values');
    load().then((value) {
      log.d('Values have been loaded.');
      _loaded = true;
    });
  }

  Future<SettingsStorage> get settingStorage => SettingsStorage.instance();

  Future<void> reload() async {
    _loaded = false;
    return load();
  }

  Future<void> load() async {
    if (_loaded) {
      return Future.value();
    }
    final encodedValue = (await settingStorage).getString(key);
    if (encodedValue == null) {
      log.d('Object has been loaded, but it was null. Setting $key to "none".');
      state = none;
    } else {
      final decodedValue = decode(encodedValue);
      if (decodedValue == null) {
        log.d('Could not decode data from Key($key).');
      } else {
        log.d('Loaded data for Key($key): Encoded($encodedValue), Decoded($decodedValue)');
        replaceValue(decodedValue);
      }
    }
  }

  Future<void> replaceValue(T newValue) async {
    if (!_loaded) {
      await _waitForLoadingToComplete();
    }

    log.d('Replacing data with Key($key): $newValue');
    state = newValue;
    log.d('AAA: State: $state');
    final encodedValue = encode(state);
    log.d('AAA: EncodedValue: $encodedValue');
    log.d('Saving data with Key($key): Encoded($encodedValue), Decoded($state)');
    if (encodedValue == null) {
      log.d('Removing value from SettingsStorage: $key');
      (await settingStorage).remove(key);
    } else {
      log.d('Saving new value to SettingsStorage: $encodedValue');
      (await settingStorage).setString(key, encodedValue);
    }

    log.d('AAA: Storage Map: ${await settingStorage}');
    log.d('aaa: State: $state');
  }

  String? encode(T value);
  T decode(String? value);

  Future<void> _waitForLoadingToComplete() {
    if (_loaded) return Future.value();
    final completer = Completer<void>();

    Timer.periodic(
      const Duration(milliseconds: 100),
      (timer) {
        log.d('Waiting for $key loading to complete....');
        if (_loaded) {
          timer.cancel();
          completer.complete();
        }
      },
    );

    Future.delayed(
      const Duration(seconds: 2),
      () {
        if (!_loaded) {
          completer.completeError('Loading was unsuccessful');
        }
      },
    );

    return completer.future;
  }
}
