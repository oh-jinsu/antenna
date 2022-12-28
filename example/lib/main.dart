import 'dart:math';

import 'package:antenna/antenna.dart';
import 'package:example/events.dart';
import 'package:example/store.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: MyCounter()));

class MyCounter extends StatefulWidget {
  const MyCounter({Key? key}) : super(key: key);

  @override
  State<MyCounter> createState() => _MyCounterState();
}

class _MyCounterState extends State<MyCounter> with AntennaMixin {
  @override
  void initState() {
    connect(counterStore);

    listen((event) {
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
