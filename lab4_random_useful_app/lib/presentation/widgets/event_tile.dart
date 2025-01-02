import 'package:flutter/material.dart';
import 'package:lab4_random_useful_app/presentation/widgets/display_location_button.dart';
import 'package:lab4_random_useful_app/utils/color_constants.dart';

import '../../data/event_model.dart';

class EventTile extends StatelessWidget {
  final Event event;
  final Function(Event) onDelete;

  EventTile({Key? key, required this.event, required this.onDelete})
      : super(key: key);

  void _showEventDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(event.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Description: ${event.description}"),
            SizedBox(height: 8),
            Text("Date: ${event.date.toLocal().toString().split(' ')[0]}"),
            Text("Time: ${event.time.format(ctx)}"),
            SizedBox(height: 8),
            Text("Location: ${event.location}"),
          ],
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          displayLocationButton(),
          TextButton(
            onPressed: () {
              onDelete(event);
            },
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        contentPadding: const EdgeInsets.only(right: 0, left: 8),
        onTap: () => _showEventDetails(context),
        title: Text(
          event.title,
          softWrap: true,
        ),
        subtitle: Text(
          "Time: ${event.time.format(context)}",
          softWrap: true,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            displayLocationButton(),
            IconButton(
              padding: const EdgeInsets.all(0),
              onPressed: () {
                onDelete(event);
              },
              icon: const Icon(Icons.delete, color: redColor),
            ),
          ],
        ),
      ),
    );
  }
}
