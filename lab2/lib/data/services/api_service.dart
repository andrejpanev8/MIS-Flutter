import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lab2/data/models/joke_types_model.dart';

import '../models/joke_model.dart';

class ApiService {
  static Future<List<dynamic>> getJokeTypesFromAPI() async {
    final response = await http
        .get(Uri.parse("https://official-joke-api.appspot.com/types"));
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as List<dynamic>;
    } else {
      throw Exception("Failed to load joke types!");
    }
  }

  static Future<List<dynamic>> getJokesForType(JokeType type) async {
    final response = await http.get(Uri.parse(
        "https://official-joke-api.appspot.com/jokes/${type.type}/ten"));
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as List<dynamic>;
    } else {
      throw Exception("Failed to load jokes of type ${type.type}!");
    }
  }

  static Future<dynamic> getJokeOfTheDay() async {
    final response = await http
        .get(Uri.parse("https://official-joke-api.appspot.com/random_joke"));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load joke of the day!");
    }
  }
}
