import 'dart:async';

import 'package:antenna/antenna.dart';
import 'package:rxdart/rxdart.dart';

typedef Reducer<T> = T Function({T state, dynamic event});

abstract class Store<T> {
  T get state;

  Stream<T> get stream;
}

class _Store<T> implements Store<T> {
  final Reducer<T> reducer;

  late final subject = BehaviorSubject<T>.seeded(reducer());

  @override
  T get state => subject.value;

  @override
  Stream<T> get stream => subject;

  _Store(this.reducer);

  void dispatch(event) {
    final state = subject.value;

    final result = reducer(state: state, event: event);

    if (result == state) {
      return;
    }

    subject.sink.add(result);
  }
}

Store<T> createStore<T>(Reducer<T> reducer) => _Store<T>(reducer);

StreamSubscription connect<T>(Store<T> store) {
  final instance = store as _Store<T>;

  final subscription = listen(instance.dispatch);

  return subscription;
}
