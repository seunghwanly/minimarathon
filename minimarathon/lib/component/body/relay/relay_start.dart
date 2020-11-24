import 'package:flutter/material.dart';
import 'package:minimarathon/component/body/relay/background_location.dart';
import 'package:minimarathon/component/header/header.dart';
import 'package:minimarathon/util/palette.dart';
import '../../../util/text_style.dart';
import '../relay/ranking.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'relay_finish.dart';
import 'package:background_location/background_location.dart';

class RelayStart extends StatefulWidget {
  final bool isTeam;
  final bool isLeader;
  final bool ismember;

  final String username;

  RelayStart({this.isLeader, this.isTeam, this.ismember, this.username});
  @override
  RelayStartState createState() => RelayStartState();
}

class RelayStartState extends State<RelayStart> {
  String username = 'Jong Ha Park';
  void _navigation() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => Ranking(),
      ),
    );
  }

  void _navigationToLocation() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => MyBackgroundLocation(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      username = widget.username;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomHeader(
        title: "2020 Hope Sharing Relay",
        body: new Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    makeText('Jong Ha Park', lightwhite, 23),
                  ],
                ),
              ),
              Expanded(flex: 3, child: Container(child: Text(''))),
              Expanded(
                  flex: 4,
                  child: Container(
                    // height:  MediaQuery.of(context).size.height * 0.8,
                    //margin: EdgeInsets.symmetric(vertical: 10),
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                        color: mandarin,
                        border: Border.all(color: lightwhite, width: 3),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: FlatButton(
                      onPressed: _navigationToLocation,
                      child: Container(
                        child: makeText('Relay START', lightwhite, 28),
                      ),
                    ),
                  )),
              Expanded(flex: 1, child: Container(child: Text(''))),
              Expanded(
                  flex: 4,
                  child: Container(
                    // height:  MediaQuery.of(context).size.height * 0.8,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                        border: Border.all(color: lightwhite, width: 3),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: FlatButton(
                      onPressed: _navigation,
                      child: Container(
                        child: makeText('Ranking', lightwhite, 28),
                      ),
                    ),
                  )),
              Expanded(flex: 8, child: Container(child: Text(''))),
            ],
          ),
        ));
  }
}
