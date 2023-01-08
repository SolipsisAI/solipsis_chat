import 'dart:async';
import 'package:async_task/async_task.dart';
import '../classifiers/emotion_classifier.dart';

Future<Function> classify(EmotionClassifier classifier) async {
  Future<String> process(String rawText) async {
    return 'TEXT TO PROCESS: $rawText';
  }

  return process;
}

class ChatRequest {
  final String rawText;
  final Function process;

  ChatRequest(this.rawText, this.process);
}

class ChatBot {
  final List<ChatTask> requests = [];
  late EmotionClassifier classifier;
  late AsyncExecutor asyncExecutor;
  late SharedData<List<String>, List<String>> processedTexts;

  ChatBot() {
    // Raw Texts
    processedTexts = SharedData<List<String>, List<String>>([]);

    // Classifier
    classifier = EmotionClassifier();

    // Initialize executor
    asyncExecutor = AsyncExecutor(
      sequential: true,
      parallelism: 2,
      taskTypeRegister: _taskTypeRegister,
    );
    asyncExecutor.logger.enabled = true;
  }

  void makeRequest(String rawText) {
    requests.add(ChatTask(rawText, processedTexts));
  }

  void processRequests() async {
    final requestsLen = requests.length;
    print('processing $requestsLen requests');
    asyncExecutor.executeAll(requests);
  }
}

// This top-level function returns the tasks types that will be registered
// for execution. Task instances are returned, but won't be executed and
// will be used only to identify the task type:
List<AsyncTask> _taskTypeRegister() =>
    [ChatTask("", SharedData<List<String>, List<String>>([]))];

// A task that checks if a number is prime:
class ChatTask extends AsyncTask<String, bool> {
  // The number to check if is prime.
  final String rawText;

  // A list of known primes, shared between tasks.
  final SharedData<List<String>, List<String>> processedTexts;

  ChatTask(this.rawText, this.processedTexts);

  @override
  AsyncTaskChannel? channelInstantiator() => AsyncTaskChannel();

  // Instantiates a `PrimeChecker` task with `parameters` and `sharedData`.
  @override
  ChatTask instantiate(String parameters,
      [Map<String, SharedData>? sharedData]) {
    return ChatTask(
      parameters,
      sharedData!['processedTexts'] as SharedData<List<String>, List<String>>,
    );
  }

  // The `SharedData` of this task.
  @override
  Map<String, SharedData> sharedData() => {'processedTexts': processedTexts};

  // Loads the `SharedData` from `serial` for each key.
  @override
  SharedData<List<String>, List<String>> loadSharedData(String key, dynamic serial) {
    switch (key) {
      case 'processedTexts':
        return SharedData<List<String>, List<String>>(serial);
      default:
        throw StateError('Unknown key: $key');
    }
  }

  // The parameters of this task:
  @override
  String parameters() {
    return rawText;
  }

  // Runs the task code:
  @override
  FutureOr<bool> run() async {
    print('rawText: $rawText');
    return true;
  }
}
