import 'package:antenna/store.dart';
import 'package:example/events.dart';

final counterStore = createStore<int>(({
  int state = 0,
  dynamic event,
}) {
  if (event == increment) {
    return state + 1;
  }

  if (event == decrement) {
    return state - 1;
  }

  if (event is SetNumber) {
    return event.value;
  }

  return state;
});
