import 'package:flutter/material.dart';
import 'package:lab2/presentation/widgets/joke_details.dart';

import '../../data/models/joke_model.dart';

Widget jokeCard(BuildContext context, Joke joke) {
  return Card(
    elevation: 3,
    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        title: Text(
          joke.setup,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text("ID: ${joke.id}"),
        onTap: () => showJokeDetails(context, joke)),
  );
}
