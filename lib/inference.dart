import 'dart:isolate';
import 'classifier.dart';
import 'utils/isolate_utils.dart';

class Inference {
  late Classifier classifier;
  late IsolateUtils isolateUtils;

  Inference() {
    isolateUtils = IsolateUtils();
    isolateUtils.start();
    classifier = Classifier();
  }

  Future<Map<String, dynamic>> inference(String rawText) async {
    var isolateData = IsolateData(rawText, classifier.interpreter.address, classifier.dict);
    ReceivePort responsePort = ReceivePort();
    isolateUtils.sendPort
        .send(isolateData..responsePort = responsePort.sendPort);
    var results = await responsePort.first;
    return results;
  }
}