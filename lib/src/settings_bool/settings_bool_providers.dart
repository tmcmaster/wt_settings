import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_settings/src/base_settings_providers.dart';
import 'package:wt_settings/src/settings_bool/settings_bool_componnet.dart';
import 'package:wt_settings/src/settings_bool/settings_bool_notifier.dart';

class SettingsBoolProviders
    extends BaseSettingsProviders<SettingsBoolNotifier, bool> {
  final bool hideLabel;
  // late StateNotifierProvider<SettingsBoolNotifier, bool> value;
  SettingsBoolProviders({
    required super.label,
    required super.hint,
    required String key,
    bool? initialValue,
    bool? none,
    this.hideLabel = false,
  }) : super(
          value: StateNotifierProvider(
            name: label,
            (ref) => SettingsBoolNotifier(
              key: key,
              initialValue: initialValue ?? true,
              none: none,
            ),
          ),
        );

  Widget get component => SettingsBoolComponent(providers: this);
}
