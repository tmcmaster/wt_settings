import 'package:hooks_riverpod/hooks_riverpod.dart';

class ObjectStateNotifier<T> extends StateNotifier<T> {
  ObjectStateNotifier(super.state);

  void setState(T newState) {
    state = newState;
  }
}
