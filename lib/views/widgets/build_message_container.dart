import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drizzle/viewModels/services/auth_services.dart';
import 'package:drizzle/views/widgets/chat_bubble_widget.dart';
import 'package:flutter/material.dart';

class BuildMessageContainer extends StatelessWidget {
  final DocumentSnapshot documentSnapshot;
  const BuildMessageContainer({super.key, required this.documentSnapshot});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

    bool isCurrentUser = data['senderId'] == AuthServices().getCurrentUser!.uid;

    var alignment = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: ChatBubbleWidget(message: data['message'], isCurrentUser: isCurrentUser),
    );
  }
}
