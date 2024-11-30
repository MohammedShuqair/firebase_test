import 'package:firebase_test/extentions/show_snak_bar_extenstion.dart';
import 'package:firebase_test/features/notification/models/notification.dart';
import 'package:firebase_test/features/notification/repository/notification_repository.dart';
import 'package:flutter/material.dart';

import '../../../data/models/data_model.dart';

class NotificationProvider extends ChangeNotifier {
  DataModel<List<NotificationModel>>? notifications;
  final NotificationRepository notificationRepository;
  final ScrollController scrollController = ScrollController();

  NotificationProvider(
    this.notificationRepository,
  );

  int get notificationCount => notificationData.length;

  List<NotificationModel> get notificationData => notifications?.data ?? [];

  void getFirebaseNotifications(String currentUserId, BuildContext context) {
    try {
      notifications = DataModel.loading();
      notifyListeners();
      notificationRepository
          .getFirebaseNotification(currentUserId)
          .listen((notificationList) {
        notifications = DataModel.success(data: notificationList);
        notifyListeners();
      });
    } catch (e) {
      notifications = DataModel.error(message: e.toString());
      notifyListeners();
      context.showSnackBar(e.toString());
    }
  }
}
