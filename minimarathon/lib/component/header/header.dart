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
          elevation: this.title == "" ? 0.0 : 2.0,
          shadowColor: white,
          backgroundColor: pastelblue,
          textTheme: TextTheme(headline6: TextStyle(color: white, fontWeight: FontWeight.bold, fontSize: 20.0)),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
            color: pastelblue,            
            alignment: Alignment.center,
            child: body,
          ),
        ));
  }
}
