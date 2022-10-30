import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../base_settings_providers.dart';
import 'settings_enum_component.dart';
import 'settings_enum_notifier.dart';

class SettingsEnumProviders<T extends Enum> extends BaseSettingsProviders<SettingsEnumNotifier<T>, T> {
  final List<T> values;

  SettingsEnumProviders({
    required super.label,
    required super.hint,
    required this.values,
    required T none,
    required String key,
    T? initialValue,
  }) : super(
          value: StateNotifierProvider(
            name: label,
            (ref) => SettingsEnumNotifier<T>(
              key: key,
              none: none,
              values: values,
              initialValue: initialValue ?? values[0],
            ),
          ),
        );

  Widget get component => SettingsEnumComponent(providers: this);
}
