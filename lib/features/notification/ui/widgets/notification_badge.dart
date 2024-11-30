import 'package:firebase_test/extentions/novigator_extenstion.dart';
import 'package:firebase_test/features/notification/logic/notification_provider.dart';
import 'package:firebase_test/features/notification/ui/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationBadge extends StatelessWidget {
  const NotificationBadge({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationProvider>(
      builder: (context, provider, child) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            context.push(const NotificationScreen());
          },
          child: Badge(
            label: Text(provider.notificationCount.toString()),
            isLabelVisible: provider.notificationCount > 0,
            child: const Icon(Icons.notifications),
          ),
        );
      },
    );
  }
}
