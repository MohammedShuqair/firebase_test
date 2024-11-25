import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/chat/logic/chat_provider.dart';
import 'package:firebase_test/chat/repository/chat_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) =>
          ChatProvider(ChatRepository(), FirebaseAuth.instance.currentUser!),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Chat"),
        ),
        body: Consumer<ChatProvider>(
          builder: (context, provider, child) {
            return ListView.separated(
                reverse: true,
                shrinkWrap: true,
                itemBuilder: (_, index) => Row(
                      children: [Text(provider.messages[index].text!)],
                    ),
                separatorBuilder: (_, index) => const SizedBox(
                      height: 10,
                    ),
                itemCount: provider.messages.length);
          },
        ),
        bottomNavigationBar: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
          child: Consumer<ChatProvider>(
            builder: (context, provider, child) {
              return TextField(
                controller: provider.messageController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    suffixIcon: IconButton(
                        onPressed: () {
                          provider.addMessage();
                        },
                        icon: const Icon(Icons.send))),
              );
            },
          ),
        ),
      ),
    );
  }
}
