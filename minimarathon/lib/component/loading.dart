import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:minimarathon/util/palette.dart';

//앱 시작시 로딩화면

class LoadingPage extends StatefulWidget {
  // final res;
  // final Function onFinish;

  // LoadingPage({this.res, this.onFinish});

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    // widget.onFinish(widget.res);

    return Center(
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: pastelblue,
            child: LoadingBouncingGrid.circle(
              borderColor: orange,
              size: 50.0,
              backgroundColor: Colors.transparent,
              duration: Duration(milliseconds: 5000),
            )));
  }
}
