import 'package:flutter/material.dart';

InputDecoration inputDecoration({
  required String title,
  required IconData icon,
}) {
  return InputDecoration(
    labelText: title,
    prefixIcon: Icon(icon, color: Colors.grey.shade800),
    labelStyle: TextStyle(color: Colors.grey.shade800),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: Colors.blue, width: 2),
    ),
  );
}