import 'package:event_store/channel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class Store<T> extends ChangeNotifier {
  late T state;

  Store(T initial) {
    state = reducer(initial, null);
  }

  T reducer(T state, dynamic event);

  void dispatch(event) {
    final result = reducer(state, event);
    if (!shouldUpdate(state, result)) {
      return;
    }

    state = result;

    notifyListeners();
  }

  bool shouldUpdate(T oldState, T newState) {
    return oldState != newState;
  }
}

class StoreProvider<T extends Store> extends StatefulWidget {
  final Widget? child;

  final T store;

  const StoreProvider({
    super.key,
    this.child,
    required this.store,
  });

  @override
  State<StoreProvider<T>> createState() => _StoreProviderState<T>();
}

class _StoreProviderState<T extends Store> extends State<StoreProvider<T>>
    with ChannelMixin {
  @override
  void onListen(event) {
    widget.store.dispatch(event);

    super.onListen(event);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => widget.store,
      child: widget.child,
    );
  }
}
