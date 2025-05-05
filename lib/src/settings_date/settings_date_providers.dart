import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_settings/src/base_settings_providers.dart';
import 'package:wt_settings/src/settings_date/settings_date_component.dart';
import 'package:wt_settings/src/settings_date/settings_date_notifier.dart';

class SettingsDateProviders extends BaseSettingsProviders<SettingsDateNotifier, String> {
  final DateTimePickerType type;

  SettingsDateProviders({
    required super.label,
    required super.hint,
    required String key,
    this.type = DateTimePickerType.date,
    String? initialValue,
  }) : super(
          value: StateNotifierProvider(
            name: label,
            (ref) => SettingsDateNotifier(
              key: key,
              initialValue: initialValue ?? '',
            ),
          ),
        );

  @override
  Widget get component => SettingsDateComponent(
        providers: this,
        label: label,
        hint: hint,
        type: type,
      );
}
