import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_settings/src/local_storage_state_notifier.dart';

abstract class BaseSettingsProviders<N extends LocalStorageStateNotifier<T>, T> {
  final StateNotifierProvider<N, T> value;
  final String label;
  final String hint;

  late final Provider<Future> isReady;

  BaseSettingsProviders({
    required this.value,
    required this.label,
    required this.hint,
  }) {
    isReady = Provider((ref) => ref.read(value.notifier).isReady);
  }

  Refreshable<N> get notifier => value.notifier;

  Widget get component;
}
