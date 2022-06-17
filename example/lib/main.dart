import 'dart:math';

import 'package:antenna/antenna.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

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

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with AntennaManager {
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
            watch(counterStore)((data) => Text(data.toString())),
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
