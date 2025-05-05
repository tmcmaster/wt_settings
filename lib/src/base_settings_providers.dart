import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class BaseSettingsProviders<N extends StateNotifier<T>, T> {
  final StateNotifierProvider<N, T> value;
  final String label;
  final String hint;

  BaseSettingsProviders({
    required this.value,
    required this.label,
    required this.hint,
  });

  Refreshable<N> get notifier => value.notifier;

  Widget get component;
}
