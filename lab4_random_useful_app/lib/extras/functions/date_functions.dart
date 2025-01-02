import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/event_provider.dart';

void selectDate(BuildContext context) async {
  final EventProvider eventProvider = context.read<EventProvider>();
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: eventProvider.selectedDate,
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
  );
  if (picked != null) {
    eventProvider.setDate(picked);
  }
}
