import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_settings/src/settings_date/settings_date_component.dart';
import 'package:wt_settings/src/settings_date/settings_date_notifier.dart';

class SettingsDateProviders {
  late StateNotifierProvider<SettingsDateNotifier, String> value;
  final String label;
  final String hint;

  SettingsDateProviders({
    required String key,
    required this.label,
    required this.hint,
    String? initialValue,
  }) {
    value = StateNotifierProvider(
      name: label,
      (ref) => SettingsDateNotifier(
        key: key,
        initialValue: initialValue ?? '',
      ),
    );
  }

  AlwaysAliveRefreshable<SettingsDateNotifier> get notifier => value.notifier;

  Widget get component => SettingsDateComponent(
        providers: this,
        label: label,
        hint: hint,
      );
}
