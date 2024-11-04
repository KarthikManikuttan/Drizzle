import 'package:drizzle/models/chat_model.dart';

class ChatViewModel {
  Map<String, dynamic> toMap(ChatModel chatModel) {
    return {
      'senderId': chatModel.senderId,
      'senderEmail': chatModel.senderEmail,
      'receiverId': chatModel.receiverId,
      'message': chatModel.message,
      'timeStamp': chatModel.timeStamp,
      'senderName': chatModel.senderName,
    };
  }
}
