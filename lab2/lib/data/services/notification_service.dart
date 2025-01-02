import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:lab2/utils/links.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:http/http.dart' as http;
import '../models/notification_model.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initialize() async {
    await _firebaseMessaging.requestPermission();
    await _firebaseMessaging.setAutoInitEnabled(true);
    tz.initializeTimeZones();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
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

    final fcmToken = await _firebaseMessaging.getToken();
    print("Scheduled notification with token: $fcmToken");

    // Format the time in HH:MM format (24-hour format)
    final timeString =
        '${notificationTime.hour.toString().padLeft(2, '0')}:${notificationTime.minute.toString().padLeft(2, '0')}';

    final notification = NotificationModel(
      token: fcmToken ?? '',
      title: 'Joke of the day',
      body: 'Check out the joke of the day!',
      time: timeString,
    );

    final response = await http.post(
      schedulefUrl,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(notification.toJson()),
    );

    if (response.statusCode == 200) {
      print('Notification scheduled successfully');
    } else {
      print('Failed to schedule notification: ${response.body}');
    }
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling background message: ${message.notification?.title}');
}
