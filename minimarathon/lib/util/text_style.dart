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

Widget makeTwoColor(
    @required String left,
    @required String right,
    @required Color leftcolor,
    @required Color rightcolor,
    @required double size) {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          left,
          style: TextStyle(
              color: leftcolor, fontWeight: FontWeight.w400, fontSize: size),
          textAlign: TextAlign.center,
        ),
        Text(
          right,
          style: TextStyle(
              color: rightcolor, fontWeight: FontWeight.bold, fontSize: size),
          textAlign: TextAlign.center,
        )
      ],
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
