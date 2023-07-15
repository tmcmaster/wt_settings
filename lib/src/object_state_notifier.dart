import 'package:flutter_riverpod/flutter_riverpod.dart';

class ObjectStateNotifier<T> extends StateNotifier<T> {
  ObjectStateNotifier(super.state);

  // ignore: use_setters_to_change_properties
  void setState(T newState) {
    state = newState;
  }
}
