import 'dart:async';

import 'package:antenna/store.dart';
import 'package:flutter/material.dart';

class StoreConsumer<T> extends StatefulWidget {
  final Store<T> store;

  final Widget Function(BuildContext context, T state) builder;

  const StoreConsumer({
    super.key,
    required this.store,
    required this.builder,
  });

  @override
  State<StoreConsumer> createState() => _StoreConsumerState<T>();
}

class _StoreConsumerState<T> extends State<StoreConsumer<T>> {
  late StreamSubscription subscription;

  late T state;

  @override
  void initState() {
    state = widget.store.state;

    subscription = widget.store.stream.listen((event) {
      if (state == event) {
        return;
      }

      setState(() {
        state = event;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, state);
  }
}
