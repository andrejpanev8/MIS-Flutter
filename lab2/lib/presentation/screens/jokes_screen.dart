import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/joke_types_model.dart';
import '../../providers/jokes_provider.dart';
import '../widgets/joke_card.dart';
import '../widgets/custom_app_bar.dart';

class JokesScreen extends StatelessWidget {
  const JokesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final jokeType = ModalRoute.of(context)!.settings.arguments as JokeType;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final jokesProvider = context.read<JokesProvider>();
      jokesProvider.fetchJokesByType(jokeType);
    });

    return SafeArea(
      child: Scaffold(
        appBar: customAppBar(
          context: context,
          appBarText: "Jokes: ${jokeType.type}",
        ),
        body: Consumer<JokesProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (provider.jokesByType.isEmpty) {
              return const Center(child: Text("No jokes found for this type!"));
            }

            return ListView.builder(
              itemCount: provider.jokesByType.length,
              itemBuilder: (context, index) {
                final joke = provider.jokesByType[index];
                return JokeCard(joke: joke);
              },
            );
          },
        ),
      ),
    );
  }
}
