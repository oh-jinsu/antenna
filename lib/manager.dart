import 'dart:async';

import 'package:antenna/store.dart';
import 'package:antenna/antenna.dart';
import 'package:flutter/material.dart';

mixin AntennaManager<T extends StatefulWidget> on State<T> {
  final _subscriptions = <StreamSubscription>[];

  void open<K>(Store<K> store) {
    final subscription = connect(store);

    _subscriptions.add(subscription);
  }

  @protected
  void on<K>(void Function(dynamic event) effect) {
    final subscription = antenna.listen(effect);

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
