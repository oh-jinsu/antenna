A simple, lightweight state management library.

## Features

### Declare your various events.

You can list all the events that will happen in your app.

### Implement your tiny store. 

You can store the current state of a particular model separately.

### Intercept the side effects. 

You should finish all the job with side effects before changing the state.

### Keep your stores and effects for a certain period. 

You can also specify when your stores and effects is constructed and destoryed.

## Getting started

```
flutter pub add codux
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
on((event) {
  if (event == random) {
    final value = Random().nextInt(100);

    dispatch(SetNumber(value));
  }
});
```

### Keep your stores and effects for a certain period. 

```dart
class _MyHomePageState extends State<MyHomePage> with AntennaManager {
  @override
  void initState() {
    open(counterStore);
  }
  
  ...
}
```