import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../base_settings_providers.dart';
import '../object_state_notifier.dart';
import 'settings_object_componnet.dart';
import 'settings_object_notifier.dart';

class SettingsObjectProviders<T> extends BaseSettingsProviders<SettingsObjectNotifier<T>, T?> {
  final StateNotifierProvider<StateNotifier<List<T>?>, List<T>?> listProvider;
  final String Function(T object) getId;
  final String Function(T object) getLabel;
  final T none;
  SettingsObjectProviders({
    required super.label,
    required super.hint,
    required String key,
    required this.none,
    required this.getId,
    required this.getLabel,
    required this.listProvider,
  }) : super(
          value: StateNotifierProvider(
            name: label,
            (ref) => SettingsObjectNotifier<T>(
              key: key,
              ref: ref,
              getId: getId,
              none: none,
              listProvider: listProvider,
              initialValue: null,
            ),
          ),
        );

  Widget get component => SettingsObjectComponent<T, ObjectStateNotifier<T>>(
        providers: this,
        getId: getId,
        getLabel: getLabel,
        none: none,
      );
}
