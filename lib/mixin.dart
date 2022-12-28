import 'dart:async';

import 'package:antenna/effect.dart';
import 'package:antenna/store.dart';
import 'package:flutter/material.dart';

mixin AntennaMixin<T extends StatefulWidget> on State<T> {
  final _subscriptions = <StreamSubscription>[];

  void connect<K>(Store<K> store) {
    final subscription = connectStore(store);

    _subscriptions.add(subscription);
  }

  @protected
  void listen<K>(void Function(dynamic event) effect) {
    final subscription = listenEffect(effect);

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
