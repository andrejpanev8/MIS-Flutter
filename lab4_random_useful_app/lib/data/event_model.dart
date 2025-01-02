import 'package:flutter/material.dart';

class Event {
  final String title;
  final String description;
  final DateTime date;
  final TimeOfDay time;
  final String location;

  Event({
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.location,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
      'time': '${time.hour}:${time.minute}',
      'location': location,
    };
  }

  factory Event.fromJson(Map<String, dynamic> json) {
    final timeParts = json['time'].split(':');
    return Event(
      title: json['title'],
      description: json['description'],
      date: DateTime.parse(json['date']),
      time: TimeOfDay(
        hour: int.parse(timeParts[0]),
        minute: int.parse(timeParts[1]),
      ),
      location: json['location'],
    );
  }
}
