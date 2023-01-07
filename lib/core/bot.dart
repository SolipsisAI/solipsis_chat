import 'dart:async';
import 'package:async_task/async_task.dart';

class ChatBot {
  final List<ChatRequest> requests = [];
  
  late AsyncExecutor asyncExecutor;
  late SharedData<List<String>, List<String>> rawTexts;

  ChatBot() {
    // Raw Texts
    rawTexts = SharedData<List<String>, List<String>>([]);

    // Initialize executor
    asyncExecutor = AsyncExecutor(
      sequential: true,
      parallelism: 2,
      taskTypeRegister: _taskTypeRegister,
    );
    asyncExecutor.logger.enabled = true;
  }

  void makeRequest(String rawText) {
    requests.add(ChatRequest(rawText, rawTexts));
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
    [ChatRequest("", SharedData<List<String>, List<String>>([]))];

// A task that checks if a number is prime:
class ChatRequest extends AsyncTask<String, bool> {
  // The number to check if is prime.
  final String rawText;

  // A list of known primes, shared between tasks.
  final SharedData<List<String>, List<String>> rawTexts;

  ChatRequest(this.rawText, this.rawTexts);

  // Instantiates a `PrimeChecker` task with `parameters` and `sharedData`.
  @override
  ChatRequest instantiate(String parameters,
      [Map<String, SharedData>? sharedData]) {
    return ChatRequest(
      parameters,
      sharedData!['rawTexts'] as SharedData<List<String>, List<String>>,
    );
  }

  // The `SharedData` of this task.
  @override
  Map<String, SharedData> sharedData() => {'rawTexts': rawTexts};

  // Loads the `SharedData` from `serial` for each key.
  @override
  SharedData<List<String>, List<String>> loadSharedData(String key, dynamic serial) {
    switch (key) {
      case 'rawTexts':
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
  FutureOr<bool> run() {
    print('rawText: $rawText');
    return true;
  }
}
