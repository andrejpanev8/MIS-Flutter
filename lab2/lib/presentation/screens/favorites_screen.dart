import 'package:flutter/material.dart';
import 'package:lab2/presentation/widgets/joke_card.dart';
import 'package:lab2/providers/jokes_provider.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<JokesProvider>().favoriteJokes;

    return favorites.isEmpty
        ? const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.heart_broken),
                SizedBox(
                  height: 10,
                ),
                Text("You've no favorites yet."),
              ],
            ),
          )
        : ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final joke = favorites.elementAt(index);
              return JokeCard(
                joke: joke,
              );
            },
          );
  }
}
