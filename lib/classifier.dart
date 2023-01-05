import 'package:flutter/services.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'utils.dart';

class Classifier {
  final _vocabFile = 'text_classification_vocab.bert.txt';
  final _modelFile = 'text_classification.bert.tflite';

  // Maximum length of sentence
  final int _sentenceLen = 256;

  final String start = '[CLS]';
  final String pad = '[PAD]';
  final String unk = '[UNK]';
  final String sep = '[SEP]';

  late Map<String, int> _dict;
  late Interpreter _interpreter;

  final List<String> labels = [
    "sadness",
    "joy",
    "love",
    "anger",
    "fear",
    "surprise"
  ];

  Classifier() {
    // Load model when the classifier is initialized.
    _loadModel();
    _loadDictionary();
  }

  void _loadModel() async {
    // Creating the interpreter using Interpreter.fromAsset
    _interpreter = await Interpreter.fromAsset(_modelFile);
    print('Interpreter loaded successfully');
  }

  void _loadDictionary() async {
    final vocab = await rootBundle.loadString('assets/$_vocabFile');
    var dict = <String, int>{};
    final vocabList = vocab.split('\n');
    for (var i = 0; i < vocabList.length; i++) {
      var entry = vocabList[i].trim().split(' ');
      dict[entry[0]] = int.parse(entry[1]);
    }
    _dict = dict;
    print('Dictionary loaded successfully');
  }

  String classify(String rawText) {
    // tokenizeInputText returns List<List<double>>
    // of shape [1, 256].
    List<List<int>> input = tokenizeInputText(rawText);

    // output of shape [1,6]
    // example: [[-1.434808373451233, -0.602688729763031, 4.8783135414123535, -1.720102071762085, -0.9065110087394714, -1.056220293045044]]
    var output = List<double>.filled(6, 0).reshape([1, 6]);

    // The run method will run inference and
    // store the resulting values in output.
    _interpreter.run(input, output);

    // Compute the softmax
    final result = softmax(output[0]).toList();
    final labelIndex = argMax(result);
    return labels[labelIndex];
  }

  List<List<int>> tokenizeInputText(String text) {
    // Whitespace tokenization
    final toks = text.split(' ');

    // Create a list of length==_sentenceLen filled with the value <pad>
    var vec = List<int>.filled(_sentenceLen, _dict[pad]!);

    var index = 0;
    if (_dict.containsKey(start)) {
      vec[index++] = _dict[start]!;
    }

    // For each word in sentence find corresponding index in dict
    for (var tok in toks) {
      if (index > _sentenceLen) {
        break;
      }
      vec[index++] = _dict.containsKey(tok.toLowerCase())
          ? _dict[tok.toLowerCase()]!
          : _dict[unk]!;
    }

    // EOS
    vec[index++] = _dict[sep]!;

    // returning List<List<double>> as our interpreter input tensor expects the shape, [1,256]
    print(vec);
    return [vec];
  }
}
