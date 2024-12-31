import 'package:flutter/material.dart';
import 'package:lab2/presentation/widgets/custom_app_bar.dart';
import 'package:lab2/presentation/widgets/joke_details.dart';
import 'package:lab2/presentation/widgets/joke_type_card.dart';
import 'package:lab2/providers/jokes_provider.dart';
import 'package:provider/provider.dart';

import '../../data/models/joke_model.dart';
import '../../data/services/notification_service.dart';

class HomeJokeTypes extends StatelessWidget {
  const HomeJokeTypes({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<JokeTypesProvider>().fetchJokeTypes();
    });

    return SafeArea(
      child: Scaffold(
        appBar: customAppBar(
          context: context,
          leadingButtonText: "Joke of the day",
          onTap: () {
            displayJokeDetails(context);
          },
        ),
        body: Consumer<JokeTypesProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (provider.jokeTypes.isEmpty) {
              return const Center(child: Text("No joke types found!"));
            }

            return ListView.builder(
              itemCount: provider.jokeTypes.length,
              itemBuilder: (context, index) {
                final jokeType = provider.jokeTypes[index];
                return jokeTypeCard(context, jokeType);
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _scheduleNotification(context),
          tooltip: 'Schedule Daily Joke Notification',
          child: const Icon(Icons.alarm),
        ),
      ),
    );
  }
}

Future displayJokeDetails(BuildContext context) async {
  try {
    await context.read<JokesProvider>().fetchJokeOfTheDay();
    showJokeDetails(
        context, context.read<JokesProvider>().jokeOfTheDay as Joke);
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error fetching joke of the day!")),
    );
  }
}

Future<void> _scheduleNotification(BuildContext context) async {
  final TimeOfDay? pickedTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );

  if (pickedTime != null) {
    final notificationService =
        Provider.of<NotificationService>(context, listen: false);
    await notificationService.scheduleDailyNotification(pickedTime);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Notification scheduled at ${pickedTime.format(context)}",
        ),
      ),
    );
  }
}
