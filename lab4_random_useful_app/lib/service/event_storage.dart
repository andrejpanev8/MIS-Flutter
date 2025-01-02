import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../data/event_model.dart';

class EventStorage {
  static const String _storageKey = 'events';

  static Future<void> saveEvents(List<Event> events) async {
    final prefs = await SharedPreferences.getInstance();
    final eventList = events.map((e) => e.toJson()).toList();
    await prefs.setString(_storageKey, json.encode(eventList));
  }

  static Future<List<Event>> loadEvents() async {
    final prefs = await SharedPreferences.getInstance();
    final eventListString = prefs.getString(_storageKey);
    if (eventListString == null) return [];
    final eventList = json.decode(eventListString) as List<dynamic>;
    return eventList.map((e) => Event.fromJson(e)).toList();
  }
}
