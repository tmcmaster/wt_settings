import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_settings/src/base_settings_providers.dart';
import 'package:wt_settings/src/settings_color/settings_color_component.dart';
import 'package:wt_settings/src/settings_color/settings_color_notifier.dart';

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

  @override
  Widget get component => SettingsColorComponent(
        providers: this,
        colors: values,
      );
}
