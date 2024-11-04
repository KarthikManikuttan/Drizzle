import 'package:drizzle/viewModels/services/auth_services.dart';
import 'package:drizzle/viewModels/services/notification_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirestoreServices {
  addUserDetails(
    UserCredential userCredential,
    String userName,
  ) async {
    await FirebaseMessaging.instance.requestPermission();
    await NotificationServices().initializeNotification();

    String fcm = await fcmToken();
    print("fcm ===== $fcm");
    await AuthServices()
        .firestore
        .collection("users")
        .doc(userCredential.user!.uid)
        .set(
      {
        'uid': userCredential.user!.uid,
        'email': AuthServices().getCurrentUser!.email,
        'userName': userName,
        'profileImage': AuthServices().getCurrentUser!.photoURL,
        'fcmToken': fcm,
      },
    );
  }

  updateFcm(UserCredential userCredential) async {
    String fcm = await fcmToken();

    await AuthServices()
        .firestore
        .collection("users")
        .doc(userCredential.user!.uid)
        .update(
      {
        'fcmToken': fcm,
      },
    );
  }

  fcmToken() async {
    final FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? fcm = await messaging.getToken();
    return fcm;
  }
}
