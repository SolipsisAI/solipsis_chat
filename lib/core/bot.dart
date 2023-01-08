import 'dart:async';
import 'package:async_task/async_task.dart';
import '../classifiers/emotion_classifier.dart';

Function classify(EmotionClassifier classifier) {
  String process(String rawText) {
    return 'TEXT TO PROCESS: $rawText';
  }

  return process;
}

// make this json serializable
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
    classifier = EmotionClassifier();

    // Raw Texts
    processedTexts = SharedData<List<String>, List<String>>([]);

   // Initialize executor
    asyncExecutor = AsyncExecutor(
      sequential: true,
      parallelism: 2,
      taskTypeRegister: _taskTypeRegister,
    );
    asyncExecutor.logger.enabled = true;
  }

  void makeRequest(String rawText) {
    requests.add(ChatTask(ChatRequest(rawText, classify(classifier)), processedTexts));
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
    [ChatTask(ChatRequest("", (rawText) => {}), SharedData<List<String>, List<String>>([]))];

// A task that checks if a number is prime:
class ChatTask extends AsyncTask<ChatRequest, bool> {
  // The number to check if is prime.
  final ChatRequest request;

  // A list of known primes, shared between tasks.
  final SharedData<List<String>, List<String>> processedTexts;

  ChatTask(this.request, this.processedTexts);

  // Instantiates a `PrimeChecker` task with `parameters` and `sharedData`.
  @override
  ChatTask instantiate(ChatRequest parameters,
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
  ChatRequest parameters() {
    return request;
  }

  // Runs the task code:
  @override
  FutureOr<bool> run() async {
    print('rawText: ${request.rawText}');
    return true;
  }
}
