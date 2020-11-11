import 'package:flutter/material.dart';

Widget makeText(String title, Color color, double size) {
  return Container(
    child: Text(
      title,
      style:
          TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: size),
      textAlign: TextAlign.center,
    ),
  );
}

Widget makeTextThin(String title, Color color, double size) {
  return Container(
    child: Text(
      title,
      style:
          TextStyle(color: color, fontWeight: FontWeight.w300, fontSize: size),
      textAlign: TextAlign.center,
    ),
  );
}

Widget makeTextSemiThin(String title, Color color, double size) {
  return Container(
    child: Text(
      title,
      style:
          TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: size),
      textAlign: TextAlign.center,
    ),
  );
}

Widget makeTextUnderLine(String title, Color color, double size) {
  return Container(
    child: Text(
      title,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.w600,
        fontSize: size,
        decoration: TextDecoration.underline,
      ),
      textAlign: TextAlign.center,
    ),
  );
}
