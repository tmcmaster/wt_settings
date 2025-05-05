import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_settings/src/base_settings_providers.dart';
import 'package:wt_settings/src/settings_enum/settings_enum_component.dart';
import 'package:wt_settings/src/settings_enum/settings_enum_notifier.dart';

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

  @override
  Widget get component => SettingsEnumComponent(providers: this);
}
