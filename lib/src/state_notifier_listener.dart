import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wt_logging/wt_logging.dart';

// TODO: review if this class is need for changing themes.
class StateNotifierListener<T> implements Listenable {
  static final log = logger(StateNotifierListener);

  final StateNotifier<T> notifier;
  final Map<Function, Function> removeListenerMap = {};

  StateNotifierListener(this.notifier);

  @override
  void addListener(VoidCallback listener) {
    if (removeListenerMap[listener] == null) {
      log.d('Adding a listener notifier: ${notifier.runtimeType}');
      removeListenerMap[listener] = notifier.addListener((value) {
        log.d('Value has changed: ${value.toString()}');
        listener();
      });
    }
  }

  @override
  void removeListener(VoidCallback listener) {
    final removeListenerFunction = removeListenerMap[listener];
    if (removeListenerFunction != null) {
      log.d('Removing a listener from notifier: ${notifier.runtimeType}');
      removeListenerFunction();
    }
  }
}
