import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class BaseSettingsProviders<N extends StateNotifier<T>, T> {
  final StateNotifierProvider<N, T> value;
  final String label;
  final String hint;

  BaseSettingsProviders({
    required this.value,
    required this.label,
    required this.hint,
  });

  AlwaysAliveRefreshable<N> get notifier => value.notifier;
}
