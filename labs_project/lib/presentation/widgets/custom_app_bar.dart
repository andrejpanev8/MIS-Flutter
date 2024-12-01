import 'package:flutter/material.dart';
import 'package:labs_project/utils/color_constants.dart';
import 'package:labs_project/utils/text_styles.dart';

PreferredSizeWidget customAppBar(
    {required BuildContext context, final String? appBarText}) {
  return AppBar(
    title: Center(
      child: Text(
        appBarText ?? "211066",
        style: StyledText().appBarText(),
        textAlign: TextAlign.center,
      ),
    ),
    backgroundColor: blueDark,
  );
}
