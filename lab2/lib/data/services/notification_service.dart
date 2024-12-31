import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initialize() async {
    await _firebaseMessaging.requestPermission();
    await _firebaseMessaging.setAutoInitEnabled(true);
    tz.initializeTimeZones();

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    final fcmToken = await _firebaseMessaging.getToken();
    print("FCMToken: $fcmToken");
  }

  Future<void> scheduleDailyNotification(TimeOfDay time) async {
    final now = DateTime.now();
    final scheduledTime = DateTime(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );

    final notificationTime = scheduledTime.isBefore(now)
        ? scheduledTime.add(Duration(days: 1))
        : scheduledTime;

    //TODO: Implement send notif
  }
}

// Background handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling background message: ${message.notification?.title}');
}
