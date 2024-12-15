import 'package:flutter/material.dart';
import 'color_constants.dart';

class StyledText {
  FontWeight boldLv3 = FontWeight.w700;
  FontWeight boldLv2 = FontWeight.w600;
  FontWeight bold = FontWeight.w500;
  FontWeight regular = FontWeight.w400;
  FontWeight thin = FontWeight.w300;
  FontWeight thinLv2 = FontWeight.w200;
  FontWeight thinLv3 = FontWeight.w100;

  TextStyle appBarText({
    Color? color,
    FontWeight? fontWeight,
    double fontSize = 24,
    FontStyle fontStyle = FontStyle.normal,
  }) =>
      TextStyle(
        color: color ?? whiteColor,
        fontWeight: fontWeight ?? bold,
        fontSize: fontSize,
        fontStyle: fontStyle,
      );
}
