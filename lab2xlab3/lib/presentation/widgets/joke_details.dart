import 'package:flutter/material.dart';

import '../../data/models/joke_model.dart';

Future<dynamic>? showJokeDetails(BuildContext context, Joke joke) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("Joke ID: ${joke.id}"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            joke.setup,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const Divider(thickness: 1),
          Text(
            joke.punchLine,
            style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Close"),
        ),
      ],
    ),
  );
}
