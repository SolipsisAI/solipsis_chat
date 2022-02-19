import 'package:flutter/material.dart';

import 'chat.dart';
import 'storage/file.dart';

void main() {
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
