import 'package:rxdart/subjects.dart' show PublishSubject;

final channel = PublishSubject();

void dispatch(event) {
  return channel.sink.add(event);
}
