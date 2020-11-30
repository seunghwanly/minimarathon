import 'package:flutter/material.dart';
import 'package:minimarathon/component/body/relay/background_location.dart';
import 'package:minimarathon/component/header/header.dart';
import 'package:minimarathon/util/custom_dialog.dart';
import 'package:minimarathon/util/palette.dart';
import '../../../util/text_style.dart';
import '../relay/ranking.dart';
import '../register/edit_member_info.dart';

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
  bool isTeamLeader = false;
  void _navigation() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => Ranking(),
      ),
    );
  }

  void _navigationToEdit() {
    if (widget.isLeader) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => 
          EditMemberInfo(teamName: teamname, userName: username)
        )
        );
    } else{
      showMyDialog(context, 'ONLY for Team Leader');
    }

  }

  void _showDialogbefore() {
    showMyDialog(context,
        "Sorry, " + username + '\n\n' + "Relay is Available on December 10th.");
  }

  void _showDialogAfter() {
    showMyDialog(context, "Sorry, " + username + '\n\n' + "Relay is Finished.");
  }

  void _navigationToLocation() {
    DateTime currentTime = DateTime.now();

    // TODO : 마라톤 일정에 맞게 D-Day
    // TODO : 2020,12,18,00,00 으로 바꾸기.

    // TODO : 마라톤 일정에 맞게 Finish Day
    // TODO : 2020,12,20,00,00 으로 바꾸기.
    // DateTime d_day = DateTime(2020, 12, 18, 20, 00, 00);
    // DateTime finish_day = DateTime(2020, 12, 20, 20, 00, 00);

    DateTime d_day = DateTime(2020, 11, 18, 20, 00, 00);
    DateTime finish_day = DateTime(2020, 12, 20, 20, 00, 00);
    if (currentTime.isBefore(d_day) == true) {
      //마라톤날짜 이전
      print(widget.teamname);
      _showDialogbefore();
    }
    //마라톤날짜 종료시점
    else if (currentTime.isAfter(d_day) && currentTime.isAfter(finish_day)) {
      _showDialogAfter();
    }

    //마라톤 시작 !
    else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => MyBackgroundLocation(
            teamName: teamname,
            userName: username,
          ),
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
                        )),
                    TextSpan(
                        text: "2020 Hope Sharing Relay !",
                        style: TextStyle(
                          color: white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          letterSpacing: 2.0,
                        )),
                  ]),
                ),
              ),
              Expanded(
                  flex: 7,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: deepPastelblue),
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
                            )),
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
                  flex: 2,
                  child: Container(
                    // height:  MediaQuery.of(context).size.height * 0.8,
                    //margin: EdgeInsets.symmetric(vertical: 10),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: RaisedButton(
                      onPressed: _navigationToLocation,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      color: mandarin,
                      child: Container(
                        child: makeText('Relay START', lightwhite, 28),
                      ),
                    ),
                  )),
              Expanded(flex: 1, child: Container(child: Text(''))),
              Expanded(
                  flex: 2,
                  child: Container(
                    // height:  MediaQuery.of(context).size.height * 0.8,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: RaisedButton(
                      onPressed: _navigation,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      color: Colors.green[400],
                      child: Container(
                        child: makeText('Ranking', lightwhite, 28),
                      ),
                    ),
                  )),
                  Expanded(flex: 1, child: Container(child: Text(''))),
              Expanded(
                  flex: 2,
                  child: Container(
                    // height:  MediaQuery.of(context).size.height * 0.8,
                    //margin: EdgeInsets.symmetric(vertical: 10),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: RaisedButton(
                      onPressed: _navigationToEdit,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      color: royalblue,
                      child: Container(
                        child: makeText('Edit Member Info', lightwhite, 28),
                      ),
                    ),
                  )),
              Expanded(flex: 2, child: Container(child: Text(''))),
            ],
          ),
        ));
  }
}
