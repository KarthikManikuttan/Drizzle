import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drizzle/models/chat_model.dart';
import 'package:drizzle/viewModels/chat_view_model.dart';
import 'package:drizzle/viewModels/services/auth_services.dart';

class ChatServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection("users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  Future<void> sendMessage(String receiverId, String message) async {
    final String currentUserId = AuthServices().getCurrentUser!.uid;
    final String currentUserEmail = AuthServices().getCurrentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    ChatModel newMessage = ChatModel(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      receiverId: receiverId,
      message: message,
      timeStamp: timestamp,
    );
    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join("_");

    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .add(ChatViewModel().toMap(newMessage));
  }

  Stream<QuerySnapshot> getMessages(String currentUserId, String receiverId) {
    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("timeStamp", descending: false)
        .snapshots();
  }
}
