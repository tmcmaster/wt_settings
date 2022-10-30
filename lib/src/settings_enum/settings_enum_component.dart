import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'settings_enum_notifier.dart';
import 'settings_enum_providers.dart';

class SettingsEnumComponent<T extends Enum> extends HookConsumerWidget {
  final SettingsEnumProviders<T> providers;

  const SettingsEnumComponent({
    super.key,
    required this.providers,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(providers.value);
    final SettingsEnumNotifier<T> notifier = ref.read(providers.notifier);

    return Row(
      children: [
        Text(providers.label),
        const SizedBox(
          width: 20,
        ),
        DropdownButton<T>(
          isExpanded: false,
          value: value,
          onChanged: (value) {
            if (value != null) notifier.replaceValue(value);
          },
          items: providers.values
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(_getTitle(e.toString())),
                  ))
              .toList(),
        ),
      ],
    );
  }

  String _getTitle(String title) => title.contains('.') ? title.split(".")[1] : title;
}
