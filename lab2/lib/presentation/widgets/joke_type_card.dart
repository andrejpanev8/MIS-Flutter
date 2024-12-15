import 'package:flutter/material.dart';

import '../../data/models/joke_types_model.dart';

Widget jokeTypeCard(BuildContext context, JokeType jokeType) {
  return Card(
    child: ListTile(
      title: Text(jokeType.type),
      onTap: () {
        Navigator.pushNamed(context, "/jokes", arguments: jokeType);
      },
    ),
  );
}
