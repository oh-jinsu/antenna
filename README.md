A lean, flexible state management library for flutter.

## Features

### Declare your various events.

You can list all the events that will happen in your app.

### Implement your tiny store. 

You can store the current state of a particular model separately.

### Intercept the side effects. 

You should finish all the job with side effects before changing the state.

### Keep your stores and effects for a certain period. 

You can also specify when your stores and effects start or stop to listen to events.

## Getting started

```
flutter pub add antenna
```

## Usage

### Declare your various events.

```dart
const increment = "increment";
```

### Implement your tiny store. 

```dart
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
```

### Intercept the side effects. 

```dart
setRandomNumberEffect(event) {
  if (event == random) {
    final value = Random().nextInt(100);

    dispatch(SetNumber(value));
  }
}
```

### Keep your stores and effects for a certain period.

```dart
final subscription = connect(counterStore);

final subscription = listen(setRandomNumberEffect);
```

### Antenna manager helps to control your subscriptions by the life cycle.

```dart
class _MyCounterState extends State<MyCounter> with AntennaManager {
  @override
  void initState() {
    $connect(counterStore);

    $listen(setRandomNumberEffect);

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
```