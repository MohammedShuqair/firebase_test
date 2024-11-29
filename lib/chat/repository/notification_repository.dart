import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_test/chat/models/notification.dart';

class NotificationRepository {
  static const notificationCollection = "notifications";

  Future<void> addNotification(NotificationModel notification) async {
    await FirebaseFirestore.instance
        .collection("users")

        /// [notification.message.receiverId] notification receiver
        .doc(notification.message.receiverId)
        .collection(notificationCollection)
        .add(
          notification.toJson(),
        );
  }
}
