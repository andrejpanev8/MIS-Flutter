import 'package:flutter/material.dart';
import 'package:lab2/presentation/widgets/joke_details.dart';
import 'package:provider/provider.dart';

import '../../data/models/joke_model.dart';
import '../../providers/jokes_provider.dart';

class JokeCard extends StatefulWidget {
  final Joke joke;

  const JokeCard({Key? key, required this.joke}) : super(key: key);

  @override
  _JokeCardState createState() => _JokeCardState();
}

class _JokeCardState extends State<JokeCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
          contentPadding: const EdgeInsets.all(10),
          trailing: IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () =>
                context.read<JokesProvider>().toggleFavorite(widget.joke),
            color: widget.joke.isFavorite ? Colors.red : Colors.blueGrey,
          ),
          title: Text(
            widget.joke.setup,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          subtitle: Text("ID: ${widget.joke.id}"),
          onTap: () => showJokeDetails(context, widget.joke)),
    );
  }
}
