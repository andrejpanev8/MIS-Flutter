import 'package:flutter/material.dart';

import '../../utils/color_constants.dart';
import '../../utils/text_styles.dart';
import '../../extras/functions/date_functions.dart';

PreferredSizeWidget customAppBar({
  required BuildContext context,
  final String? appBarText,
  bool showCalendar = true,
}) {
  return AppBar(
    title: Text(
      appBarText ?? "211066",
      style: StyledText().appBarText(),
    ),
    actions: showCalendar ? _showCalendar(context) : null,
    backgroundColor: blueDark,
  );
}

List<Widget> _showCalendar(BuildContext context) {
  return [
    TextButton.icon(
      onPressed: () => selectDate(context),
      label: Text(
        "Pick a Date: ",
        style: StyledText().appBarText(),
      ),
      icon: const Icon(Icons.calendar_today, color: whiteColor),
      iconAlignment: IconAlignment.end,
    ),
  ];
}
