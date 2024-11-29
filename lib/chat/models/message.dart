import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String? text;
  Timestamp? time;
  String? senderId;
  String? receiverId;

  MessageModel({this.text, this.time, this.senderId, this.receiverId});

  bool isCurrentUserSender(String uid) {
    return senderId == uid;
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        text: json["text"],
        time: json["time"] == null
            ? null
            : Timestamp.fromMillisecondsSinceEpoch(json["time"]),
        senderId: json["sender_id"],
      );

  Map<String, dynamic> toJson() {
    return {
      "text": text,
      "time": time?.millisecondsSinceEpoch,
      "sender_id": senderId,
    };
  }
}
