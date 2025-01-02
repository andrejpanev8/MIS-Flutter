import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/services/notification_service.dart';
import '../../providers/jokes_provider.dart';
import '../widgets/joke_type_card.dart';

class HomeJokeTypes extends StatelessWidget {
  const HomeJokeTypes({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<JokeTypesProvider>().fetchJokeTypes();
    });

    return SafeArea(
      child: Scaffold(
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

  Future<void> _scheduleNotification(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      final notificationService =
          Provider.of<NotificationService>(context, listen: false);

      try {
        await notificationService.scheduleDailyNotification(pickedTime);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Notification scheduled at ${pickedTime.format(context)}",
            ),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to schedule notification: $e")),
        );
      }
    }
  }
}
