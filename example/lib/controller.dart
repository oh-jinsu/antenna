import 'package:channel_store/channel_store.dart';

class CountController extends Controller<int> {
  CountController() : super(0);

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
