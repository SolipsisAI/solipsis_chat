import 'dart:convert';
import 'dart:core';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import 'package:solipsis_chat/models/chat_message.dart';

const String loremIpsumApiUrl =
    'https://litipsum.com/api/dr-jekyll-and-mr-hyde/1/json';
const int wordsPerMinute = 300;

String randomString() {
  const uuid = Uuid();
  return uuid.v4().replaceAll('-', '');
}

Future<types.TextMessage> randomMessage(types.User user) async {
  final uri = Uri.parse(loremIpsumApiUrl);
  final response = await http.get(uri);
  final json = jsonDecode(response.body) as Map<String, dynamic>;
  final data = json['text'] as List<dynamic>;
  final text = data[0];
  return types.TextMessage(
    author: user,
    createdAt: currentTimestamp(),
    id: randomString(),
    text: text,
  );
}

int messageDelay(types.TextMessage message) {
  final List words = message.text.split(" ");
  final int wordCount = words.length;
  return (wordCount ~/ wordsPerMinute) * 60;
}

int currentTimestamp() {
  return DateTime.now().millisecondsSinceEpoch;
}

types.TextMessage convertLineToMessage(String line) {
  final regex = RegExp(r"^\[(.*?)\]:(.*)");
  final match = regex.firstMatch(line);
  final infoString = match!.group(1);
  final text = match.group(2);
  final info = infoString!.split('|');
  final authorId = info[1];
  return types.TextMessage(
    id: infoString,
    author: types.User(id: authorId),
    text: text!,
  );
}

types.TextMessage convertToMessage(ChatMessage message) {
  return types.TextMessage(
    id: message.id,
    author: types.User(id: message.authorId),
    text: message.text,
  );
}
