import 'package:flutter/material.dart';

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
          child: new Center(
            child: body,
          ),
        ));
  }
}
