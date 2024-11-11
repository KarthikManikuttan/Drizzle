import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserStateService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  void updateUserState({required String status}) async {
    await firestore.collection("users").doc(auth.currentUser!.uid).update(
      {
        'status': status,
      },
    );
  }

  getUserStatus({required String receiverId}) {
    return firestore.collection("users").doc(receiverId).snapshots();
  }
}
