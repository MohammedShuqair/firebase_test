import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/features/chat/logic/chat_provider.dart';
import 'package:firebase_test/features/chat/models/chat_model.dart';
import 'package:firebase_test/features/chat/repository/chat_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key, required this.chatModel});

  final ChatModel chatModel;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ChatProvider(
          ChatRepository(), FirebaseAuth.instance.currentUser!.uid, chatModel),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Chat"),
        ),
        body: Consumer<ChatProvider>(
          builder: (context, provider, child) {
            return ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                reverse: true,
                shrinkWrap: true,
                controller: provider.scrollController,
                itemBuilder: (_, index) {
                  var message = provider.messages[index];
                  var isCurrentUserSender =
                      message.isCurrentUserSender(provider.user!.id);
                  Color primary = Theme.of(context).colorScheme.primary;
                  Color secondaryContainer =
                      Theme.of(context).colorScheme.secondaryContainer;

                  Color onSecondaryContainer =
                      Theme.of(context).colorScheme.onSecondaryContainer;
                  Color onPrimary = Theme.of(context).colorScheme.onPrimary;
                  return Directionality(
                    textDirection: isCurrentUserSender
                        ? TextDirection.ltr
                        : TextDirection.rtl,
                    child: Row(
                      children: [
                        Container(
                            color: isCurrentUserSender
                                ? primary
                                : secondaryContainer,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Text(
                              message.text!,
                              style: TextStyle(
                                  color: isCurrentUserSender
                                      ? onPrimary
                                      : onSecondaryContainer),
                            ))
                      ],
                    ),
                  );
                },
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
                    fillColor: Theme.of(context).colorScheme.surface,
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
