import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/chat/models/chat_model.dart';
import 'package:firebase_test/chat/ui/chat_screen.dart';
import 'package:flutter/material.dart';

import '../chat/repository/chats_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ChatModel> chats = [];
  ChatsRepository chatsRepo = ChatsRepository();
  late User user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser!;
    getChats();
  }

  void getChats() {
    try {
      chatsRepo.getChats(user.uid).listen((chatsList) {
        chats = chatsList;
        setState(() {});
      });
    } catch (e, s) {
      print("error $e");
      print("error $s");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: ListView.separated(
        itemBuilder: (_, index) => ListTile(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return ChatScreen(
                chatModel: chats[index],
              );
            }));
          },
          leading: Text(chats[index].id),
          title: Text(chats[index].lastMessage?.text ?? ""),
        ),
        separatorBuilder: (_, index) => const SizedBox(
          height: 10,
        ),
        itemCount: chats.length,
      ),
    );
  }
}
