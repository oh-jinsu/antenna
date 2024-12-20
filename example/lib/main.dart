import 'package:channel_store/channel_store.dart';
import 'package:example/controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: ChannelProvider(
        child: ControllerProvider(
          store: CountController(),
          child: const MyCounter(),
        ),
      ),
    ),
  );
}

class MyCounter extends StatefulWidget {
  const MyCounter({super.key});

  @override
  State<MyCounter> createState() => _MyCounterState();
}

class _MyCounterState extends State<MyCounter> with ChannelMixin {
  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("MyCounter Rendered");
    }

    return Scaffold(
      body: Column(
        children: [
          Consumer<CountController>(
            builder: (context, controller, child) =>
                Text("${controller.state}"),
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
    );
  }
}
