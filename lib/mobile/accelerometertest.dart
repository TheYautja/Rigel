import 'dart:async';
import 'package:sensors_plus/sensors_plus.dart';

class Acc {
  final void Function(int) click;
  final void Function(int) clear;

  late final StreamSubscription<AccelerometerEvent> _sub;

  static const double threshold = 2.5;
  static const double shootThreshold = 0.5;

  int _current = -1;

  Acc({
    required this.click,
    required this.clear,
  });

  void start() {
    _sub = accelerometerEvents.listen(_handleEvent);
  }

  void stop() {
    _sub.cancel();
  }

  void _setKey(int key) {
    if (_current == key) return;

    if (_current != -1) {
      clear(_current);
    }

    _current = key;

    if (key != -1) {
      click(key);
    }
  }

  void _handleEvent(AccelerometerEvent e) {

    if (e.y > threshold) {
      _setKey(6);
    } else if (e.x < -shootThreshold) {
      _setKey(5);
    } else if (e.y < -threshold) {
      _setKey(4);
    } else {
      _setKey(-1);
    }
  }
}
