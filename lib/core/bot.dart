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

  ChatResponse handleMessage(String rawText) {
    String emotion = emotionClassifier.classify(rawText);
    int sentiment = sentimentClassifier.classify(rawText);
    String sentimentLabel = sentiment == 0 ? "NEGATIVE" : "POSITIVE";

    // TODO: templates
    String text = 'Your emotion is $emotion. Your sentiment is $sentimentLabel';

    return ChatResponse(text, emotion, sentiment);
  }
}
