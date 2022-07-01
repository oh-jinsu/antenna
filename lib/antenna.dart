library antenna;

import 'package:rxdart/subjects.dart' show PublishSubject;

final _channel = PublishSubject();

Stream get antenna => _channel;

void dispatch(dynamic event) => _channel.sink.add(event);
