import 'package:channel_store/channel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class Store<T> extends ChangeNotifier {
  late T state;

  Store(T initial) {
    state = reducer(initial, null);
  }

  @protected
  void init() {}

  @protected
  T reducer(T state, dynamic event);

  Future<T> reducerAsync(T state, dynamic event) async {
    return state;
  }

  void dispatch(event) async {
    final result1 = await reducerAsync(state, event);

    final result2 = reducer(result1, event);

    update(result2);
  }

  @protected
  void update(T newState) {
    if (!shouldUpdate(state, newState)) {
      return;
    }

    state = newState;

    notifyListeners();
  }

  bool shouldUpdate(T oldState, T newState) {
    return oldState != newState;
  }
}

class StoreProvider<T extends Store> extends StatefulWidget {
  final Widget? child;

  final T store;

  final Widget Function(BuildContext, T, Widget?)? builder;

  const StoreProvider({
    super.key,
    this.child,
    required this.store,
    this.builder,
  });

  @override
  State<StoreProvider<T>> createState() => _StoreProviderState<T>();
}

class _StoreProviderState<T extends Store> extends State<StoreProvider<T>>
    with ChannelMixin {
  @override
  void initState() {
    widget.store.init();

    super.initState();
  }

  @override
  void onListen(event) {
    widget.store.dispatch(event);

    super.onListen(event);
  }

  @override
  void dispose() {
    widget.store.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.builder != null) {
      return ChangeNotifierProvider(
        create: (context) => widget.store,
        child: Consumer<T>(
          builder: widget.builder!,
          child: widget.child,
        ),
      );
    }

    return ChangeNotifierProvider(
      create: (context) => widget.store,
      child: widget.child,
    );
  }
}
