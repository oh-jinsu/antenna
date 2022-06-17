library antenna;

import 'dart:async' show StreamSubscription;

import 'package:rxdart/subjects.dart' show PublishSubject;

export 'package:antenna/builder.dart' show watch;
export 'package:antenna/manager.dart' show AntennaManager;
export 'package:antenna/store.dart' show createStore;

final _channel = PublishSubject();

StreamSubscription listen(
  void Function(dynamic event)? onData, {
  Function? onError,
  void Function()? onDone,
  bool? cancelOnError,
}) {
  return _channel.listen(
    onData,
    onError: onError,
    onDone: onDone,
    cancelOnError: cancelOnError,
  );
}

void dispatch(dynamic event) => _channel.sink.add(event);
