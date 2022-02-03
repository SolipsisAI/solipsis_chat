import 'package:flutter/material.dart';
import 'chat.dart';

void main() {
  runApp(const SolipsisChat());
}

class SolipsisChat extends StatelessWidget {
  const SolipsisChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: const MaterialApp(
          title: 'SolipsisChat',
          home: SolipsisChatHome(),
        ));
  }
}
