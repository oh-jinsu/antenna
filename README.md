A simple and flexible state management library for flutter.

## Getting started

```
flutter pub add antenna
```

## Usage

### Predefined the data mutation. 

```dart
import 'package:antenna/store.dart';

class CountStore extends Store<int> {
  CountStore() : super(0);

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
```

### Dispatch event and get fresh data.

```dart
import 'package:antenna/antenna.dart';
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

```