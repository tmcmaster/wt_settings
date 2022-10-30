import '../local_storage_state_notifier.dart';

class SettingsDateNotifier extends LocalStorageStateNotifier<String> {
  SettingsDateNotifier({
    required super.key,
    required super.initialValue,
  }) : super(none: '');

  @override
  String decode(String? value) => value ?? '';

  @override
  String encode(String value) => value;
}
