import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_logging/wt_logging.dart';

// TODO: review if this class is need for changing themes.
class StateNotifierListener<T> implements Listenable {
  static final log = logger(StateNotifierListener, level: Level.debug);

  final StateNotifier<T> notifier;
  final removeListenerMap = <Function, RemoveListener>{};

  StateNotifierListener(this.notifier);

  @override
  void addListener(VoidCallback listener) {
    if (removeListenerMap[listener] == null) {
      log.d('Adding a listener notifier: ${notifier.runtimeType}');
      removeListenerMap[listener] = notifier.addListener((value) {
        log.d('Value has changed: $value');
        listener();
      });
    }
  }

  @override
  void removeListener(VoidCallback listener) {
    final RemoveListener? removeListenerFunction = removeListenerMap[listener];
    if (removeListenerFunction != null) {
      log.d('Removing a listener from notifier: ${notifier.runtimeType}');
      removeListenerFunction();
    }
  }
}
