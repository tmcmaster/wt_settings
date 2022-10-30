import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'settings_bool_providers.dart';

class SettingsBoolComponent extends HookConsumerWidget {
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
