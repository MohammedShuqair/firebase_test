import 'dart:math';

import 'package:flutter/material.dart';

class StreamSource {
  Stream<int> createIntStream() async* {
    while (true) {
      await _randomDuration();
      yield Random().nextInt(1000000);
    }
  }

  Stream<Color> createColorStream() async* {
    while (true) {
      await _randomDuration();
      yield Colors.primaries[Random().nextInt(Colors.primaries.length)];
    }
  }

  Future<void> _randomDuration() async {
    await Future.delayed(Duration(seconds: Random().nextInt(4)));
  }
}
