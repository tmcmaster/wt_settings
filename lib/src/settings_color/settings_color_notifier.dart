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
    final int colorValue = value == null ? Colors.blue.toARGB32() : int.tryParse(value) ?? Colors.blue.toARGB32();

    final matchedColor = values.firstWhere(
      (color) => color.toARGB32() == colorValue,
      orElse: () => Colors.blue,
    );

    return matchedColor;
  }

  @override
  String encode(MaterialColor value) {
    return value.toARGB32.toString();
  }
}
