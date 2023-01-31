import 'package:flutter/foundation.dart';
import 'dart:async';

class Debouncer {
  final int delay;
  Timer? _timer;

  Debouncer({required this.delay});

  run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: delay), action);
  }
}
