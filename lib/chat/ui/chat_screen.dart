import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
      ),
      body: ListView.separated(
          reverse: true,
          shrinkWrap: true,
          itemBuilder: (_, index) => const Row(
                children: [Text("message text")],
              ),
          separatorBuilder: (_, index) => const SizedBox(
                height: 10,
              ),
          itemCount: 10),
      bottomNavigationBar: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
        child: TextField(
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade200,
              suffixIcon: IconButton(
                  onPressed: () {
                    ///Todo: send message
                  },
                  icon: const Icon(Icons.send))),
        ),
      ),
    );
  }
}
