import 'package:firebase_messaging/firebase_messaging.dart';

@pragma('vm:entry-point')
Future<void> handelBackground(RemoteMessage? remoteMessage) async {
  print("remoteMessage ${remoteMessage?.notification?.toMap()}");
}

class FcmService {
  /// define var from class type [FcmService]
  static FcmService instance = FcmService._();

  FcmService._();

  Future<void> init() async {
    NotificationSettings notificationSettings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (notificationSettings.authorizationStatus ==
        AuthorizationStatus.authorized) {
      await FirebaseMessaging.instance.setAutoInitEnabled(true);

      print("Permission granted");
      print("token ${await getToken()}");

      /// app is in foreground (user is using the app right now)
      FirebaseMessaging.onMessage.listen((remoteMessage) {
        print("remoteMessage ${remoteMessage.notification?.toMap()}");
      });

      /// app is in background
      FirebaseMessaging.onBackgroundMessage(handelBackground);

      /// app is terminated
      FirebaseMessaging.instance.getInitialMessage().then((handelBackground));
    }
  }

  subscribeToTopic(String topic) {
    FirebaseMessaging.instance.subscribeToTopic(topic);
  }

  Future<String?> getToken() async {
    return await FirebaseMessaging.instance.getToken();
  }
}
