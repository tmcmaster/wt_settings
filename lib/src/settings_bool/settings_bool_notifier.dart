import 'package:wt_settings/src/local_storage_state_notifier.dart';

class SettingsBoolNotifier extends LocalStorageStateNotifier<bool> {
  SettingsBoolNotifier({
    required super.key,
    required super.initialValue,
    bool? none,
  }) : super(none: none ?? false);

  @override
  bool decode(String? value) => value == 'true';

  @override
  String encode(bool? value) => value == null ? 'false' : value.toString();
}
