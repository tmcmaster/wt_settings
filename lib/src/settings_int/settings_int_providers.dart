import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_settings/src/base_settings_providers.dart';
import 'package:wt_settings/src/settings_int/settings_int_componnet.dart';
import 'package:wt_settings/src/settings_int/settings_int_notifier.dart';

class SettingsIntProviders
    extends BaseSettingsProviders<SettingsIntNotifier, int> {
  final bool hideLabel;
  final int? min;
  final int? max;
  // late StateNotifierProvider<SettingsBoolNotifier, bool> value;
  SettingsIntProviders({
    required super.label,
    required super.hint,
    required String key,
    int? initialValue,
    int? none,
    this.min,
    this.max,
    this.hideLabel = false,
  }) : super(
          value: StateNotifierProvider(
            name: label,
            (ref) => SettingsIntNotifier(
              key: key,
              initialValue: initialValue ?? 0,
              none: none,
            ),
          ),
        );

  Widget get component => SettingsIntComponent(
        providers: this,
        min: min,
        max: max,
      );
}
