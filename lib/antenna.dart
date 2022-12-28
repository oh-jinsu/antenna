library antenna;

import 'dart:async';

import 'package:rxdart/subjects.dart' show PublishSubject;

export 'package:antenna/mixin.dart' show AntennaMixin;

export 'package:antenna/consumer.dart' show StoreConsumer;

export 'package:antenna/store.dart' show createStore, connectStore;

final _channel = PublishSubject();

@override
StreamSubscription listenEffect(void Function(dynamic event) eventListener) {
  return _channel.listen(eventListener);
}

@override
void dispatch(event) {
  return _channel.sink.add(event);
}
