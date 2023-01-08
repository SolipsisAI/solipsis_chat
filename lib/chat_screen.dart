import 'dart:developer' as logger;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:bubble/bubble.dart';
import 'package:http/http.dart' as http;
import 'package:isar/isar.dart';

import 'models/chat_message.dart';
import 'utils/helpers.dart';
import 'ui/bot_view.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key, required this.isar, required this.chatMessages})
      : super(key: key);

  final Isar isar;
  final List<ChatMessage> chatMessages;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with WidgetsBindingObserver {
  bool predicting = false;
  bool _showTyping = false;
  int _page = 0;

  List<types.Message> _messages = [];
  List<String> _userMessages = [];

  final _user = const types.User(id: '06c33e8b-e835-4736-80f4-63f44b66666c');
  final _bot = const types.User(id: '09778d0f-fb94-4ac6-8d72-96112805f3ad');

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < widget.chatMessages.length; i++) {
      setState(() {
        _messages.insert(
            0,
            types.TextMessage(
                author: types.User(id: widget.chatMessages[i].userUuid),
                id: widget.chatMessages[i].uuid,
                createdAt: widget.chatMessages[i].createdAt,
                text: widget.chatMessages[i].text));
      });
    }
  }

/*  void initStateAsync() async {
    WidgetsBinding.instance.addObserver(this);

    // Spawn a new isolate
    isolateUtils = IsolateUtils();
    await isolateUtils.start();

    // Create an instance of classifier to load model and labels
    classifier = Classifier();

    // Initially predicting = false
    predicting = false;

    for (var i = 0; i < widget.chatMessages.length; i++) {
      setState(() {
        _messages.insert(
            0,
            types.TextMessage(
                author: types.User(id: widget.chatMessages[i].userUuid),
                id: widget.chatMessages[i].uuid,
                createdAt: widget.chatMessages[i].createdAt,
                text: widget.chatMessages[i].text));
      });
    }

    messagesChanged = widget.isar.chatMessages.watchLazy();

    messagesChanged.listen((event) async {
      print('messages added');
      if (_userMessages.isNotEmpty) {
        print('processing');
        final String latest = _userMessages.last;
        var isolateData = IsolateData(latest, classifier.interpreter.address, classifier.dict);
        final result = await inference(isolateData);
        print(result);
      }
    });
  }*/

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
    return Scaffold(
      body: SafeArea(
          bottom: false,
          child: Stack(children: <Widget>[
            BotView(resultsCallback: resultsCallback),
            Chat(
              messages: _messages,
              onSendPressed: _handleSendPressed,
              user: _user,
              bubbleBuilder: _bubbleBuilder,
              onEndReached: _handleEndReached,
              showTyping: _showTyping,
              showUserAvatars: true,
              showUserNames: true,
            ),
          ])),
    );
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

  void _addMessage(types.TextMessage message) async {
    final newMessage = ChatMessage()
      ..createdAt = message.createdAt!
      ..userUuid = message.author.id
      ..uuid = message.id
      ..text = message.text;

    await widget.isar.writeTxn((isar) async {
      await isar.chatMessages.put(newMessage);
    });

    setState(() {
      _messages.insert(0, message);
    });
    logger.log('data: $message');
  }

  void _handleSendPressed(types.PartialText message) async {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: currentTimestamp(),
      id: randomString(),
      text: message.text,
    );

    _addMessage(textMessage);

    setState(() {
      _userMessages.add(message.text);
    });
  }

  void resultsCallback(Map<String, dynamic> results) {
    setState(() {
      types.TextMessage message =
          types.TextMessage(author: _bot, id: _bot.id, text: results['label']);
      _addMessage(message);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
