import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Channel {
  final _controller = StreamController.broadcast();

  Stream get stream => _controller.stream;

  void dispatch(dynamic event) {
    _controller.add(event);
  }

  void close() {
    _controller.close();
  }

  static Channel of(BuildContext context) {
    return Provider.of<Channel>(context, listen: false);
  }
}

class ChannelProvider extends StatefulWidget {
  final Widget? child;

  final Widget Function(BuildContext, Channel, Widget?)? builder;

  const ChannelProvider({
    super.key,
    this.child,
    this.builder,
  });

  @override
  State<ChannelProvider> createState() => _ChannelProviderState();
}

class _ChannelProviderState extends State<ChannelProvider> {
  final channel = Channel();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => channel,
      child:
          widget.builder?.call(context, channel, widget.child) ?? widget.child,
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
