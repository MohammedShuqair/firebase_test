import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_test/features/chat/models/message.dart';
import 'package:firebase_test/features/notification/models/notification.dart';

class ChatRepository {
  static const messagesCollection = "messages";

  /// add authenticated user to firestore
  ///

  Future<void> addMessage(
      {required MessageModel message,
      required String chatId,
      required String senderName}) async {
    WriteBatch batch = FirebaseFirestore.instance.batch();
    final chatRef = FirebaseFirestore.instance.collection("chats").doc(chatId);

    final messageRef = chatRef
        .collection("messages")
        .doc("${message.time!.millisecondsSinceEpoch}");

    final notificationRef = FirebaseFirestore.instance
        .collection("users")
        .doc(message.receiverId)
        .collection("notifications")
        .doc();

    batch.set(
        chatRef,
        {
          "last_message": message.toJson(),
        },
        SetOptions(
          merge: true,
        ));

    batch.set(messageRef, message.toJson());
    batch.set(
        notificationRef,
        NotificationModel(
          message: message,
          name: senderName,
        ).toJson());
    await batch.commit();
  }

  Future addLastMessage(
      {required String chatId, required MessageModel message}) async {
    await FirebaseFirestore.instance
        .collection("chats")
        .doc(chatId)
        .set({"last_message": message.toJson()}, SetOptions(merge: true));
  }

  Stream<List<MessageModel>> getChat(String chatId) {
    return getMessagesCollectionRef(chatId)
        .orderBy("time", descending: true)
        .snapshots()
        .map((qSnapShot) {
      return qSnapShot.docs
          .map((doc) => MessageModel.fromJson(doc.data()))
          .toList();
    });
  }

  CollectionReference<Map<String, dynamic>> getMessagesCollectionRef(
      String chatId) {
    return FirebaseFirestore.instance
        .collection("chats")
        .doc(chatId)
        .collection(messagesCollection);
  }
}
