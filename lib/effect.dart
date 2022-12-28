typedef Effect<T> = void Function(T event);

Effect when<T>(Effect<T> effect) {
  return (event) {
    if (event is T) {
      effect(event);
    }
  };
}
