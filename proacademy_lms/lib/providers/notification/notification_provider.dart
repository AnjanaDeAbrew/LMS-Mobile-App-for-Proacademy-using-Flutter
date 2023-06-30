import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:proacademy_lms/controllers/notification_controller.dart';
import 'package:proacademy_lms/providers/auth/auth_provider.dart';
import 'package:proacademy_lms/providers/chat/chat_provider.dart';
import 'package:provider/provider.dart';

class NotificationProvider extends ChangeNotifier {
  final NotificationController _notificationController =
      NotificationController();

  //-initialize notifications and get the device token
  Future<void> initNotification(BuildContext context) async {
    // Get the token each time the application loads
    await FirebaseMessaging.instance.getToken().then(
      (value) {
        Logger().wtf(value);
        startSaveToken(context, value!);
      },
    );
  }

  //-save notification token in db
  Future<void> startSaveToken(BuildContext context, String token) async {
    try {
      //-first get user uid from user model
      String sid =
          Provider.of<AuthProvider>(context, listen: false).studentModel!.sid;

      //-then starting saving
      await _notificationController
          .saveNotificationoken(sid, token)
          .then((value) {
        //--updating the token foeld with device token
        Provider.of<AuthProvider>(context, listen: false).setDeviceToken(token);
      });
    } catch (e) {
      Logger().e(e);
    }
  }

  //-------handle foreground notifications
  void foreGroundHandler() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      Logger().w('Got a message whilst in the foreground!');
      Logger().w('Message data: ${message.data}');

      if (message.notification != null) {
        Logger().wtf(
            'Message also contained a notification: ${message.notification!.toMap()}');
      }
    });
  }

  void onClickedOpenedApp(BuildContext context) {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      Logger().w('clicked notification open the app');
      Logger().w('Message data: ${message.data}');

      if (message.notification != null) {
        Provider.of<ChatProvider>(context, listen: false)
            .setNotificationData(context, message.data['conId']);
      }
    });
  }
}
