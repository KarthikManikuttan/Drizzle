import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String message;
  final String senderId;
  final String senderEmail;
  final String receiverId;
  final Timestamp timeStamp;

  ChatModel({
    required this.senderId,
    required this.senderEmail,
    required this.receiverId,
    required this.message,
    required this.timeStamp,
  });
}
