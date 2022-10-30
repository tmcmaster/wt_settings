import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../base_settings_providers.dart';
import 'settings_color_component.dart';
import 'settings_color_notifier.dart';

class SettingsColorProviders extends BaseSettingsProviders<SettingsColorNotifier, MaterialColor> {
  final List<MaterialColor> values;

  SettingsColorProviders({
    required super.label,
    required super.hint,
    required this.values,
    required MaterialColor none,
    required String key,
    MaterialColor? initialValue,
  }) : super(
          value: StateNotifierProvider<SettingsColorNotifier, MaterialColor>(
            name: label,
            (ref) => SettingsColorNotifier(
              key: key,
              none: none,
              values: values,
              initialValue: initialValue ?? values[0],
            ),
          ),
        );

  Widget get component => SettingsColorComponent(providers: this);
}
