import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'settings_color_notifier.dart';
import 'settings_color_providers.dart';
import 'widgets/color_picker.dart';

class SettingsColorComponent extends HookConsumerWidget {
  final SettingsColorProviders providers;

  const SettingsColorComponent({
    super.key,
    required this.providers,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(providers.value);
    final SettingsColorNotifier notifier = ref.read(providers.notifier);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(providers.label),
        Expanded(
          child: FastColorPicker(
            selectedColor: value,
            onColorSelected: (color) {
              notifier.replaceValue(color);
            },
          ),
        )
      ],
    );
  }
}
