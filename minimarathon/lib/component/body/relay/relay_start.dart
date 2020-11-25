import 'package:flutter/material.dart';
import 'package:minimarathon/component/body/relay/background_location.dart';
import 'package:minimarathon/component/header/header.dart';
import 'package:minimarathon/util/custom_dialog.dart';
import 'package:minimarathon/util/palette.dart';
import '../../../util/text_style.dart';
import '../relay/ranking.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'relay_finish.dart';
import 'package:background_location/background_location.dart';
import 'package:intl/intl.dart';

class RelayStart extends StatefulWidget {
  final bool isTeam;
  final bool isLeader;
  final bool ismember;

  final String teamname;
  final String username;

  RelayStart(
      {this.isLeader,
      this.isTeam,
      this.ismember,
      this.username,
      this.teamname});
  @override
  RelayStartState createState() => RelayStartState();
}

class RelayStartState extends State<RelayStart> {
  String username = 'Jong Ha Park';
  String teamname = '';
  void _navigation() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => Ranking(),
      ),
    );
  }

  void _showDialog() {
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     // return object of type Dialog
    //     return AlertDialog(
    //       title: new Text("Sorry, " + username),
    //       content: new Text("Relay is Available on December 10th.",
    //           style: TextStyle(
    //               color: Colors.black87,
    //               fontSize: 16,
    //               fontWeight: FontWeight.w600)),
    //       actions: <Widget>[
    //         new FlatButton(
    //           child: new Text(
    //             "Close",
    //             style: TextStyle(color: royalblue, fontSize: 20),
    //           ),
    //           onPressed: () {
    //             Navigator.pop(context);
    //           },
    //         ),
    //       ],
    //     );
    //   },
    // );
    showMyDialog(context,
        "Sorry, " + username + '\n\n' + "Relay is Available on December 10th.");
  }

  void _navigationToLocation() {
    DateTime currentTime = DateTime.now();

    // TODO : 마라톤 일정에 맞게 D-Day
    // TODO : 2020,12,10,00,00 으로 바꾸기.

    DateTime d_day = DateTime(2020, 12, 7, 23, 34, 00);
    if (d_day.compareTo(currentTime) == 1) {
      //마라톤날짜 이전
      print(widget.teamname);
      _showDialog();
    }

    //마라톤 시작 !
    else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => MyBackgroundLocation(),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      username = widget.username;
      teamname = widget.teamname;
    });
  }

  Widget topUserContainer() {
    if (widget.isLeader) {
      return Column(
        children: [
          makeText('Hello, ${widget.username} !', lightwhite, 22),
          makeText('The Leader of ${widget.teamname} !', lightwhite, 22),
        ],
      );
    } else if (widget.ismember) {
      return Column(
        children: [
          makeText('Hello, ${widget.username} !', lightwhite, 22),
          makeText('You belong to ${widget.teamname} !', lightwhite, 22),
        ],
      );
    } else {
      return Column(
        children: [
          makeText('Hello, ${widget.username} !', lightwhite, 22),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomHeader(
        title: "2020 Hope Sharing Relay",
        body: new Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    topUserContainer(),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                          text: "Thanks for joining\n",
                          style: TextStyle(
                            color: white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            letterSpacing: 2.0,
                          )
                        ),
                        TextSpan(
                          text: "2020 Hope Sharing Relay !",
                          style: TextStyle(
                            color: white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            letterSpacing: 2.0,
                          )
                        ),
                      ]),
                    ),
              ),
              Expanded(
                  flex: 5,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: deepPastelblue
                    ),
                    alignment: Alignment.center,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                          text: "Tips\n\n",
                          style: TextStyle(
                            color: white,
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                            letterSpacing: 2.0,
                          )
                        ),
                        TextSpan(
                            text:
                                "The Distance measurement is based on your device's ",
                            style: TextStyle(
                                color: lightwhite,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                        TextSpan(
                            text: "GPS",
                            style: TextStyle(
                                color: lightwhite,
                                backgroundColor: mandarin,
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                        TextSpan(
                            text:
                                ".\nPlease, take your device outside with you for the marathon!",
                            style: TextStyle(
                                color: lightwhite,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                      ]),
                    ),
                  )),
              Expanded(flex: 1, child: Container(child: Text(''))),
              Expanded(
                  flex: 3,
                  child: Container(
                    // height:  MediaQuery.of(context).size.height * 0.8,
                    //margin: EdgeInsets.symmetric(vertical: 10),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: RaisedButton(
                      onPressed: _navigationToLocation,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))
                      ),
                      color: mandarin,
                      child: Container(
                        child: makeText('Relay START', lightwhite, 28),
                      ),
                    ),
                  )),
              Expanded(flex: 1, child: Container(child: Text(''))),
              Expanded(
                  flex: 3,
                  child: Container(
                    // height:  MediaQuery.of(context).size.height * 0.8,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: RaisedButton(
                      onPressed: _navigation,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))
                      ),
                      color: Colors.green[400],
                      child: Container(
                        child: makeText('Ranking', lightwhite, 28),
                      ),
                    ),
                  )),
              Expanded(flex: 2, child: Container(child: Text(''))),
            ],
          ),
        ));
  }
}
