import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_settings/src/settings_string/settings_string_componnet.dart';
import 'package:wt_settings/src/settings_string/settings_string_notifier.dart';

class SettingsStringProviders {
  late StateNotifierProvider<SettingsStringNotifier, String> value;
  final String label;
  final String hint;

  SettingsStringProviders({
    required String key,
    required this.label,
    required this.hint,
    String? initialValue,
  }) {
    value = StateNotifierProvider(
      name: label,
      (ref) => SettingsStringNotifier(
        key: key,
        initialValue: initialValue ?? '',
      ),
    );
  }

  AlwaysAliveRefreshable<SettingsStringNotifier> get notifier => value.notifier;

  Widget get component => SettingsStringComponent(
        providers: this,
        label: 'API Token',
        hint: 'Enter API token',
      );
}
