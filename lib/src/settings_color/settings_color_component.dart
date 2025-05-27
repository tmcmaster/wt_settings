import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_settings/src/settings_color/settings_color_notifier.dart';
import 'package:wt_settings/src/settings_color/settings_color_providers.dart';
import 'package:wt_settings/src/settings_color/widgets/color_picker.dart';

class SettingsColorComponent extends ConsumerWidget {
  final SettingsColorProviders providers;
  final List<MaterialColor> colors;
  final double maxWidth;
  final bool hideSelected;
  const SettingsColorComponent({
    super.key,
    required this.providers,
    this.hideSelected = true,
    this.colors = const [
      Colors.red,
      Colors.pink,
      Colors.purple,
      Colors.deepPurple,
      Colors.indigo,
      Colors.blue,
      Colors.lightBlue,
      Colors.cyan,
      Colors.teal,
      Colors.green,
      Colors.lightGreen,
      Colors.lime,
      Colors.yellow,
      Colors.amber,
      Colors.orange,
      Colors.deepOrange,
    ],
    this.maxWidth = 300,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(providers.value);
    final SettingsColorNotifier notifier = ref.read(providers.notifier);
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(providers.label),
          const SizedBox(width: 8),
          Expanded(
            child: FastColorPicker(
              colors: colors.where((color) => !hideSelected || color != value).toList(),
              selectedColor: value,
              onColorSelected: (color) {
                notifier.replaceValue(color);
              },
            ),
          ),
        ],
      ),
    );
  }
}
