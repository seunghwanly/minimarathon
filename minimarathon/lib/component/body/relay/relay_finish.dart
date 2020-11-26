import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minimarathon/component/header/header.dart';
import 'relay_start.dart';
import '../../../util/palette.dart';
import '../../../util/text_style.dart';
import 'ranking.dart';
import 'package:firebase_database/firebase_database.dart';

final databaseReference = FirebaseDatabase.instance.reference();
final FirebaseAuth auth = FirebaseAuth.instance;

class RelayFinish extends StatefulWidget {
  final int recordTime;
  final double totalDistance;

  RelayFinish({this.recordTime, this.totalDistance});
  @override
  RelayFinishState createState() => RelayFinishState();
}

class RelayFinishState extends State<RelayFinish> {
  final String username = 'Jong Ha Park';
  String userPhoneNumber;
  // TODO: 이거 start할 때 정보 받아와서 저장
  final String teamName = 'myTeam1';
  bool isTeam = true;

  void getUserNumber() async {
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      userPhoneNumber = user.phoneNumber.toString();
    });
  }

  void _updateInfo() async {
    getUserNumber();
    if (isTeam) {
      await databaseReference
          .child("Teams")
          .child(teamName)
          .child("Team Leader")
          .once()
          .then((DataSnapshot snapshot) {
        Map<dynamic, dynamic> values = snapshot.value;
        values.forEach((k, v) {
          if (v["Phone Number"] == userPhoneNumber) {
            databaseReference
                .child("Teams")
                .child(teamName)
                .child("Team Leader")
                .child(k)
                .update({'More': true});
          }
        });
      });
      await databaseReference
          .child("Teams")
          .child(teamName)
          .child("Team Member")
          .once()
          .then((DataSnapshot snapshot) {
        Map<dynamic, dynamic> values = snapshot.value;
        values.forEach((k, v) {
          if (v["Phone Number"] == userPhoneNumber) {
            databaseReference
                .child("Teams")
                .child(teamName)
                .child("Team Member")
                .child(k)
                .update({'More': true});
          }
        });
      });
    } else {
      databaseReference
          .child("Single")
          .child(auth.currentUser.uid)
          .update({'More': true});
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
  }

  @override
  Widget build(BuildContext context) {
    return CustomHeader(
        title: "Finish Marathon",
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
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        // height:  MediaQuery.of(context).size.height * 0.8,
                        //margin: EdgeInsets.symmetric(vertical: 10),
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                            color: mandarin,
                            border: Border.all(color: lightwhite, width: 3),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Column(children: [
                          makeTextThin("Congratulations,", Colors.white, 20),
                          makeTextThin("Jong ha Park" + '!', Colors.white, 20),
                          makeTwoColor("You walked ", "3.5km !", Colors.white,
                              Colors.white, 20),
                          makeTextSemiThin(
                              _printDuration(
                                  Duration(seconds: widget.recordTime)),
                              Colors.white,
                              20),
                        ]))
                  ],
                ),
              ),
              Expanded(flex: 1, child: Container(child: Text(''))),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    makeTwoColor(
                        "We certified ", "4 hours", Colors.white70, white, 20),
                    // makeTextSemiThin(
                    //     "We certified 4 hours", Colors.white70, 20),
                    makeTextSemiThin("volunteer work for", Colors.white70, 20),
                    makeTextSemiThin("Hope Sharing Relay", Colors.white70, 20),
                  ],
                ),
              ),
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
                    // height:  MediaQuery.of(context).size.height * 0.8,
                    //margin: EdgeInsets.symmetric(vertical: 10),
                    width: MediaQuery.of(context).size.width * 0.8,

                    decoration: BoxDecoration(
                        color: mandarin,
                        border: Border.all(color: lightwhite, width: 3),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: FlatButton(
                      onPressed: _updateInfo,
                      child: Container(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          makeTextSemiThin('More Volunteer', white, 25),
                          makeTextSemiThin('Opportunities', white, 25),
                        ],
                      )),
                    ),
                  )),
              Expanded(flex: 1, child: Container(child: Text(''))),
              Expanded(
                  flex: 2,
                  child: Container(
                    // height:  MediaQuery.of(context).size.height * 0.8,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                        border: Border.all(color: lightwhite, width: 3),
                        color: mandarin,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: FlatButton(
                      onPressed: _navigationRanking,
                      child: Container(
                        child: makeTextSemiThin('Show Ranking', lightwhite, 26),
                      ),
                    ),
                  )),
              Expanded(flex: 2, child: Container(child: Text(''))),
            ],
          ),
        ));
  }
}
