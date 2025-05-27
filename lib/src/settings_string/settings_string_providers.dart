import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_settings/src/base_settings_providers.dart';
import 'package:wt_settings/src/settings_string/settings_string_component.dart';
import 'package:wt_settings/src/settings_string/settings_string_notifier.dart';

class SettingsStringProviders extends BaseSettingsProviders<SettingsStringNotifier, String> {
  SettingsStringProviders({
    required super.label,
    required super.hint,
    required String key,
    String? initialValue,
  }) : super(
          value: StateNotifierProvider(
            name: label,
            (ref) => SettingsStringNotifier(
              key: key,
              initialValue: initialValue ?? '',
            ),
          ),
        );

  @override
  Widget get component => SettingsStringComponent(
        providers: this,
        label: 'API Token',
        hint: 'Enter API token',
      );
}
