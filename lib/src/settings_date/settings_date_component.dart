import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_logging/wt_logging.dart';
import 'package:wt_settings/src/settings_date/settings_date_providers.dart';

class SettingsDateComponent extends ConsumerStatefulWidget {
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
  ConsumerState<SettingsDateComponent> createState() => _SettingsDateComponentState();
}

class _SettingsDateComponentState extends ConsumerState<SettingsDateComponent> {
  static final log = logger(SettingsDateComponent);

  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    log.d('TextEditingController has been created');
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    log.d('TextEditingController has been disposed');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.text = ref.watch(widget.providers.value);
    final notifier = ref.read(widget.providers.notifier);

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
//
// class SettingsDateComponent extends StatelessWidget {
//   static final log = logger(SettingsDateComponent);
//
//   final SettingsDateProviders providers;
//   final String label;
//   final String hint;
//
//   const SettingsDateComponent({
//     super.key,
//     required this.providers,
//     required this.label,
//     required this.hint,
//   });
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final controller = useTextEditingController();
//     controller.text = ref.watch(providers.value);
//     final notifier = ref.read(providers.notifier);
//
//     return SizedBox(
//       width: 150,
//       child: DateTimePicker(
//         type: DateTimePickerType.date,
//         controller: controller,
//         firstDate: DateTime(2020),
//         lastDate: DateTime(2024),
//         icon: const Icon(Icons.event),
//         dateLabelText: 'From',
//         onChanged: (value) {
//           notifier.replaceValue(value);
//         },
//       ),
//     );
//   }
// }
