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

  final knownPrimes = SharedData<List<int>, List<int>>([2, 3, 5]);
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
    requests.add(ChatRequest(0, knownPrimes));
  }

}

// This top-level function returns the tasks types that will be registered
// for execution. Task instances are returned, but won't be executed and
// will be used only to identify the task type:
List<AsyncTask> _taskTypeRegister() =>
    [ChatRequest(0, SharedData<List<int>, List<int>>([]))];

// A task that checks if a number is prime:
class ChatRequest extends AsyncTask<String, bool> {
  // The number to check if is prime.
  final String text;

  // A list of known primes, shared between tasks.
  final SharedData<List<int>, List<int>> knownPrimes;

  ChatRequest(this.text, this.knownPrimes);

  // Instantiates a `PrimeChecker` task with `parameters` and `sharedData`.
  @override
  ChatRequest instantiate(String parameters,
      [Map<String, SharedData>? sharedData]) {
    return ChatRequest(
      parameters,
      sharedData!['knownPrimes'] as SharedData<List<int>, List<int>>,
    );
  }

  // The `SharedData` of this task.
  @override
  Map<String, SharedData> sharedData() => {'knownPrimes': knownPrimes};

  // Loads the `SharedData` from `serial` for each key.
  @override
  SharedData<List<int>, List<int>> loadSharedData(String key, dynamic serial) {
    switch (key) {
      case 'knownPrimes':
        return SharedData<List<int>, List<int>>(serial);
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
  FutureOr<ChatResponse> run() {
    return ();
  }

  // A simple prime check function:
  bool isPrime(int n) {
    if (n < 2) return false;

    // The pre-computed primes, optimizing this checking algorithm:
    if (knownPrimes.data.contains(n)) {
      return true;
    }

    // If a number N has a prime factor larger than `sqrt(N)`,
    // then it surely has a prime factor smaller `sqrt(N)`.
    // So it's sufficient to search for prime factors in the range [1,sqrt(N)]:
    var limit = (sqrt(n) + 1).toInt();

    for (var p = 2; p < limit; ++p) {
      if (n % p == 0) return false;
    }

    return true;
  }
}
