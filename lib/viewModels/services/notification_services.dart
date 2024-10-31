import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationServices {
  Future<void> initializeNotification() async {
    await AwesomeNotifications().isNotificationAllowed().then(
      (isAllowed) async {
        if (!isAllowed) {
          await AwesomeNotifications().requestPermissionToSendNotifications();
        }
      },
    );
  }

  showNotification() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: "basic_channel",
        title: "notification test",
        body: "test notification",
        backgroundColor: const Color(0xFF3535CE),
        wakeUpScreen: true,
        color: const Color(0xFFB5CE35),
      ),
    );
  }
}
