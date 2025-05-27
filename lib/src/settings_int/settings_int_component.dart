import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_settings/src/settings_int/settings_int_providers.dart';

class SettingsIntComponent extends ConsumerStatefulWidget {
  final SettingsIntProviders providers;

  final int? min;
  final int? max;

  const SettingsIntComponent({
    super.key,
    required this.providers,
    this.min,
    this.max,
  });

  @override
  ConsumerState<SettingsIntComponent> createState() => _SettingsIntComponentState();
}

class _SettingsIntComponentState extends ConsumerState<SettingsIntComponent> {
  late TextEditingController controllor;

  @override
  void initState() {
    controllor = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controllor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final value = ref.watch(widget.providers.value);
    final notifier = ref.read(widget.providers.notifier);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!widget.providers.hideLabel)
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Text(widget.providers.label),
          ),
        IconButton(
          onPressed: () {
            if (widget.min != null && value - 1 < widget.min!) {
              notifier.replaceValue(widget.min!);
            } else {
              notifier.replaceValue(value - 1);
            }
          },
          icon: const Icon(Icons.remove),
        ),
        Text(value.toString()),
        IconButton(
          onPressed: () {
            if (widget.max != null && value + 1 > widget.max!) {
              notifier.replaceValue(widget.max!);
            } else {
              notifier.replaceValue(value + 1);
            }
          },
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
