import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'chat_message.g.dart';

@HiveType(typeId: 1)
class ChatMessage {
  @HiveField(0)
  String id;

  @HiveField(1)
  String authorId;

  @HiveField(2)
  String text;

  @HiveField(3)
  int createdAt;

  ChatMessage(this.id, this.authorId, this.text, this.createdAt);
}
