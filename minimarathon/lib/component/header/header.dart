import 'package:flutter/material.dart';
import 'package:minimarathon/util/palette.dart';

class CustomHeader extends StatelessWidget {
  final title, body;

  CustomHeader({this.title, this.body});

  @override
  Widget build(BuildContext context) {
      return new Scaffold(
          appBar: new AppBar(
            title: title == "" ? Text("") : title,
            // 1번
            // elevation: title == "" ? 0.0 : 2.0,
            // shadowColor: title == "" ? Colors.transparent : white,
            // backgroundColor: pastelblue,
            // 2번
            // elevation: 0.0,
            // backgroundColor: title == "" ? pastelblue : deepPastelblue,
            // 3번
            elevation: 0.0,
            bottom: PreferredSize(
              child: Container(
                color: title != "" ? lightwhite : Colors.transparent,
                height: 1.0,
                width: MediaQuery.of(context).size.width * 0.9,
              ),
              preferredSize: Size.fromHeight(1.0),
            ),
            backgroundColor: pastelblue,

            // 전반적인 테마색 : header title
            textTheme: TextTheme(
                headline6: TextStyle(
                    color: white, fontWeight: FontWeight.bold, fontSize: 20.0)),
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
