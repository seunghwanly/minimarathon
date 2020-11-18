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
          elevation: 2.0,
          shadowColor: white,
          backgroundColor: pastelblue,
          // textTheme: TextTheme(headline6: TextStyle(color: white, fontSize: MediaQuery.of(context).size.width / 18, fontWeight: FontWeight.w600)),
        ),
        // appBar: new GradientAppBar(
        //   title: title,
        //   elevation: 0.0,
        //   backgroundColorStart: Colors.pink[200],
        //   backgroundColorEnd: white,
        // ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
            color: pastelblue,
            // decoration: BoxDecoration(
            //     gradient: LinearGradient(
            //         begin: Alignment.topRight,
            //         end: Alignment.bottomLeft,
            //         colors: [Colors.pink[200], Colors.green[200]])),
            alignment: Alignment.center,
            child: body,
          ),
        ));
  }
}
