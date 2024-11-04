import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drizzle/viewModels/services/chat_services.dart';
import 'package:drizzle/views/screens/chat_page.dart';
import 'package:flutter/material.dart';

class NotificationServices {
  final Set<String> processedMessageIds = {};

  Future<void> initializeNotification() async {
    await AwesomeNotifications().isNotificationAllowed().then(
      (isAllowed) async {
        if (!isAllowed) {
          await AwesomeNotifications().requestPermissionToSendNotifications();
        }
      },
    );
  }

  void showNotification({required String title, required String body}) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
        channelKey: "basic_channel",
        title: title,
        body: body,
        backgroundColor: const Color(0xFF3535CE),
        wakeUpScreen: true,
        color: const Color(0xFFB5CE35),
        displayOnBackground: true,
        displayOnForeground: true,
        notificationLayout: NotificationLayout.Default,
      ),
    );
  }

  void listenForNewMessages(String senderId, String receiverId) {
    ChatServices().getMessages(senderId, receiverId).listen(
      (querySnapshot) {
        for (var change in querySnapshot.docChanges) {
          if (change.type == DocumentChangeType.added) {
            String messageId = change.doc.id;
            String senderName = change.doc['senderName'];
            String messageText = change.doc['message'];
            String chatId = ChatServices().getChatId(
              change.doc['senderId'],
              change.doc['receiverId'],
            );

            if (!processedMessageIds.contains(messageId) && ChatPage.activeChatId != chatId) {
              showNotification(title: senderName, body: messageText);

              processedMessageIds.add(messageId);
              break;
            }
          }
        }
      },
    );
  }
}
