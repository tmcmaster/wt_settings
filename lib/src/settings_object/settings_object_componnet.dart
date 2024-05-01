import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_settings/src/object_state_notifier.dart';
import 'package:wt_settings/src/settings_object/settings_object_notifier.dart';
import 'package:wt_settings/src/settings_object/settings_object_providers.dart';

class SettingsObjectComponent<T, N extends ObjectStateNotifier<T>>
    extends ConsumerWidget {
  final SettingsObjectProviders<T> providers;
  final String Function(T object) getId;
  final String Function(T object) getLabel;
  final T none;

  const SettingsObjectComponent({
    super.key,
    required this.providers,
    required this.getId,
    required this.getLabel,
    required this.none,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(providers.value);
    final SettingsObjectNotifier<T> notifier = ref.read(providers.notifier);
    final values = ref.watch(providers.listProvider);

    return Row(
      children: [
        Text(providers.label),
        const SizedBox(
          width: 20,
        ),
        if (values != null && values.isNotEmpty && value != null)
          DropdownButton<T?>(
            isExpanded: false,
            value: (value == none ? null : value) as T?,
            onChanged: (value) {
              if (value != null) {
                // ref.read(selectedProvider.notifier).setState(value);
                notifier.replaceValue(value);
              }
            },
            items: values
                .map(
                  (v) => DropdownMenuItem<T?>(
                    value: v,
                    child: Text(getLabel(v)),
                  ),
                )
                .toList(),
          ),
      ],
    );
  }
}
