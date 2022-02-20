import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

import 'chat.dart';
import 'storage/file.dart';
import 'models/message.dart';

const String messagesBoxName = "messages";

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<Message>(MessageAdapter());
  await Hive.openBox<Message>(messagesBoxName);
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
          home: SolipsisChatHome(storage: storage),
        ));
  }
}
