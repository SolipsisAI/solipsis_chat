import 'package:flutter/services.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class Classifier {
  late String vocabFile;
  late String modelFile;

  late Map<String, int> dict;
  late Interpreter interpreter;

  Classifier(this.vocabFile, this.modelFile) {
    _loadModel();
    _loadDictionary();
  }

  void _loadModel() async {
    // Creating the interpreter using Interpreter.fromAsset
    interpreter = await Interpreter.fromAsset('models/$modelFile');
    print('Interpreter $modelFile loaded successfully');
  }

  void _loadDictionary() async {
    final vocab = await rootBundle.loadString('assets/models/$vocabFile');
    var _dict = <String, int>{};
    final vocabList = vocab.split('\n');
    for (var i = 0; i < vocabList.length; i++) {
      var entry = vocabList[i].trim().split(' ');
      _dict[entry[0]] = int.parse(entry[1]);
    }
    dict = _dict;
    print('$vocabFile loaded successfully as Dictionary');
  }
}
