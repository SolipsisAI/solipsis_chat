import 'dart:developer' as logger;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:bubble/bubble.dart';
import 'package:http/http.dart' as http;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:solipsis_chat/models/chat_message.dart';

import 'storage/file.dart';
import 'utils.dart';

class SolipsisChatHome extends StatefulWidget {
  const SolipsisChatHome({Key? key, required this.storage}) : super(key: key);

  final FileStorage storage;
  @override
  _SolipsisChatHomeState createState() => _SolipsisChatHomeState();
}

class _SolipsisChatHomeState extends State<SolipsisChatHome> {
  bool _showTyping = false;
  int _page = 0;
  List<types.Message> _messages = [];

  final _user = const types.User(id: '06c33e8be835473680f463f44b66666c');
  final _bot = const types.User(id: '09778d0ffb944ac68d7296112805f3ad');

  final splitter = const LineSplitter();

  Box<ChatMessage> messagesBox = Hive.box<ChatMessage>("messages");

  @override
  void initState() {
    super.initState();
    setState(() {
      loadMessages();
    });
  }

  void loadMessages() {
    List<ChatMessage> messagesList = messagesBox.values.toList();
    int messagesCount = messagesList.length;
    for (var i = 0; i < messagesCount; i++) {
      _messages.insert(0, convertToMessage(messagesList[i]));
    }
  }

  Future<void> _handleEndReached() async {
    final uri = Uri.parse(
      'https://reqres.in/api/unknown?page=$_page&per_page=20',
    );
    final response = await http.get(uri);
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final data = json['data'] as List<dynamic>;
    logger.log('data: $data');
    final messages = data
        .map(
          (e) => types.TextMessage(
            author: _user,
            id: '$e["id"]',
            text: e['name'] as String,
          ),
        )
        .toList();
    logger.log('messages: $messages');
    setState(() {
      _messages = [..._messages, ...messages];
      _page = _page + 1;
    });
  }

  Future<void> _handleBotResponse() async {
    _showTyping = true;
    final message = await randomMessage(_bot);
    await Future.delayed(
        Duration(seconds: messageDelay(message)), () => _showTyping = false);
    _addMessage(message);
  }

  void _addMessage(types.TextMessage message) {
    setState(() {
      _messages.insert(0, message);
      widget.storage.writeNote(message);
      messagesBox.add(ChatMessage(
          message.id, message.author.id, message.text, currentTimestamp()));
    });
    logger.log('data: $message');
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: currentTimestamp(),
      id: randomString(),
      text: message.text,
    );

    _addMessage(textMessage);
    _handleBotResponse();
  }

  Widget _bubbleBuilder(
    Widget child, {
    required message,
    required nextMessageInGroup,
  }) {
    return Bubble(
      child: child,
      color: _user.id != message.author.id ||
              message.type == types.MessageType.image
          ? const Color(0xfff5f5f7)
          : const Color(0xff6f61e8),
      margin: nextMessageInGroup
          ? const BubbleEdges.symmetric(horizontal: 6)
          : null,
      nip: nextMessageInGroup
          ? BubbleNip.no
          : _user.id != message.author.id
              ? BubbleNip.leftBottom
              : BubbleNip.rightBottom,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Chat(
        messages: _messages,
        onSendPressed: _handleSendPressed,
        user: _user,
        bubbleBuilder: _bubbleBuilder,
        onEndReached: _handleEndReached,
        showTyping: _showTyping,
        showUserAvatars: true,
        showUserNames: true,
      ),
    );
  }
}
