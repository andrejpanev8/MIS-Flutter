import 'package:flutter/material.dart';
import 'package:lab2/data/services/api_service.dart';

import '../data/models/joke_model.dart';
import '../data/models/joke_types_model.dart';

class JokeTypesProvider with ChangeNotifier {
  List<JokeType> _jokeTypes = [];
  bool _isLoading = false;

  List<JokeType> get jokeTypes => _jokeTypes;
  bool get isLoading => _isLoading;

  Future<void> fetchJokeTypes() async {
    _isLoading = true;
    notifyListeners();

    try {
      final data = await ApiService.getJokeTypesFromAPI();
      _jokeTypes = (data).map((type) => JokeType(type: type)).toList();
    } catch (e) {
      print("Error: $e");
    }

    _isLoading = false;
    notifyListeners();
  }
}

class JokesProvider with ChangeNotifier {
  List<Joke> _jokes = [];
  Joke? _jokeOfTheDay;
  bool _isLoading = false;

  List<Joke> get jokes => _jokes;
  Joke? get jokeOfTheDay => _jokeOfTheDay;
  bool get isLoading => _isLoading;

  Future<void> fetchJokesByType(JokeType jokeType) async {
    _isLoading = true;
    notifyListeners();

    try {
      final data = await ApiService.getJokesForType(jokeType);
      _jokes = (data)
          .map((joke) => Joke.fromJson(joke as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print("Error: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchJokeOfTheDay() async {
    final data = await ApiService.getJokeOfTheDay();
    _jokeOfTheDay = Joke.fromJson(data);
    notifyListeners();
  }
}
