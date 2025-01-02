import 'joke_types_model.dart';

class Joke {
  int id;
  final JokeType type;
  final String setup;
  final String punchLine;
  bool isFavorite = false;

  Joke({
    required this.id,
    required this.type,
    this.setup = "",
    this.punchLine = "",
  });

  Joke.fromJson(Map<String, dynamic> data)
      : id = data['id'],
        type = JokeType(type: data['type']),
        setup = data['setup'],
        punchLine = data['punchline'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type.type,
        'setup': setup,
        'punchline': punchLine,
      };
}
