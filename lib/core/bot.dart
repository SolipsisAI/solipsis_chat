import 'dart:isolate';

import 'package:flutter/foundation.dart';

import '../classifiers/emotion_classifier.dart';
import '../classifiers/sentiment_classifier.dart';
import 'response.dart';

class ChatBot {
  late EmotionClassifier emotionClassifier;
  late SentimentClassifier sentimentClassifier;

  ChatBot() {
    // Initialize classifiers
    emotionClassifier = EmotionClassifier();
    sentimentClassifier = SentimentClassifier();
  }

  Future<void> handleInBackground(String rawText) async {
    compute(testBackground, rawText);
  }

  static void testBackground(String rawText) {
    print('rawText: $rawText');
  }

  Future<ChatResponse> handleMessage(String rawText) async {
    final emotion = await emotionClassifier.classify(rawText);
    final sentiment = await sentimentClassifier.classify(rawText);
    String sentimentLabel = sentiment == 0 ? "NEGATIVE" : "POSITIVE";

    String text = 'Your emotion is $emotion. Your sentiment is $sentimentLabel';

    return ChatResponse(text, emotion, sentiment);
  }
}
