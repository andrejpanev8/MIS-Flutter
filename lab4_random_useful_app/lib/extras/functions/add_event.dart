import 'package:flutter/material.dart';

import '../../data/event_model.dart';
import '../../presentation/widgets/text_field.dart';

Future<void> showAddEventDialog(
  BuildContext context,
  Function(Event) onEventAdded,
) async {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final locationController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  await showDialog(
    context: context,
    builder: (ctx) => StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          title: const Text("Add Event"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                textField(titleController, "Title"),
                textField(descriptionController, "Description"),
                textField(locationController, "Location"),
                _buildDatePicker(context, selectedDate, (newDate) {
                  setState(() {
                    selectedDate = newDate;
                  });
                }),
                _buildTimePicker(context, selectedTime, (newTime) {
                  setState(() {
                    selectedTime = newTime;
                  });
                }),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                final newEvent = Event(
                  title: titleController.text,
                  description: descriptionController.text,
                  date: selectedDate,
                  time: selectedTime,
                  location: locationController.text,
                );
                onEventAdded(newEvent);
                Navigator.of(ctx).pop();
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    ),
  );
}

Widget _buildDatePicker(
  BuildContext context,
  DateTime selectedDate,
  Function(DateTime) onDatePicked,
) {
  return Row(
    children: [
      Expanded(
        child: Text("Date: ${selectedDate.toLocal().toString().split(' ')[0]}"),
      ),
      ElevatedButton(
        onPressed: () async {
          final pickedDate = await showDatePicker(
            context: context,
            initialDate: selectedDate,
            firstDate: DateTime(2000),
            lastDate: DateTime(2101),
          );
          if (pickedDate != null) {
            onDatePicked(pickedDate);
          }
        },
        child: const Text("Pick Date"),
      ),
    ],
  );
}

Widget _buildTimePicker(
  BuildContext context,
  TimeOfDay selectedTime,
  Function(TimeOfDay) onTimePicked,
) {
  return Row(
    children: [
      Expanded(
        child: Text("Time: ${selectedTime.format(context)}"),
      ),
      ElevatedButton(
        onPressed: () async {
          final pickedTime = await showTimePicker(
            context: context,
            initialTime: selectedTime,
          );
          if (pickedTime != null) {
            onTimePicked(pickedTime);
          }
        },
        child: const Text("Pick Time"),
      ),
    ],
  );
}
