import 'package:singleton/singleton.dart';
import '../classifiers/classifier.dart';
import '../classifiers/emotion_classifier.dart';
import '../classifiers/sentiment_classifier.dart';

class ChatCore {
  late Map<String, Classifier> classifiers;

  factory ChatCore() => Singleton<ChatCore>().instance;

  ChatCore.initialize()  {
    classifiers = {
      "emotion": EmotionClassifier(),
      "sentiment": SentimentClassifier()
    };
    Singleton.register(this);
  }

  String process(String rawText) {
    Map<String, String> results = {};
    classifiers.forEach((name, classifier) { results[name] = classifier.classify(rawText); });
    return results.values.join(', ');
  }
}
