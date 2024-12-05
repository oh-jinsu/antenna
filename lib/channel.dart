import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/subjects.dart' show PublishSubject;

class Channel {
  final _controller = PublishSubject();

  Stream get stream => _controller.stream;

  void dispatch(dynamic event) {
    _controller.add(event);
  }

  void close() {
    _controller.close();
  }
}

class ChannelProvider extends StatelessWidget {
  final Widget? child;


  const ChannelProvider({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => Channel(),
      child: child,
  
    );
  }
}

mixin ChannelMixin<T extends StatefulWidget> on State<T> {
  get channel => Provider.of<Channel>(context, listen: false);
  final List<StreamSubscription> subscriptions = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      subscribe(onListen);
    });
  }

  @override
  void dispose() {
    for (final subscription in subscriptions) {
      subscription.cancel();
    }

    super.dispose();
  }

  void subscribe(void Function(dynamic) callback) {
    final sub = channel.stream.listen(callback);

    subscriptions.add(sub);
  }

  void onListen(dynamic event) {}

  void dispatch(dynamic event) {
    channel.dispatch(event);
  }
}
