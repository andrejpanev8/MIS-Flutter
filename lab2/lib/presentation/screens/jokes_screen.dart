import 'package:flutter/material.dart';
import 'package:lab2/data/models/joke_types_model.dart';
import 'package:provider/provider.dart';

import '../../providers/jokes_provider.dart';
import '../widgets/joke_card.dart';
import '../widgets/custom_app_bar.dart';

class JokesScreen extends StatefulWidget {
  const JokesScreen({super.key});

  @override
  State<JokesScreen> createState() => _JokesScreenState();
}

class _JokesScreenState extends State<JokesScreen> {
  late JokeType jokeType;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    jokeType = ModalRoute.of(context)!.settings.arguments as JokeType;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.read<JokesProvider>().jokes.isEmpty) {
        context.read<JokesProvider>().fetchJokesByType(jokeType);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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

            if (provider.jokes.isEmpty) {
              return const Center(child: Text("No jokes found for this type!"));
            }

            return ListView.builder(
              itemCount: provider.jokes.length,
              itemBuilder: (context, index) {
                final joke = provider.jokes[index];
                return jokeCard(context, joke);
              },
            );
          },
        ),
      ),
    );
  }
}
