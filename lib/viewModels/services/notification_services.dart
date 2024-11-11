import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:drizzle/views/screens/chat_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'chat_services.dart'; // Import your ChatServices

class NotificationServices {
  static const String hiveBoxName = 'notifications';
  static const String processedMessagesKey = 'processedMessageIds';
  Box? hiveBox;

  Future<void> initializeNotification() async {
    await _initializeHive();
    await AwesomeNotifications().isNotificationAllowed().then(
      (isAllowed) async {
        if (!isAllowed) {
          await AwesomeNotifications().requestPermissionToSendNotifications();
        }
      },
    );
  }

  Future<void> _initializeHive() async {
    if (hiveBox == null) {
      final appDocDir = await getApplicationDocumentsDirectory();
      Hive.init(appDocDir.path);
      hiveBox = await Hive.openBox(hiveBoxName);
    }
  }

  Future<void> showNotification(
      {required String title, required String body, required String iconUrl}) async {
    String? localImagePath = await _saveImage(iconUrl: iconUrl);
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
        largeIcon: localImagePath != null ? 'file://$localImagePath' : null,
      ),
    );
  }

  void listenForNewMessages(String senderId, String receiverId, {required String icon}) async {
    await _initializeHive(); 
    ChatServices().getMessages(senderId, receiverId).listen(
      (querySnapshot) {
        for (var change in querySnapshot.docChanges) {
          if (change.type == DocumentChangeType.added) {
            String messageId = change.doc.id;

            if (_isMessageProcessed(messageId)) {
              continue;
            }

            _markMessageAsProcessed(messageId);

            String senderName = change.doc['senderName'];
            String messageText = change.doc['message'];
            String chatId = ChatServices().getChatId(
              change.doc['senderId'],
              change.doc['receiverId'],
            );

            if (ChatPage.activeChatId != chatId) {
              showNotification(title: senderName, body: messageText, iconUrl: icon);
            }
          }
        }
      },
    );
  }

  bool _isMessageProcessed(String messageId) {
    final processedMessages = hiveBox?.get(processedMessagesKey, defaultValue: <String>[]);
    return processedMessages.contains(messageId);
  }

  void _markMessageAsProcessed(String messageId) {
    final processedMessages = hiveBox?.get(processedMessagesKey, defaultValue: <String>[]);
    processedMessages.add(messageId);
    hiveBox?.put(processedMessagesKey, processedMessages);
  }

  Future<String?> _saveImage({required String iconUrl}) async {
    Dio dio = Dio();
    try {
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.png';
      final response = await dio.download(iconUrl, imagePath);
      if (response.statusCode == 200) {
        return imagePath;
      }
    } catch (e) {
      print('Error downloading image: $e');
    }
    return null;
  }
}
