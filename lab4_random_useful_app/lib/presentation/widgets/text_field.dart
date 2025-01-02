import 'package:flutter/material.dart';

Widget textField(TextEditingController? controller, String labelText) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      labelText: labelText,
    ),
    maxLines: 1,
  );
}
