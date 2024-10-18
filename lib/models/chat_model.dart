class ChatModel {
  final String message;
  final bool isSender;
  final DateTime time;

  ChatModel({
    required this.message,
    required this.isSender,
    required this.time,
  });
}
