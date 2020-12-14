import 'package:flutter/material.dart';
import 'package:minimarathon/component/body/relay/background_location.dart';
import 'package:minimarathon/component/header/header.dart';
import 'package:minimarathon/util/custom_dialog.dart';
import 'package:minimarathon/util/palette.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../util/text_style.dart';
import '../relay/ranking.dart';
import '../register/edit_member_info.dart';

class RelayStart extends StatefulWidget {
  final bool isTeam;
  final bool isLeader;
  final bool ismember;
  final String telephonecode;
  final String teamname;
  final String username;

  RelayStart({
    this.isLeader,
    this.isTeam,
    this.ismember,
    this.username,
    this.teamname,
    this.telephonecode,
  });
  @override
  RelayStartState createState() => RelayStartState();
}

class RelayStartState extends State<RelayStart> {
  String username = 'Jong Ha Park';
  String teamname = '';
  bool isTeamLeader = false;

  // url open -> donation
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
                  EditMemberInfo(teamName: teamname, userName: username)));
    } else {
      showMyDialog(context, 'ONLY for Team Leader');
    }
  }

  void _navigationToLocation() {
    DateTime currentTime = DateTime.now();

    // TODO : 마라톤 일정에 맞게 D-Day
    // TODO : 2020,12,18,00,00 으로 바꾸기.

    // TODO : 마라톤 일정에 맞게 Finish Day
    // TODO : 2020,12,20,00,00 으로 바꾸기.
    // DateTime d_day = DateTime(2020, 12, 18, 20, 00, 00);
    // DateTime finish_day = DateTime(2020, 12, 20, 20, 00, 00);

    DateTime d_day = DateTime(2020, 12, 18, 20, 00, 00);
    DateTime finish_day = DateTime(2020, 12, 20, 20, 00, 00);
    if (currentTime.isBefore(d_day) == true) {
      //before
      showMyDialog(context,
          "Sorry, " + username + '\n' + "Relay is Available on December 18th.");
    } else if (currentTime.isAfter(d_day) && currentTime.isAfter(finish_day)) {
      //after
      showMyDialog(context, "Sorry, " + username + '\n' + "Relay is Finished.");
    }
    //마라톤 시작 !
    else {
      customAlertRichText(
          context: context,
          function: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => MyBackgroundLocation(
                  teamName: teamname,
                  userName: username,
                ),
              ),
            );
          },
          richText: RichText(
            textAlign: TextAlign.center,
            softWrap: true,
            text: TextSpan(children: <TextSpan>[
              TextSpan(
                  text: "Tips\n\n",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: MediaQuery.of(context).size.width / 22,
                    letterSpacing: 2.0,
                  )),
              TextSpan(
                  text: "The Distance measurement is based on your device's ",
                  style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w600,
                      fontSize: MediaQuery.of(context).size.width / 24)),
              TextSpan(
                  text: "GPS & Network",
                  style: TextStyle(
                      color: white,
                      backgroundColor: mandarin,
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width / 24)),
              TextSpan(
                  text:
                      ".\nPlease, take your device outside with you for the marathon!\nIf you have existing record, it will be ",
                  style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w600,
                      fontSize: MediaQuery.of(context).size.width / 24)),
              TextSpan(
                  text: "overwritten!",
                  style: TextStyle(
                      color: white,
                      backgroundColor: mandarin,
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width / 24)),
            ]),
          ));
    }
  }

  @override
  void initState() {
    super.initState();
    print('code:' + this.widget.telephonecode);
    setState(() {
      username = widget.username;
      teamname = widget.teamname;
    });
  }

  Widget topUserContainer() {
    if (widget.isLeader) {
      return Column(
        children: [
          makeText('Welcome, ${widget.username} !', lightwhite, 22),
          makeText('The Leader of ${widget.teamname} !', lightwhite, 22),
        ],
      );
    } else if (widget.ismember) {
      return Column(
        children: [
          makeText('Welcome, ${widget.username} !', lightwhite, 22),
          makeText('You belong to ${widget.teamname} !', lightwhite, 22),
        ],
      );
    } else {
      return Column(
        children: [
          makeText('Welcome, ${widget.username} !', lightwhite, 22),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomHeader(
        title: "Hope Sharing Relay",
        body: new Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    topUserContainer(),
                  ],
                ),
              ),
              Expanded(
                flex: 7,
                // child: Container(
                //   padding:
                //       EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(30.0),
                //       color: deepPastelblue),
                //   alignment: Alignment.center,
                //   child:
                //  )
                child: Image(
                  image: AssetImage('images/home.png'),
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width * 0.8,
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
                          color: superlight,
                          fontWeight: FontWeight.w600,
                          fontSize: MediaQuery.of(context).size.width / 24,
                        )),
                    TextSpan(
                        text: "2020 Hope Sharing Relay !",
                        style: TextStyle(
                          color: white,
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width / 24,
                        )),
                  ]),
                ),
              ),
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
                        child: makeText('Relay START', lightwhite,
                            MediaQuery.of(context).size.width / 18),
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
                        child: makeText('Ranking', lightwhite,
                            MediaQuery.of(context).size.width / 18),
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
                      color: Colors.blue[400],
                      child: Container(
                        child: makeText('Edit Member Info', lightwhite,
                            MediaQuery.of(context).size.width / 18),
                      ),
                    ),
                  )),
              Expanded(flex: 1, child: Container(child: Text(''))),
              Expanded(
                  flex: 2,
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: RaisedButton(
                        onPressed: () => customAlert(
                            context: context,
                            str: "Wish to make a dontaion?",
                            function: () {
                              Navigator.of(context).pop();
                              _openURL();
                            }),
                        // _updateInfo,
                        color: deepPastelblue,
                        shape: RoundedRectangleBorder(
                            // border: Border.all(color: lightwhite, width: 3),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              makeTextSemiThin('Donation', white,
                                  MediaQuery.of(context).size.width / 20),
                              makeTextSemiThin('Gift for seniors', white,
                                  MediaQuery.of(context).size.width / 44),
                            ],
                          ),
                        ),
                      ))),
              Expanded(flex: 1, child: Container(child: Text(''))),
            ],
          ),
        ));
  }
}
