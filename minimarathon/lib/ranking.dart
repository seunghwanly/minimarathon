import 'package:flutter/material.dart';
import 'package:minimarathon/relay_start.dart';
import 'textStyle.dart';

class Ranking extends StatefulWidget {
  @override
  RankingState createState() => RankingState();
}

class RankingState extends State<Ranking> {
  final String username = 'Jong Ha Park';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Scaffold(
          appBar: new AppBar(
            title: Text("Ranking"),
          ),
          body: new Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      makeText("2020 Hope Sharing Relay", Colors.black54, 20),
                      makeText("Let's Run & Share", Colors.black87, 20),
                    ],
                  ),
                ),
                Expanded(flex: 1, child: Container(child: Text(''))),
              ],
            ),
          )),
    );
  }
}
