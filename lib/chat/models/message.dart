import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String? text;
  Timestamp? time;
  String? senderId;

  MessageModel({
    this.text,
    this.time,
    this.senderId,
  });

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
