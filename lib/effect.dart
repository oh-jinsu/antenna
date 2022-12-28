import 'dart:async';

import 'package:antenna/channel.dart';

typedef Effect<T> = void Function(T event);

StreamSubscription listenEffect(void Function(dynamic event) eventListener) {
  return channel.listen(eventListener);
}

Effect when<T>(Effect<T> effect) {
  return (event) {
    if (event is T) {
      effect(event);
    }
  };
}
