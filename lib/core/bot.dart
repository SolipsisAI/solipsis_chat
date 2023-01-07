import 'dart:core';
import 'package:queue/queue.dart';

import '../classifiers/emotion_classifier.dart';
import '../classifiers/sentiment_classifier.dart';
import 'response.dart';

class ChatBot {
  final queue = Queue(delay: const Duration(milliseconds: 500));
  final responses = [];

  late EmotionClassifier emotionClassifier;
  late SentimentClassifier sentimentClassifier;

  ChatBot() {
    // Initialize classifiers
    emotionClassifier = EmotionClassifier();
    sentimentClassifier = SentimentClassifier();
  }

  void add(String rawText) async {
    // Add to queue
    queue.add(() => handleMessage(rawText));
  }

  Future<ChatResponse> handleMessage(String rawText) async {
    final emotion = await emotionClassifier.classify(rawText);
    final sentiment = await sentimentClassifier.classify(rawText);
    String sentimentLabel = sentiment == 0 ? "NEGATIVE" : "POSITIVE";

    String text = 'Your emotion is $emotion. Your sentiment is $sentimentLabel';

    return ChatResponse(text, emotion, sentiment);
  }
}
