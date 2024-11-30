import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_test/features/notification/models/notification.dart';

/// list of notification model
class NotificationRepository {
  static const notificationCollection = "notifications";

  CollectionReference<Map<String, dynamic>> _getNotificationCollectionRef(
          String uid) =>
      FirebaseFirestore.instance
          .collection("users")

          /// [notification.message.receiverId] notification receiver
          .doc(uid)
          .collection(notificationCollection);

  Stream<List<NotificationModel>> getFirebaseNotification(
      String currentUserId) {
    return _getNotificationCollectionRef(currentUserId)
        .snapshots()
        .map((qSnapShot) {
      return qSnapShot.docs.map((doc) {
        return NotificationModel.fromJson(doc.data(), doc.id);
      }).toList();
    });
  }
}
