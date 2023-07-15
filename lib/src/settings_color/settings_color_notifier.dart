import 'package:flutter/material.dart';
import 'package:wt_settings/src/local_storage_state_notifier.dart';

class SettingsColorNotifier extends LocalStorageStateNotifier<MaterialColor> {
  final List<MaterialColor> values;

  SettingsColorNotifier({
    required super.key,
    required super.none,
    required super.initialValue,
    required this.values,
  });

  @override
  MaterialColor decode(String? value) {
    final colorValue = value == null ? Colors.red.value : int.parse(value);
    final colorOptions = values.where((color) => color.value == colorValue);
    return colorOptions.isEmpty ? Colors.blue : colorOptions.first;
  }

  @override
  String encode(MaterialColor value) {
    return value.value.toString();
  }
}
