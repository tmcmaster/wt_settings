import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_settings/src/settings_date/settings_date_component.dart';
import 'package:wt_settings/src/settings_date/settings_date_notifier.dart';

class SettingsDateProviders {
  late StateNotifierProvider<SettingsDateNotifier, String> value;
  final String label;
  final String hint;
  final DateTimePickerType type;

  SettingsDateProviders({
    required String key,
    required this.label,
    required this.hint,
    this.type = DateTimePickerType.date,
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

  Refreshable<SettingsDateNotifier> get notifier => value.notifier;

  Widget get component => SettingsDateComponent(
        providers: this,
        label: label,
        hint: hint,
        type: type,
      );
}
