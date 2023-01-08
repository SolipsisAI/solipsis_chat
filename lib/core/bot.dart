import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import '../classifiers/emotion.dart';

class ChatBot {
  final Map<String, int> dict;
  final Interpreter model;
  late EmotionClassifier classifier;

  ChatBot(this.dict, this.model) {
    classifier = EmotionClassifier(model, dict);
  }

  Future<void> handleInBackground(String rawText) async {
    compute(classifier.classify, rawText);
  }
}
