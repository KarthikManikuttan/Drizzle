import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drizzle/viewModels/services/auth_services.dart';
import 'package:drizzle/views/widgets/chat_bubble_widget.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class BuildMessageContainer extends StatelessWidget {
  final DocumentSnapshot documentSnapshot;
  const BuildMessageContainer({super.key, required this.documentSnapshot});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

    bool isCurrentUser = data['senderId'] == AuthServices().getCurrentUser!.uid;

    DateTime dateTime = (data['timeStamp'] as Timestamp).toDate();

    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          Container(
            alignment: alignment,
            child: ChatBubbleWidget(
                message: data['message'], isCurrentUser: isCurrentUser),
          ),
          const SizedBox(height: 5),
          Container(
            alignment: alignment,
            child: Text(
              timeago.format(dateTime),
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xff797C7B),
                fontFamily: 'Caros',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
