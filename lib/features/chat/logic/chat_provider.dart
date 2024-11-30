import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_test/features/chat/models/message.dart';
import 'package:firebase_test/features/chat/repository/chat_repository.dart';
import 'package:firebase_test/models/user_model.dart';
import 'package:firebase_test/repositories/user_repository.dart';
import 'package:flutter/material.dart';

import '../models/chat_model.dart';
import '../../notification/repository/notification_repository.dart';

class ChatProvider extends ChangeNotifier {
  ChatRepository chatRepository;
  UserRepo userRepo = UserRepo();
  NotificationRepository notificationRepository = NotificationRepository();
  List<MessageModel> messages = [];
  final ChatModel chatModel;

  final TextEditingController messageController = TextEditingController();
  UserModel? user;
  ScrollController scrollController = ScrollController();

  ChatProvider(this.chatRepository, String uid, this.chatModel) {
    getUser(uid).then((v) {
      listenToChat();
    });
  }

  Future<void> getUser(String uid) async {
    user = await userRepo.getUser(uid);
    notifyListeners();
  }

  Future addMessage() async {
    if (messageController.text.isNotEmpty) {
      late String message;
      try {
        message = messageController.text;
        messageController.clear();

        var messageModel = MessageModel(
            text: message,
            time: Timestamp.now(),
            senderId: user!.id,
            receiverId: chatModel.getOtherUid(user!.id));
        await chatRepository.addMessage(
          chatId: chatModel.id,
          message: messageModel,
          senderName: user?.name ?? "",
        );
        scrollController.animateTo(0,
            duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
      } catch (e) {
        messageController.text = message;
      }
    }
  }

  void listenToChat() {
    chatRepository.getChat(chatModel.id).listen((messagesList) {
      messages.clear();
      messages.addAll(messagesList);

      ///set read messages notification collection
      notifyListeners();
    });
  }

  @override
  void dispose() {
    messageController.dispose();
    scrollController.dispose();
    super.dispose();
  }
}
