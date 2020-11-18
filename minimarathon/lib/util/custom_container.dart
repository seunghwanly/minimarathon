import 'package:flutter/material.dart';

BoxShadow customeBoxShadow() {
  return BoxShadow(
      color: Colors.black.withOpacity(0.16),
      offset: Offset(0, 3),
      blurRadius: 6);
}

BoxDecoration customBoxDecoration(Color color) {
  return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(30),
      boxShadow: [customeBoxShadow()]);
}