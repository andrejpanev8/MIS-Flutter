import 'package:flutter/material.dart';
import 'package:lab4_random_useful_app/presentation/widgets/event_tile.dart';
import 'package:lab4_random_useful_app/utils/color_constants.dart';
import 'package:lab4_random_useful_app/utils/text_styles.dart';
import 'package:provider/provider.dart';

import '../../extras/functions/add_event.dart';
import '../../providers/event_provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final eventProvider = context.watch<EventProvider>();
    final events = eventProvider.events;
    final selectedDate = eventProvider.selectedDate;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          _pickedDate(selectedDate),
          _eventsList(events, eventProvider),
        ],
      ),
      floatingActionButton: _addEventButton(context),
    );
  }
}

Widget _pickedDate(var selectedDate) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: orangeLight),
      child: Text(
        selectedDate != null
            ? "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"
            : "No date selected",
        style: StyledText().appBarText(),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

Widget _eventsList(List events, EventProvider eventProvider) {
  return Expanded(
    child: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          return EventTile(
            event: events[index],
            onDelete: (event) => eventProvider.removeEvent(event),
          );
        }),
  );
}

Widget _addEventButton(BuildContext context) {
  return TextButton.icon(
    onPressed: () {
      showAddEventDialog(context, (newEvent) {
        context.read<EventProvider>().addEvent(newEvent);
      });
    },
    label: Text("New event", style: StyledText().descriptionText()),
    icon: Icon(Icons.add, color: whiteColor),
    style: TextButton.styleFrom(
      padding: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      backgroundColor: orangeLight,
    ),
  );
}
