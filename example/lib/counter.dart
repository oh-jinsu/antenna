import 'package:channel_store/channel_store.dart';
import 'package:example/controller.dart';
import 'package:flutter/material.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ControllerProvider(
      controller: CountController(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Counter"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer<CountController>(
                builder: (context, controller, child) =>
                    Text("${controller.state}"),
              ),
              ElevatedButton(
                onPressed: () => Channel.of(context).dispatch("increment"),
                child: const Text("Increment"),
              ),
              ElevatedButton(
                onPressed: () => Channel.of(context).dispatch("decrement"),
                child: const Text("Decrement"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
