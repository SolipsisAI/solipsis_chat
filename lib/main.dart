import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

import 'chat.dart';
import 'models/chat_message.dart';
import 'models/chat_user.dart';

void main() async {
  final Isar _isar = await Isar.open(
      schemas: [ChatMessageSchema, ChatUserSchema], directory: 'data');
  runApp(SolipsisChat(isar: _isar));
}

class SolipsisChat extends StatelessWidget {
  const SolipsisChat({Key? key, required this.isar}) : super(key: key);

  final Isar isar;

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
          home: SolipsisChatHome(isar: isar),
        ));
  }
}
