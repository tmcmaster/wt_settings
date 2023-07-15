import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_logging/wt_logging.dart';
import 'package:wt_settings/src/settings_string/settings_string_providers.dart';

class SettingsStringComponent extends ConsumerWidget {
  static final log = logger(SettingsStringComponent);

  final SettingsStringProviders providers;
  final String label;
  final String hint;

  const SettingsStringComponent({
    super.key,
    required this.providers,
    required this.label,
    required this.hint,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final focusNode = useFocusNode();
    final tokenEdit = useTextEditingController();

    tokenEdit.text = ref.watch(providers.value);
    final notifier = ref.read(providers.notifier);

    focusNode.addListener(() {
      log.d('-- Value has changed: ${tokenEdit.text}');
      notifier.replaceValue(tokenEdit.text);
    });

    return TextField(
      controller: tokenEdit,
      focusNode: focusNode,
      onEditingComplete: () {
        log.d('onEditingComplete. saving value: ${tokenEdit.text}');
        notifier.replaceValue(tokenEdit.text);
      },
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: const Icon(Icons.key),
      ),
    );
  }
}
