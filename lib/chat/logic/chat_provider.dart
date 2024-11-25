import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/chat/models/message.dart';
import 'package:firebase_test/chat/repository/chat_repository.dart';
import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {
  ChatRepository chatRepository;
  List<MessageModel> messages = [];
  final TextEditingController messageController = TextEditingController();
  User user;

  ChatProvider(this.chatRepository, this.user) {
    getChat();
  }

  Future addMessage() async {
    if (messageController.text.isNotEmpty) {
      late String message;
      try {
        message = messageController.text;
        messageController.clear();
        await chatRepository.addMessage(MessageModel(
            text: message, time: Timestamp.now(), senderId: user.uid));
      } catch (e) {
        messageController.text = message;
      }
    }
  }

  void getChat() {
    chatRepository.getChat().listen((messagesList) {
      messages.clear();
      messages.addAll(messagesList);
      notifyListeners();
    });
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }
}
