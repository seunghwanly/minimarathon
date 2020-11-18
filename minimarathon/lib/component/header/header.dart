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
          elevation: 1.0,
          shape: RoundedRectangleBorder(side: BorderSide(color: pastelblue)),
          backgroundColor: white,
          shadowColor: pastelblue,
          // textTheme: TextTheme(headline6: TextStyle(color: white, fontSize: MediaQuery.of(context).size.width / 18, fontWeight: FontWeight.w600)),
          
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
