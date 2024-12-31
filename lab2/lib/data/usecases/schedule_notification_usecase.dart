import 'package:flutter/material.dart';
import '../../data/services/notification_service.dart';

class ScheduleNotificationUseCase {
  final NotificationService notificationService;

  ScheduleNotificationUseCase(this.notificationService);

  Future<void> execute(TimeOfDay time) async {
    await notificationService.scheduleDailyNotification(time);
  }
}
