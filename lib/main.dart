import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'chat_screen.dart';
import 'models/chat_message.dart';
import 'models/chat_user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationSupportDirectory();
  final Isar _isar = await Isar.open(
      schemas: [ChatMessageSchema, ChatUserSchema], directory: dir.path);
  final chatMessages = await _isar.chatMessages.where().findAll();
  final dict = await loadDictionary('emotion_classification.vocab.txt');
  runApp(ProviderScope(child: SolipsisChat(isar: _isar, chatMessages: chatMessages, dict: dict)));
}

Future<Map<String, int>> loadDictionary(String vocabFile) async {
  final vocab = await rootBundle.loadString('assets/$vocabFile');
  var _dict = <String, int>{};
  final vocabList = vocab.split('\n');
  for (var i = 0; i < vocabList.length; i++) {
    var entry = vocabList[i].trim().split(' ');
    _dict[entry[0]] = int.parse(entry[1]);
  }
  print('$vocabFile loaded successfully as Dictionary');
  return _dict;
}

class SolipsisChat extends StatelessWidget {
  const SolipsisChat({Key? key, required this.isar, required this.chatMessages, required this.dict})
      : super(key: key);

  final Isar isar;
  final List<ChatMessage> chatMessages;
  final Map<String, int> dict;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: MaterialApp(
          title: 'SolipsisChat',
          home: ChatScreen(isar: isar, chatMessages: chatMessages, dict: dict),
        ));
  }
}
