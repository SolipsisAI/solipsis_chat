import 'package:tflite_flutter/tflite_flutter.dart';
import '../utils.dart';

import 'classifier.dart';

const vocabFile = 'emotion_classification.vocab.txt';
const modelFile = 'emotion_classification.tflite';
const int _sentenceLen = 256;
const String start = '[CLS]';
const String pad = '[PAD]';
const String unk = '[UNK]';
const String sep = '[SEP]';

class EmotionClassifier extends Classifier {
  final List<String> labels = [
    "sadness",
    "joy",
    "love",
    "anger",
    "fear",
    "surprise"
  ];

  EmotionClassifier() : super(vocabFile, modelFile);

  String classify(String rawText) {
    // tokenizeInputText returns List<List<double>>
    // of shape [1, 256].
    List<List<int>> input = tokenizeInputText(rawText);

    // output of shape [1,6]
    // example: [[-1.434808373451233, -0.602688729763031, 4.8783135414123535, -1.720102071762085, -0.9065110087394714, -1.056220293045044]]
    var output = List<double>.filled(6, 0).reshape([1, 6]);

    // The run method will run inference and
    // store the resulting values in output.
    interpreter.run(input, output);

    // Compute the softmax
    final result = softmax(output[0]);
    print(result);
    final labelIndex = argMax(result);
    print("labelIndex: $labelIndex");
    return labels[labelIndex];
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
      var encodedWords = encodeWord(tok.toLowerCase());
      for (var encodedWord in encodedWords) {
        vec[index++] = dict.containsKey(encodedWord.toLowerCase())
            ? dict[encodedWord.toLowerCase()]!
            : dict[unk]!; 
      }
    }

    // EOS
    vec[index++] = dict[sep]!;

    // returning List<List<double>> as our interpreter input tensor expects the shape, [1,256]
    print(vec);
    return [vec];
  }

  List<String> encodeWord(String word) {
    var tokens = [word];
    var _word = word;

    while (_word.length > 0) {
      var i = _word.length;
      var key = _word.substring(0, _word.length - 1);
      while (i > 0 && !dict.containsKey(key)) {
        i -= 1;
      }
      if (i == 0) {
        return [unk];
      }
      tokens.add(key);
      _word = _word.substring(i, _word.length - 1);
      if (_word.length > 0) {
        _word = '##$_word';
      }
    }
    return tokens;
  }
}
