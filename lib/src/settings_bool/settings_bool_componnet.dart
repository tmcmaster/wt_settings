import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_settings/src/settings_bool/settings_bool_providers.dart';

class SettingsBoolComponent extends ConsumerWidget {
  final SettingsBoolProviders providers;

  const SettingsBoolComponent({
    super.key,
    required this.providers,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(providers.value);
    final notifier = ref.read(providers.notifier);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!providers.hideLabel)
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Text(providers.label),
          ),
        Switch(
          value: value,
          onChanged: (value) {
            notifier.replaceValue(value);
          },
        )
      ],
    );
  }
}
