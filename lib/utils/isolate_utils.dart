/*
Run inference in an Isolate so the UI isn't blocked
Source: https://github.com/am15h/object_detection_flutter/blob/master/lib/utils/isolate_utils.dart
* */

import 'dart:isolate';

import 'package:tflite_flutter/tflite_flutter.dart';

import '../classifier.dart';

/// Manages separate Isolate instance for inference
class IsolateUtils {
  static const String DEBUG_NAME = "InferenceIsolate";

  late Isolate _isolate;
  final ReceivePort _receivePort = ReceivePort();
  late SendPort _sendPort;

  SendPort get sendPort => _sendPort;

  Future<void> start() async {
    _isolate = await Isolate.spawn<SendPort>(
      entryPoint,
      _receivePort.sendPort,
      debugName: DEBUG_NAME,
    );

    _sendPort = await _receivePort.first;
  }

  static void entryPoint(SendPort sendPort) async {
    final port = ReceivePort();
    sendPort.send(port.sendPort);

    await for (final IsolateData isolateData in port) {
      Classifier classifier = Classifier(
          interpreter:
              Interpreter.fromAddress(isolateData.interpreterAddress),
          dict: isolateData.dict);

      String result = classifier.predict(isolateData.rawText);

      isolateData.responsePort.send(result);
    }
  }
}

/// Bundles data to pass between Isolate
class IsolateData {
  final String rawText;
  late int interpreterAddress;
  late Map<String, int> dict;
  late SendPort responsePort;

  IsolateData(
    this.rawText,
    this.interpreterAddress,
    this.dict
  );
}
