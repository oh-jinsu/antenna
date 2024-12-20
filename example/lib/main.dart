import 'package:channel_store/channel_store.dart';
import 'package:example/counter.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const ChannelProvider(
      child: MaterialApp(
        home: HomePage(),
      ),
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const CounterPage()));
          },
          child: const Text("Go to Counter"),
        ),
      ),
    );
  }
}
