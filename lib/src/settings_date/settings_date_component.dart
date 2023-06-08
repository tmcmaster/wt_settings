import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wt_logging/wt_logging.dart';

import 'settings_date_providers.dart';

class SettingsDateComponent extends HookConsumerWidget {
  static final log = logger(SettingsDateComponent);

  final SettingsDateProviders providers;
  final String label;
  final String hint;

  const SettingsDateComponent({
    super.key,
    required this.providers,
    required this.label,
    required this.hint,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    controller.text = ref.watch(providers.value);
    final notifier = ref.read(providers.notifier);

    return SizedBox(
      width: 150,
      child: DateTimePicker(
        type: DateTimePickerType.date,
        controller: controller,
        firstDate: DateTime(2020),
        lastDate: DateTime(2024),
        icon: const Icon(Icons.event),
        dateLabelText: 'From',
        onChanged: (value) {
          notifier.replaceValue(value);
        },
      ),
    );
  }
}
