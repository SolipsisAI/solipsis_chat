import 'package:flutter/material.dart';
import 'chat.dart';

void main() {
  runApp(const SolipsisChat());
}

class SolipsisChat extends StatelessWidget {
  const SolipsisChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SolipsisChatHome(),
    );
  }
}
