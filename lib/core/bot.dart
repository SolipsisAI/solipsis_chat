import 'dart:async';
import 'dart:math';
import 'package:async_task/async_task.dart';

import '../classifiers/classifier.dart';
import '../classifiers/emotion_classifier.dart';
import '../classifiers/sentiment_classifier.dart';
import 'response.dart';

Function handleMessage(Map<String, Classifier> classifiers) {
  return (rawText) {
    print('handleMessage');
    Map<String, String> results = {};
    classifiers.forEach((name, classifier) { results[name] = classifier.classify(rawText); });

    return results.values.join(', ');
  };
}

class ChatBot {
  final List<ChatRequest> requests = [];

  late AsyncExecutor asyncExecutor;
  late Map<String, Classifier> classifiers;

  late SharedData<List<Function>, List<String>> callbacks;

  ChatBot() {
    // Initialize executor
    asyncExecutor = AsyncExecutor(
      sequential: true,
      parallelism: 2,
      taskTypeRegister: _taskTypeRegister,
    );
    asyncExecutor.logger.enabled = true;

    // Initialize classifiers
    classifiers = {"emotion": EmotionClassifier(), "sentiment": SentimentClassifier()};

    // Init shared data
    callbacks = SharedData<List<Function>, List<String>>([handleMessage(classifiers)]);
  }

  void makeRequest(String rawText) {
    requests.add(ChatRequest(rawText, callbacks));
  }

}

// This top-level function returns the tasks types that will be registered
// for execution. Task instances are returned, but won't be executed and
// will be used only to identify the task type:
List<AsyncTask> _taskTypeRegister() =>
    [ChatRequest("", SharedData<List<Function>, List<String>>([]))];

// A task that checks if a number is prime:
class ChatRequest extends AsyncTask<String, bool> {
  // The number to check if is prime.
  final String text;

  // A list of known primes, shared between tasks.
  final SharedData<List<Function>, List<String>> callbacks;

  ChatRequest(this.text, this.callbacks);

  // Instantiates a `PrimeChecker` task with `parameters` and `sharedData`.
  @override
  ChatRequest instantiate(String parameters,
      [Map<String, SharedData>? sharedData]) {
    return ChatRequest(
      parameters,
      sharedData!['callbacks'] as SharedData<List<Function>, List<String>>,
    );
  }

  // The `SharedData` of this task.
  @override
  Map<String, SharedData> sharedData() => {'callbacks': callbacks};

  // Loads the `SharedData` from `serial` for each key.
  @override
  SharedData<List<Function>, List<String>> loadSharedData(String key, dynamic serial) {
    switch (key) {
      case 'knownPrimes':
        return SharedData<List<Function>, List<String>>(serial);
      default:
        throw StateError('Unknown key: $key');
    }
  }

  // The parameters of this task:
  @override
  String parameters() {
    return text;
  }

  // Runs the task code:
  @override
  FutureOr<bool> run() {
    return true;
  }
}
