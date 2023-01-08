/* from: https://github.com/am15h/object_detection_flutter/blob/master/lib/tflite/classifier.dart */
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

const vocabFile = 'emotion_classification.vocab.txt';
const modelFile = 'emotion_classification.tflite';
const int _sentenceLen = 256;
const String start = '[CLS]';
const String pad = '[PAD]';
const String unk = '[UNK]';
const String sep = '[SEP]';

/// Classifier
class Classifier {
  /// Instance of Interpreter
  late Interpreter _interpreter;

  /// Vocab file
  late Map<String, int> dict;

  /// Input size of image (height = width = 300)
  static const int INPUT_SIZE = 300;

  /// Result score threshold
  static const double THRESHOLD = 0.5;

  /// Padding the image to transform into square
  late int padSize;

  /// Number of results to show
  static const int NUM_RESULTS = 10;

  Classifier({Interpreter? interpreter, Map<String, int>? dict}) {
    loadModel(interpreter: interpreter);
    loadDictionary(dict: dict);
  }

  /// Loads interpreter from asset
  void loadModel({ Interpreter? interpreter }) async {
    try {
      _interpreter =
          interpreter ??
            await Interpreter.fromAsset(
              modelFile,
              options: InterpreterOptions()..threads = 4,
            );
    } catch (e) {
      print("Error while creating interpreter: $e");
    }
  }

  void loadDictionary({ Map<String, int>? dict }) async {
    if (dict != null) {
      dict = dict;
    }

    final vocab = await rootBundle.loadString('assets/$vocabFile');

    var _dict = <String, int>{};
    final vocabList = vocab.split('\n');
    for (var i = 0; i < vocabList.length; i++) {
      var entry = vocabList[i].trim().split(' ');
      _dict[entry[0]] = int.parse(entry[1]);
    }

    dict = _dict;
    print('$vocabFile loaded successfully as Dictionary');
  }

  List<List<int>> preprocessText(String rawText) {
    return tokenizeInputText(rawText);
  }

  List<List<int>> tokenizeInputText(String text) {
    // Whitespace tokenization
    final toks = text.split(' ');

    // Create a list of length==_sentenceLen filled with the value <pad>
    var vec = List<int>.filled(_sentenceLen, dict[pad]!);

    var index = 0;
    if (dict.containsKey(start)) {
      vec[index++] = dict[start]!;
    }

    // For each word in sentence find corresponding index in dict
    for (var tok in toks) {
      if (index > _sentenceLen) {
        break;
      }
      var encoded = wordPiece(tok.toLowerCase());
      for (var word in encoded) {
        vec[index++] = dict.containsKey(word.toLowerCase())
            ? dict[word.toLowerCase()]!
            : dict[unk]!;
      }
    }

    // EOS
    vec[index++] = dict[sep]!;

    // returning List<List<double>> as our interpreter input tensor expects the shape, [1,256]
    return [vec];
  }

  List<String> wordPiece(String input) {
    var word = input;
    var tokens = [word];

    while (word.isNotEmpty) {
      var i = word.length;
      var key = word.substring(0, i);
      var inVocab = dict.containsKey(key);
      while (i > 0 && !inVocab) {
        i -= 1;
      }

      if (i == 0) {
        return [unk];
      }

      if (!tokens.contains(key)) {
        tokens.add(key);
      }

      word = (i + 1 < key.length) ? key.substring(i + 1, key.length) : "";

      if (word.isNotEmpty) {
        word = '##$word';
      }
    }

    return tokens;
  }

  /// Runs object detection on the input image
  String predict(String rawText) {
    var predictStartTime = DateTime.now().millisecondsSinceEpoch;
    var preProcessStart = DateTime.now().millisecondsSinceEpoch;

    // Pre-process TensorImage
    List<List<int>> input = preprocessText(rawText);

    // Setup output
    var output = List<double>.filled(6, 0).reshape([1, 6]);

    var preProcessElapsedTime =
        DateTime.now().millisecondsSinceEpoch - preProcessStart;

    var inferenceTimeStart = DateTime.now().millisecondsSinceEpoch;

    // run inference
    _interpreter.run(input, output);

    var inferenceTimeElapsed =
        DateTime.now().millisecondsSinceEpoch - inferenceTimeStart;

    var predictElapsedTime =
        DateTime.now().millisecondsSinceEpoch - predictStartTime;

    return {
      "recognitions": recognitions,
      "stats": Stats(
          totalPredictTime: predictElapsedTime,
          inferenceTime: inferenceTimeElapsed,
          preProcessingTime: preProcessElapsedTime)
    };
  }

  /// Gets the interpreter instance
  Interpreter get interpreter => _interpreter;
}
