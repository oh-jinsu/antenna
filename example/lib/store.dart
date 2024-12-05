import 'package:channel_store/channel_store.dart';

class CountStore extends Store<int> {
  CountStore() : super(0);

  @override
  reducer(state, event) {
    if (event == "increment") {
      return state + 1;
    }

    if (event == "decrement") {
      return state - 1;
    }

    return state;
  }
}
