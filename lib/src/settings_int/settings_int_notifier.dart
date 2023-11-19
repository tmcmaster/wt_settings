import 'package:wt_settings/src/local_storage_state_notifier.dart';

class SettingsIntNotifier extends LocalStorageStateNotifier<int> {
  SettingsIntNotifier({
    required super.key,
    required super.initialValue,
    int? none,
  }) : super(none: none ?? 0);

  @override
  int decode(String? value) => value == null ? none : int.parse(value);

  @override
  String encode(int? value) =>
      value == null ? none.toString() : value.toString();
}
