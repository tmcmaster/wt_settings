import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wt_logging/wt_logging.dart';

abstract class LocalStorageStateNotifier<T> extends StateNotifier<T> {
  static final log = logger(LocalStorageStateNotifier, level: Level.warning);

  final String key;
  final T none;
  LocalStorageStateNotifier({
    required this.key,
    required this.none,
    required T initialValue,
  }) : super(initialValue) {
    load();
  }

  Future<void> load() async {
    final localStorage = await SharedPreferences.getInstance();
    final encodedValue = localStorage.getString(key);
    if (encodedValue == null) {
      log.d('Object has been loaded, but it was null. Setting site to "none".');
      state = none;
    } else {
      final decodedValue = decode(encodedValue);
      if (decodedValue == null) {
        log.d('Could not decode data from Key($key).');
      } else {
        log.d(
            'Loaded data for Key($key): Encoded($encodedValue), Decoded($decodedValue)');
        replaceValue(decodedValue);
      }
    }
  }

  Future<void> replaceValue(T newValue) async {
    log.d('Replacing data with Key($key): $newValue');
    state = newValue;
    final encodedValue = encode(state);
    log.d(
        'Saving data with Key($key): Encoded($encodedValue), Decoded($state)');
    final localStorage = await SharedPreferences.getInstance();
    if (encodedValue == null) {
      localStorage.remove(key);
    } else {
      localStorage.setString(key, encodedValue);
    }
  }

  String? encode(T value);
  T decode(String? value);
}
