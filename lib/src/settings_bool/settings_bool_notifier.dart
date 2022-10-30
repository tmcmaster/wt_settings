import '../local_storage_state_notifier.dart';

class SettingsBoolNotifier extends LocalStorageStateNotifier<bool> {
  SettingsBoolNotifier({
    required super.key,
    required super.initialValue,
  }) : super(none: false);

  @override
  bool decode(String? value) => value == "true" ? true : false;

  @override
  String encode(bool? value) => value == null ? "false" : value.toString();
}
