class JokeType {
  final String type;

  JokeType({this.type = ""});

  JokeType.fromJson(Map<String, dynamic> data) : type = data['type'];

  Map<dynamic, String> toJson() => {'type': type};
}
