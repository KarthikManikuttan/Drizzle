import 'package:drizzle/models/chat_model.dart';

class ChatViewModel {
  List<ChatModel> chats = [
    ChatModel(
      message: "hai",
      isSender: true,
      time: DateTime.now(),
    ),
    ChatModel(
      message: "hai",
      isSender: false,
      time: DateTime.now(),
    ),
    ChatModel(
      message: "hai",
      isSender: true,
      time: DateTime.now(),
    ),
    ChatModel(
      message: "hai",
      isSender: false,
      time: DateTime.now(),
    ),
    ChatModel(
      message: "hai",
      isSender: false,
      time: DateTime.now(),
    ),
    ChatModel(
      message: "hai",
      isSender: true,
      time: DateTime.now(),
    ),
  ];
}
