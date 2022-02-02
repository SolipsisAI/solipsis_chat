import 'dart:math';
import 'dart:convert';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:http/http.dart' as http;

String randomString() {
  final random = Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}

Future<types.Message> randomMessage(types.User user) async {
  final uri = Uri.parse(
    'https://litipsum.com/api/pride-and-prejudice/1/json',
  );
  final response = await http.get(uri);
  final json = jsonDecode(response.body) as Map<String, dynamic>;
  final data = json['text'] as List<dynamic>;
  final text = data[0];
  return types.TextMessage(
    author: user,
    createdAt: DateTime.now().millisecondsSinceEpoch,
    id: randomString(),
    text: text,
  );
}
