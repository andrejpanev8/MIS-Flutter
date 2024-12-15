import 'package:flutter/material.dart';

import '../../utils/color_constants.dart';
import '../../utils/text_styles.dart';

PreferredSizeWidget customAppBar(
    {required BuildContext context,
    final String? appBarText,
    final String? leadingButtonText,
    Function()? onTap}) {
  return AppBar(
    title: Text(
      appBarText ?? "211066",
      style: StyledText().appBarText(),
    ),
    actions: [
      TextButton.icon(
        onPressed: onTap,
        label: Text(leadingButtonText ?? "", style: StyledText().appBarText()),
        icon: Icon(
          Icons.assistant_direction_outlined,
          color: whiteColor,
        ),
      )
    ],
    backgroundColor: blueDark,
  );
}
