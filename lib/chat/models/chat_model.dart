import 'package:firebase_test/chat/models/message.dart';

class ChatModel {
  /// list of user ids, to get user chats only
  /// last message
  final String id;
  final List<String> ids;
  final MessageModel? lastMessage;

  ChatModel({
    required this.id,
    required this.ids,
    required this.lastMessage,
  });

  String? getOtherUid(String inputUid) {
    for (final uid in ids) {
      if (inputUid != uid) {
        return uid;
      }
    }
    return null;
  }

  Map<String, dynamic> toJson() {
    return {
      'ids': ids,
      'last_message': lastMessage?.toJson(),
    };
  }

  factory ChatModel.fromJson(Map<String, dynamic> map, String chatId) {
    return ChatModel(
      id: chatId,
      ids: List<String>.from(map['ids'] ?? []),
      lastMessage: map['last_message'] == null
          ? null
          : MessageModel.fromJson(map['last_message']),
    );
  }

  @override
  String toString() => 'ChatModel(ids: $ids, last_message: $lastMessage)';

  @override
  bool operator ==(Object other) {
    return other is ChatModel && other.id == id;
  }

  @override
  int get hashCode => ids.hashCode ^ lastMessage.hashCode;
}
