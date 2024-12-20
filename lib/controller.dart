import 'package:channel_store/channel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class Controller<T> extends ChangeNotifier {
  late T _state;

  T get state {
    return _state;
  }

  Controller(T initial) {
    _state = reducer(initial, null);
  }

  @protected
  void init() {}

  @protected
  T reducer(T state, dynamic event);

  Future<T> reducerAsync(T state, dynamic event) async {
    return state;
  }

  void onListen(dynamic event) async {
    final result1 = await reducerAsync(state, event);

    final result2 = reducer(result1, event);

    update(result2);
  }

  @protected
  void update(T newState) {
    if (!shouldUpdate(state, newState)) {
      return;
    }

    _state = newState;

    notifyListeners();
  }

  bool shouldUpdate(T oldState, T newState) {
    return oldState != newState;
  }
}

class ControllerProvider<T extends Controller> extends StatefulWidget {
  final Widget? child;

  final T store;

  final Widget Function(BuildContext, T, Widget?)? builder;

  const ControllerProvider({
    super.key,
    this.child,
    required this.store,
    this.builder,
  });

  @override
  State<ControllerProvider<T>> createState() => _ControllerProviderState<T>();
}

class _ControllerProviderState<T extends Controller> extends State<ControllerProvider<T>>
    with ChannelMixin {
  @override
  void initState() {
    widget.store.init();

    super.initState();
  }

  @override
  void onListen(event) {
    widget.store.onListen(event);

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
