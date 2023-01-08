import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:solipsis_chat/classifiers/emotion_classifier.dart';

final EmotionClassifier classifier = EmotionClassifier();

class ChatBot {
  final Map<String, int> dict;

  ChatBot(this.dict) : super();

  Future<void> handleInBackground(String rawText) async {
    compute(testBackground, rawText);
  }

  static void testBackground(String rawText) {
    print('rawText: $rawText');
  }
}
