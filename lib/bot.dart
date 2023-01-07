import 'classifiers/emotion_classifier.dart';
import 'classifiers/sentiment_classifier.dart';

class ChatBot {
  late EmotionClassifier emotionClassifier;
  late SentimentClassifier sentimentClassifier;

  ChatBot() {
    emotionClassifier = EmotionClassifier();
    sentimentClassifier = SentimentClassifier();
  }
}