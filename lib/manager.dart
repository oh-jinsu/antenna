import 'dart:async';

import 'package:antenna/antenna.dart';
import 'package:flutter/material.dart';
import 'package:antenna/store.dart';

mixin AntennaManager<T extends StatefulWidget> on State<T> {
  final _subscriptions = <StreamSubscription>[];

  void open<K>(StoreApi<K> store) {
    initialize(store);

    final subscription = connect(store);

    _subscriptions.add(subscription);
  }

  @protected
  void on<K>(void Function(dynamic event) effect) {
    final subscription = listen(effect);

    _subscriptions.add(subscription);
  }

  @protected
  void sync<K>(
    StoreApi<K> store, {
    void Function(K value)? callback,
  }) {
    final subscription = store.stream.listen((event) {
      setState(() {
        callback?.call(event);
      });
    });

    _subscriptions.add(subscription);
  }

  @override
  void dispose() {
    for (final subscription in _subscriptions) {
      subscription.cancel();
    }

    super.dispose();
  }
}
