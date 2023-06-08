import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wt_logging/wt_logging.dart';

import '../local_storage_state_notifier.dart';

class SettingsObjectNotifier<T> extends LocalStorageStateNotifier<T?> {
  static final log = logger(SettingsObjectNotifier);

  List<T> _values = const [];
  final String Function(T object) getId;
  late ProviderSubscription _removeListener;
  SettingsObjectNotifier({
    required super.key,
    required super.initialValue,
    required super.none,
    required this.getId,
    required Ref ref,
    required StateNotifierProvider<StateNotifier<List<T>?>, List<T>?> listProvider,
  }) {
    // TODO: need to add an onError
    _removeListener = ref.listen<List<T>?>(listProvider, (oldValues, newValues) {
      _values = newValues ?? [];

      final newList = newValues;
      log.d('List has changed $newList}');
      if (_siteLoaded()) {
        if (_siteSelected()) {
          log.d(
              'There is a current selected value, so checking if the current value is in the new list');
        } else {
          if (_listLoaded(newList)) {
            if (_listContainsSelectedSite(newList)) {
              log.d('Selected value was in the new list');
            } else {
              log.d(
                  'There is no current selected value, so first item of the list will be selected.');
              load();
            }
          } else {
            log.d('There is no current selected value, but list has not been loaded yet.');
          }
        }
      } else {
        log.d(
            'List has loaded, but the selected value has not loaded yet. Reloading selected value.');
        load();
      }
    });
  }

  bool _listLoaded(List<T>? list) {
    return list != null;
  }

  bool _siteSelected() {
    log.d('_siteSelected: $state');
    return state != none;
  }

  bool _siteLoaded() {
    // TODO: There is an issue when the value is not in the SharedPreferences. need to pass a default when reading from the preferences.
    return state != null;
  }

  bool _listContainsSelectedSite(List<T>? list) {
    return list != null && list.contains(state);
  }

  void _setSiteToFirstSiteInList(List<T>? list) {
    if (list != null && list.isNotEmpty) {
      super.replaceValue(list[0]);
    }
  }

  @override
  void dispose() {
    _removeListener.close();
    super.dispose();
  }

  @override
  T? decode(String? value) {
    if (value == null || value.isEmpty) {
      return none;
    } else {
      if (_values.isEmpty) {
        log.d('There was a Value($value), but the list was not available yet.');
        return null;
      } else {
        log.d('There was a Value($value). Checking the existing list.');
        final possibleValues = _values.where((v) => getId(v) == value).toList();
        return (possibleValues.isEmpty ? _values[0] : possibleValues.first);
      }
    }
  }

  @override
  String encode(T? value) {
    return value == null ? '' : getId(value);
  }
}
