import 'package:flutter/material.dart';

import '../local_storage_state_notifier.dart';

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
    int colorValue = value == null ? Colors.red.value : int.parse(value);
    final colorOptions = values.where((color) => color.value == colorValue);
    return colorOptions.isEmpty ? Colors.blue : colorOptions.first;
  }

  @override
  String encode(MaterialColor color) {
    return color.value.toString();
  }
}
