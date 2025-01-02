import 'package:flutter/material.dart';
import '../data/event_model.dart';

class EventProvider extends ChangeNotifier {
  List<Event> _events = [];
  DateTime _selectedDate = DateTime.now();

  List<Event> get events => _events
      .where((event) =>
          event.date.day == _selectedDate.day &&
          event.date.month == _selectedDate.month &&
          event.date.year == _selectedDate.year)
      .toList();

  DateTime get selectedDate => _selectedDate;

  void addEvent(Event event) {
    _events.add(event);
    notifyListeners();
  }

  void removeEvent(Event event) {
    _events.remove(event);
    notifyListeners();
  }

  void setDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void loadEvents(List<Event> events) {
    _events = events;
    notifyListeners();
  }
}
