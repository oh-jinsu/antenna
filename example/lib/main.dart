import 'package:event_store/event_store.dart';
import 'package:example/store.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: ChannelProvider(child: MyCounter())));
}

class MyCounter extends StatefulWidget {
  const MyCounter({super.key});

  @override
  State<MyCounter> createState() => _MyCounterState();
}

class _MyCounterState extends State<MyCounter> with ChannelMixin {
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: CountStore(),
      child: Scaffold(
        body: Column(
          children: [
            Consumer<CountStore>(
              builder: (context, store, child) => Text("${store.state}"),
            ),
            TextButton(
              onPressed: () => dispatch("increment"),
              child: const Text("Increment"),
            ),
            TextButton(
              onPressed: () => dispatch("decrement"),
              child: const Text("Decrement"),
            ),
          ],
        ),
      ),
    );
  }
}
