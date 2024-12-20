import 'package:channel_store/channel_store.dart';
import 'package:example/controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: ChannelProvider(
        child: ControllerProvider(
          controller: CountController(),
          child: const MyCounter(),
        ),
      ),
    ),
  );
}

class MyCounter extends StatelessWidget {
  const MyCounter({super.key});

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
            onPressed: () => Channel.of(context).dispatch("increment"),
            child: const Text("Increment"),
          ),
          TextButton(
            onPressed: () => Channel.of(context).dispatch("decrement"),
            child: const Text("Decrement"),
          ),
        ],
      ),
    );
  }
}
