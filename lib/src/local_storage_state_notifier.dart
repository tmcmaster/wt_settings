import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_logging/wt_logging.dart';
import 'package:wt_settings/src/storate/settings_storage.dart';

// TODO: need to do some more testing and cleanup regarding timing issues
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
    Future.delayed(const Duration(seconds: 1), () {
      load().then((loaded) {
        log.d('Values have been loaded: $loaded');
        _loaded = loaded;
      });
    });
  }

  Future<SettingsStorage> get settingStorage => SettingsStorage.instance();

  Future<bool> reload() async {
    _loaded = false;
    return load();
  }

  Future<bool> load() async {
    if (_loaded) {
      return true;
    }
    final encodedValue = (await settingStorage).getString(key);
    if (encodedValue == null) {
      log.d('Object has been loaded, but it was null. Setting $key to "none".');
      state = none;
    } else {
      final decodedValue = decode(encodedValue);
      if (decodedValue == null) {
        log.d('Could not decode data from Key($key).');
        return false;
      } else {
        log.d('Loaded data for Key($key): Encoded($encodedValue), Decoded($decodedValue)');
        replaceValue(decodedValue);
      }
    }
    return true;
  }

  Future<void> replaceValue(T newValue) async {
    if (!_loaded) {
      try {
        await _waitForLoadingToComplete();
      } catch (error) {
        log.e('Waiting for load to complete failed: $error');
        return;
      }
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

    final timer = Timer.periodic(
      const Duration(milliseconds: 100),
      (timer) {
        log.d('Waiting for $key loading to complete....');
        if (_loaded) {
          log.d('Loading was successful');
          timer.cancel();
          completer.complete();
        }
      },
    );

    Future.delayed(
      const Duration(seconds: 2),
      () {
        timer.cancel();
        if (!_loaded) {
          log.d('Loading was unsuccessful');
          completer.completeError('Loading was unsuccessful');
        } else if (!completer.isCompleted) {
          log.d('Loading was successful. Race condition');
          completer.complete();
        }
      },
    );

    return completer.future;
  }
}
