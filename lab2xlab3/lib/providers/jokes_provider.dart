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
  String? currentType;

  Map<String, List<Joke>> _jokesByType = {};
  Joke? _jokeOfTheDay;
  bool _isLoading = false;

  List<Joke> get favoriteJokes => _jokesByType.values
      .expand((jokes) => jokes)
      .where((joke) => joke.isFavorite)
      .toList();
  List<Joke> get jokesByType => _jokesByType[currentType] ?? [];
  Joke? get jokeOfTheDay => _jokeOfTheDay;
  bool get isLoading => _isLoading;

  Future<void> fetchJokesByType(JokeType jokeType) async {
    if (currentType == jokeType.type ||
        _jokesByType.containsKey(jokeType.type)) {
      currentType = jokeType.type;
      notifyListeners();
      return;
    }

    currentType = jokeType.type;
    _isLoading = true;
    notifyListeners();

    try {
      final data = await ApiService.getJokesForType(jokeType);
      _jokesByType[currentType!] = (data)
          .map((joke) => Joke.fromJson(joke as Map<String, dynamic>))
          .toList();
    } catch (e) {
      _jokesByType[currentType!] = [];
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

  void toggleFavorite(Joke joke) {
    final jokes = _jokesByType.values.expand((jokes) => jokes).toList();

    final index = jokes.indexOf(joke);
    if (index != -1) {
      jokes[index].isFavorite = !jokes[index].isFavorite;
      notifyListeners();
    }
  }
}
