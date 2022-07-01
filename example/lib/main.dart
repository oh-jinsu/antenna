import 'dart:math';

import 'package:antenna/antenna.dart';
import 'package:antenna/manager.dart';
import 'package:antenna/consumer.dart';
import 'package:antenna/store.dart';
import 'package:flutter/material.dart';

const increment = "Increment";

const decrement = "decrement";

const random = "random";

class SetNumber {
  final int value;

  const SetNumber(this.value);
}

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

class MyCounter extends StatefulWidget {
  const MyCounter({Key? key}) : super(key: key);

  @override
  State<MyCounter> createState() => _MyCounterState();
}

class _MyCounterState extends State<MyCounter> with AntennaManager {
  @override
  void initState() {
    open(counterStore);

    on((event) {
      if (event == random) {
        final value = Random().nextInt(100);

        dispatch(SetNumber(value));
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StoreConsumer(
              store: counterStore,
              builder: (context, data) => Text(data.toString()),
            ),
            TextButton(
              onPressed: () => dispatch(increment),
              child: const Text("Increment"),
            ),
            TextButton(
              onPressed: () => dispatch(decrement),
              child: const Text("Decrement"),
            ),
            TextButton(
              onPressed: () => dispatch(random),
              child: const Text("Random"),
            ),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(const MaterialApp(home: MyCounter()));
