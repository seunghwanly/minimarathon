import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minimarathon/component/header/header.dart';
import 'package:minimarathon/util/custom_container.dart';
import 'package:minimarathon/util/custom_dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../util/palette.dart';
import '../../../util/text_style.dart';
import 'ranking.dart';
import 'package:firebase_database/firebase_database.dart';

final databaseReference =
    FirebaseDatabase.instance.reference().child('2020HopeRelay');
final FirebaseAuth auth = FirebaseAuth.instance;

class RelayFinish extends StatefulWidget {
  final int recordTime;
  final double totalDistance;
  final String teamName;
  final String userName;

  RelayFinish(
      {this.recordTime, this.totalDistance, this.teamName, this.userName});
  @override
  RelayFinishState createState() => RelayFinishState();
}

class RelayFinishState extends State<RelayFinish> {
  String username = 'Jong Ha Park';
  User _user = FirebaseAuth.instance.currentUser;
  String userPhoneNumber = '';
  String teamName;
  bool isTeam = true;
  double speed;

  void getUserNumber() async {
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      userPhoneNumber = user.phoneNumber.toString();
    });
  }

  void _updateInfo() async {
    await databaseReference
        .child("Single")
        .once()
        .then((DataSnapshot singleSnapshot) {
      var uidInfo = Map<String, dynamic>.from(singleSnapshot.value);
      uidInfo.forEach((k, v) {
        if (auth.currentUser.uid == k) {
          databaseReference
              .child("Single")
              .child(k)
              .update({'moreVolunteer': true});
        }
      });
    });
    await databaseReference
        .child("Teams")
        .once()
        .then((DataSnapshot dataSnapshot) {
      dataSnapshot.value.forEach((k, v) {
        String teamInfo = k.toString();
        Map<dynamic, dynamic> eachTeamData = v;
        eachTeamData.forEach((k, v) {
          if (k == "leader") {
            if (v['phoneNumber'] == auth.currentUser.phoneNumber) {
              databaseReference
                  .child("Teams")
                  .child(teamInfo)
                  .child(k)
                  .update({'moreVolunteer': true});
            }
          } else if (k == "members") {
            var memberList = List<Map<dynamic, dynamic>>.from(v);
            memberList.forEach((values) {
              var eachMemberData = Map<dynamic, dynamic>.from(values);
              if (auth.currentUser.phoneNumber ==
                  eachMemberData['phoneNumber']) {
                var index = memberList.indexOf(values).toString();
                databaseReference
                    .child("Teams")
                    .child(teamInfo)
                    .child(k)
                    .child(index)
                    .update({'moreVolunteer': true});
              }
            });
          }
        });
      });
    });
  }

  void _openURL() async {
    String url =
        "https://www.gofundme.com/f/can-we-read?utm_medium=copy_link&utm_source=customer&utm_campaign=p_lico+share-sheet";
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  void _navigationMore() {
    Navigator.pop(context);
  }

  void _navigationRanking() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => Ranking(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    userPhoneNumber = _user.phoneNumber;
    username = widget.userName;
    teamName = widget.teamName;
    speed = !(widget.totalDistance / widget.recordTime).isNaN
        ? (widget.totalDistance / widget.recordTime)
        : 0.0;
    if (widget.recordTime == 0 || widget.totalDistance == null) speed = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    print(speed.toString());
    return CustomHeader(
        title: "Relay Finish",
        body: new Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    makeText("2020 Hope Sharing Relay", white, 21),
                    makeText("Let's Run & Share", white, 21),
                  ],
                ),
              ),
              Expanded(flex: 1, child: Container(child: Text(''))),
              Expanded(
                flex: 6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    (widget.totalDistance / 1000) >= 5.0
                        ? Container(
                            // height:  MediaQuery.of(context).size.height * 0.8,
                            //margin: EdgeInsets.symmetric(vertical: 10),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            width: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(
                                color: mandarin,
                                // border: Border.all(color: lightwhite, width: 3),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                boxShadow: [customeBoxShadow()]),
                            child: Column(children: [
                              makeTextThin(
                                  "Congratulations,", Colors.white, 20),
                              makeTextThin(widget.userName, Colors.white, 20),
                              makeTwoColor(
                                  "You've run ",
                                  (widget.totalDistance / 1000)
                                          .toStringAsFixed(1) +
                                      "km !",
                                  Colors.white,
                                  Colors.white,
                                  20),
                              makeTextSemiThin(
                                  _printDuration(Duration(
                                          seconds: widget.recordTime)) +
                                      ' (' +
                                      speed.toStringAsFixed(1) +
                                      ' m/s)',
                                  Colors.white,
                                  20),
                            ]))
                        : Container(
                            // height:  MediaQuery.of(context).size.height * 0.8,
                            //margin: EdgeInsets.symmetric(vertical: 10),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            width: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(
                                color: deepPastelblue,
                                // border: Border.all(color: lightwhite, width: 3),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                boxShadow: [customeBoxShadow()]),
                            child: Column(children: [
                              makeTextThin(widget.userName, Colors.white, 20),
                              makeTwoColor(
                                  "You've run ",
                                  (widget.totalDistance / 1000)
                                          .toStringAsFixed(1) +
                                      "km !",
                                  Colors.white,
                                  Colors.white,
                                  20),
                              makeTextSemiThin(
                                  _printDuration(Duration(
                                          seconds: widget.recordTime)) +
                                      ' (' +
                                      speed.toStringAsFixed(1)+
                                      ' m/s)',
                                  Colors.white,
                                  20),
                            ]))
                  ],
                ),
              ),
              Expanded(flex: 1, child: Container(child: Text(''))),
              Expanded(
                  flex: 4,
                  child: (widget.totalDistance / 1000) >= 5.0
                      ? RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: <TextSpan>[
                            TextSpan(
                                text: "We certified\n",
                                style: TextStyle(
                                    color: superlight,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18)),
                            TextSpan(
                                text: "4hours",
                                style: TextStyle(
                                    color: white,
                                    backgroundColor: mandarin,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20)),
                            TextSpan(
                                text: " of volunteer work !",
                                style: TextStyle(
                                    color: superlight,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18)),
                          ]))
                      // ? Column(
                      //     mainAxisAlignment: MainAxisAlignment.end,
                      //     children: [
                      //       makeTwoColor("We certified ", "4 hours",
                      //           Colors.white70, white, 20),
                      //       // makeTextSemiThin(
                      //       //     "We certified 4 hours", Colors.white70, 20),
                      //       makeTextSemiThin(
                      //           "of volunteer work for", Colors.white70, 20),
                      //       makeTextSemiThin(
                      //           "Hope Sharing Relay", Colors.white70, 20),
                      //     ],
                      //   )
                      : RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: <TextSpan>[
                            TextSpan(
                                text: "5km are needed to receive\n",
                                style: TextStyle(
                                    color: superlight,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18)),
                            TextSpan(
                                text: "4hours",
                                style: TextStyle(
                                    color: white,
                                    backgroundColor: deepPastelblue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20)),
                            TextSpan(
                                text: " of volunteer work !",
                                style: TextStyle(
                                    color: superlight,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18)),
                          ]))),
              Expanded(flex: 1, child: Container(child: Text(''))),
              Expanded(
                  flex: 3,
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: RaisedButton(
                        onPressed: () => customAlert(
                            context: context,
                            str: "Wish to make a dontaion?",
                            function: () {
                              _openURL();
                              Navigator.of(context).pop();
                            }),
                        // _updateInfo,
                        color: mandarin,
                        shape: RoundedRectangleBorder(
                            // border: Border.all(color: lightwhite, width: 3),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              makeTextSemiThin('More Donation', white, 24),
                              makeTextSemiThin('Gift for seniors', white, 12),
                            ],
                          ),
                        ),
                      ))),
              Expanded(flex: 1, child: Container(child: Text(''))),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    makeTextSemiThin(
                        "American Korean United Foundation", Colors.white, 15),
                  ],
                ),
              ),
              Expanded(flex: 1, child: Container(child: Text(''))),
              Expanded(
                  flex: 3,
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: RaisedButton(
                        onPressed: () => customAlert(
                            context: context,
                            str: "Subscribe Hope Sharing Relay?",
                            function: () {
                              _updateInfo();
                              Navigator.of(context).pop();
                            }),
                        // _updateInfo,
                        color: Colors.blue[400],
                        shape: RoundedRectangleBorder(
                            // border: Border.all(color: lightwhite, width: 3),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              makeTextSemiThin('More Volunteer', white, 24),
                              makeTextSemiThin(
                                  'Subscribe Hope Sharing Relay', white, 12),
                            ],
                          ),
                        ),
                      ))),
              Expanded(flex: 1, child: Container(child: Text(''))),
              Expanded(
                  flex: 3,
                  child: Container(
                    // height:  MediaQuery.of(context).size.height * 0.8,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: RaisedButton(
                      onPressed: _navigationRanking,
                      color: Colors.green[400],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: makeTextSemiThin('Show Ranking', lightwhite, 24),
                      ),
                    ),
                  )),
              Expanded(flex: 2, child: Container(child: Text(''))),
            ],
          ),
        ));
  }
}
