import 'package:firebase_test/features/chat/models/message.dart';

class NotificationModel {
  final String? docId;
  final MessageModel? message;
  final String? name;

  NotificationModel({
    this.docId,
    required this.message,
    required this.name,
  });

  String getMessageText() {
    return message?.text ?? "";
  }

  factory NotificationModel.fromJson(Map<String, dynamic> map, String docId) {
    return NotificationModel(
      docId: docId,
      message:
          map["message"] == null ? null : MessageModel.fromJson(map["message"]),
      name: map["name"],
    );
  }

  /// used when adding notification
  Map<String, dynamic> toJson() {
    return {"name": name, "message": message?.toJson()};
  }
}
