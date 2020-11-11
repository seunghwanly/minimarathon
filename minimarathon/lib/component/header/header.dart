import 'package:flutter/material.dart';
import 'package:minimarathon/util/palette.dart';

class CustomHeader extends StatelessWidget {
  final title, body;

  CustomHeader({this.title, this.body});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: title,
          elevation: 0.0,
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
            color: white,
            alignment: Alignment.center,
            child: body,
          ),
        ));
  }
}
