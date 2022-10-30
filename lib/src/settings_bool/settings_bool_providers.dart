import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../base_settings_providers.dart';
import 'settings_bool_componnet.dart';
import 'settings_bool_notifier.dart';

class SettingsBoolProviders extends BaseSettingsProviders<SettingsBoolNotifier, bool> {
  final bool hideLabel;
  // late StateNotifierProvider<SettingsBoolNotifier, bool> value;
  SettingsBoolProviders({
    required super.label,
    required super.hint,
    required String key,
    bool? initialValue,
    this.hideLabel = false,
  }) : super(
          value: StateNotifierProvider(
            name: label,
            (ref) => SettingsBoolNotifier(
              key: key,
              initialValue: initialValue ?? true,
            ),
          ),
        );

  Widget get component => SettingsBoolComponent(providers: this);
}
