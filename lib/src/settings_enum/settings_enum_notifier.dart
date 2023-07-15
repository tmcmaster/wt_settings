import 'package:wt_settings/src/local_storage_state_notifier.dart';

class SettingsEnumNotifier<T extends Enum> extends LocalStorageStateNotifier<T> {
  final List<T> values;

  SettingsEnumNotifier({
    required super.key,
    required super.none,
    required super.initialValue,
    required this.values,
  });

  @override
  T decode(String? value) {
    final currentValue = values.where((themeMode) => themeMode.toString() == value);
    return (currentValue.isEmpty ? values[0] : currentValue.first);
  }

  @override
  String encode(T value) {
    return value.toString();
  }
}
