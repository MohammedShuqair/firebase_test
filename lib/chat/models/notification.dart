import 'package:firebase_test/chat/models/message.dart';

class NotificationModel {
  final MessageModel message;
  final String name;

  NotificationModel({
    required this.message,
    required this.name,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> map) {
    return NotificationModel(
        message: MessageModel.fromJson(map["message"]), name: map["name"]);
  }

  Map<String, dynamic> toJson() {
    return {"name": name, "message": message.toJson()};
  }
}
