import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_settings/src/settings_color/settings_color_notifier.dart';
import 'package:wt_settings/src/settings_color/settings_color_providers.dart';
import 'package:wt_settings/src/settings_color/widgets/color_picker.dart';

class SettingsColorComponent extends ConsumerWidget {
  final SettingsColorProviders providers;
  final List<MaterialColor>? colors;
  const SettingsColorComponent({
    super.key,
    required this.providers,
    this.colors,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(providers.value);
    final SettingsColorNotifier notifier = ref.read(providers.notifier);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(providers.label),
        const SizedBox(width: 8),
        Expanded(
          child: FastColorPicker(
            colors: colors ?? Colors.primaries,
            selectedColor: value,
            onColorSelected: (color) {
              notifier.replaceValue(color);
            },
          ),
        ),
      ],
    );
  }
}
