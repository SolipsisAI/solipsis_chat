import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'storage/file.dart';
import 'models/chat_message.dart';

import 'chat.dart';

const String messagesBoxName = "messages";

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<ChatMessage>(ChatMessageAdapter());
  await Hive.openBox<ChatMessage>(messagesBoxName);
  runApp(SolipsisChat(storage: FileStorage()));
}

class SolipsisChat extends StatelessWidget {
  const SolipsisChat({Key? key, required this.storage}) : super(key: key);

  final FileStorage storage;

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
          home: Scaffold(
            body: ValueListenableBuilder(
              valueListenable: Hive.box<ChatMessage>('messages').listenable(),
              builder: (context, box, widget) {
                return SolipsisChatHome(storage: storage);
              },
            ),
          ),
        ));
  }
}
