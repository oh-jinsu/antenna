import 'package:antenna/store.dart';
import 'package:flutter/material.dart' show Widget, StreamBuilder, SizedBox;

typedef OnData<K> = Widget Function(K data);
typedef OnError = Widget Function(Object? error);

StreamBuilder<K> Function(
  OnData<K> onData, {
  OnError? onError,
}) watch<K>(StoreApi<K> store) {
  return (
    OnData<K> onData, {
    OnError? onError,
  }) {
    return StreamBuilder<K>(
      stream: store.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData || null is K) {
          final data = snapshot.data as K;

          return onData(data);
        }

        return onError?.call(snapshot.error) ?? const SizedBox();
      },
    );
  };
}
