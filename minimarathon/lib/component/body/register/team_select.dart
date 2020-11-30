import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minimarathon/component/header/header.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:minimarathon/util/firebase_method.dart';
import '../../../util/text_style.dart';
import '../relay/relay_start.dart';
import '../register/team_register.dart';
import 'package:minimarathon/util/palette.dart';
import 'package:firebase_auth/firebase_auth.dart';

final databaseReference =
    FirebaseDatabase.instance.reference().child('2020HopeRelay');
final FirebaseAuth auth = FirebaseAuth.instance;

class TeamSelect extends StatefulWidget {
  TeamSelect();

  @override
  _TeamSelectState createState() => _TeamSelectState();
}

class _TeamSelectState extends State<TeamSelect> {
  List<String> teamList = <String>['team1', 'team2'];
  bool isTeam = false;
  String userPhoneNumber;
  var teamLists;

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('ALERT'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('This is not your team.'),
                Text('CHOOSE another team or REGISTER by yourself.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void checkTeamMember(teamName) async {
    getUserNumber();
    await databaseReference
        .child("Teams")
        .child(teamName)
        .child("Team Leader")
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((k, v) {
        if (v["Phone Number"] == userPhoneNumber) {
          isTeam = true;
          print("here?");
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
        print(v["Phone Number"]);
        print(userPhoneNumber);
        if (v["Phone Number"] == userPhoneNumber) {
          isTeam = true;
          print("or here?");
        }
      });
    });
  }

  void getUserNumber() async {
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      userPhoneNumber = user.phoneNumber.toString();
    });
  }

  void _navigation(teamName) {
    checkTeamMember(teamName);
    if (isTeam) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => RelayStart(),
        ),
      );
    } else {
      _showMyDialog();
    }
  }

  void _navToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => TeamRegister(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    teamLists = FirebaseMethod().getTeamMember();

    databaseReference.child("Teams").once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((k, v) {
        teamList.add(k.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Team Select'),
        elevation: 0.0,
        // bottom: PreferredSize(
        //   child: Container(
        //     color: lightwhite,
        //     height: 10.0,
        //     width: MediaQuery.of(context).size.width * 0.9,
        //   ),
        //   preferredSize: Size.fromHeight(1.0),
        // ),
        backgroundColor: pastelblue,
        textTheme: TextTheme(
            headline6: TextStyle(
                color: white, fontWeight: FontWeight.bold, fontSize: 20.0)),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Register Team',
            onPressed: () {
              _navToRegister();
            },
          ),
        ],
      ),
      body: new ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: teamList.length,
          itemBuilder: (BuildContext context, int index) {
            return new Container(
              color: pastelblue,
              alignment: Alignment.center,
              child: Center(
                  child: FlatButton(
                onPressed: () => _navigation(teamList[index]),
                child: Container(
                  child: makeText('${teamList[index]}', Colors.white, 20),
                ),
              )),
            );
          }),
    );
  }
}
