import 'dart:io';
import 'dart:isolate';

import 'dart:developer' as logger;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:bubble/bubble.dart';
import 'package:http/http.dart' as http;
import 'package:isar/isar.dart';

import '../classifier.dart';
import '../models/chat_message.dart';
import '../utils/helpers.dart';
import '../utils/isolate_utils.dart';

class BotView extends StatefulWidget {
  final Function(Map<String, dynamic> results) resultsCallback;

  const BotView({Key? key, required this.resultsCallback}) : super(key: key);

  @override
  _BotViewState createState() => _BotViewState();
}

class _BotViewState extends State<BotView> with WidgetsBindingObserver {
  bool predicting = false;
  late Classifier classifier;
  late IsolateUtils isolateUtils;

  @override
  void initState() {
    super.initState();
    initStateAsync();
  }

  void initStateAsync() async {
    WidgetsBinding.instance.addObserver(this);

    // Spawn a new isolate
    isolateUtils = IsolateUtils();
    await isolateUtils.start();

    // Create an instance of classifier to load model and labels
    classifier = Classifier();

    // Initially predicting = false
    predicting = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Future<Map<String, dynamic>> inference(IsolateData isolateData) async {
    ReceivePort responsePort = ReceivePort();
    isolateUtils.sendPort
        .send(isolateData..responsePort = responsePort.sendPort);
    var results = await responsePort.first;
    return results;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}