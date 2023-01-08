import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'chat_screen.dart';
import 'models/chat_message.dart';
import 'models/chat_user.dart';
import 'inference.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationSupportDirectory();
  final Isar _isar = await Isar.open(
      schemas: [ChatMessageSchema, ChatUserSchema], directory: dir.path);
  final chatMessages = await _isar.chatMessages.where().findAll();

  // listen to changes in the database
  final Stream<void> messagesChanged = _isar.chatMessages.watchLazy();
  messagesChanged.listen((event) {
    print('added message');
  });

  runApp(SolipsisChat(isar: _isar, chatMessages: chatMessages));
}

class SolipsisChat extends StatelessWidget {
  const SolipsisChat({Key? key, required this.isar, required this.chatMessages})
      : super(key: key);

  final Isar isar;
  final List<ChatMessage> chatMessages;

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
          home: ChatScreen(isar: isar, chatMessages: chatMessages),
        ));
  }
}
