import 'package:isar/isar.dart';

part 'chat_message.g.dart';

@Collection()
class ChatMessage {
  @Id()
  int? id;

  late int userId;
  late int createdAt;
  late int updatedAt;
  late String text;
  late String roomId;
  late String uuid;
}
