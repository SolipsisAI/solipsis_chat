import 'dart:async';
import 'dart:io';

import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:path_provider/path_provider.dart';

import 'utils.dart';

class FileStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/notes.txt');
  }

  Future<String> readNotes() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return '';
    }
  }

  Future<File> writeNote(types.TextMessage message) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString(
      '[${currentTimestamp()}|${message.author.id}]: ${message.text}\n',
      mode: FileMode.append,
    );
  }
}
