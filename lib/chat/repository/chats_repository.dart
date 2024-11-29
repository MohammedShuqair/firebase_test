import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_test/chat/models/chat_model.dart';

class ChatsRepository {
  static const chatsCollection = "chats";

  Stream<List<ChatModel>> getChats(String uid) {
    return FirebaseFirestore.instance
        .collection(chatsCollection)
        .where("ids", arrayContains: uid)
        .snapshots()
        .map((qSnapShot) {
      return qSnapShot.docs
          .map((doc) => ChatModel.fromJson(doc.data(), doc.id))
          .toList();
    });
  }
}
