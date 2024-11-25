import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_test/chat/models/message.dart';

class ChatRepository {
  static const messagesCollection = "messages";

  /// add authenticated user to firestore
  Future<void> addMessage(MessageModel message) async {
    await FirebaseFirestore.instance
        .collection(messagesCollection)
        .doc("${message.time!.millisecondsSinceEpoch}")
        .set(
            message.toJson(),
            SetOptions(
              merge: true,
            ));
  }

  Stream<List<MessageModel>> getChat() {
    return FirebaseFirestore.instance
        .collection(messagesCollection)
        .orderBy("time", descending: true)
        .snapshots()
        .map((qSnapShot) {
      return qSnapShot.docs
          .map((doc) => MessageModel.fromJson(doc.data()))
          .toList();
    });
  }
}
