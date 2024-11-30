import 'package:firebase_test/features/notification/logic/notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
      ),
      body: SafeArea(
        child: Consumer<NotificationProvider>(
          builder: (context, provider, child) {
            if (provider.notifications?.isLoading() ?? true) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.separated(
              controller: provider.scrollController,
              padding: EdgeInsets.all(20),
              itemBuilder: (_, index) => ListTile(
                title: Text(provider.notificationData[index].getMessageText()),
                subtitle: Text(provider.notificationData[index].name ?? ""),
              ),
              separatorBuilder: (_, index) => SizedBox(
                height: 10,
              ),
              itemCount: provider.notificationCount,
            );
          },
        ),
      ),
    );
  }
}
