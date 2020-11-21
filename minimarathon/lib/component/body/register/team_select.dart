import 'package:flutter/material.dart';
import 'package:minimarathon/component/header/header.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../util/text_style.dart';
import '../relay/relay_start.dart';
import '../register/team_register.dart';
import 'package:minimarathon/util/palette.dart';


final databaseReference = FirebaseDatabase.instance.reference();

class TeamSelect extends StatefulWidget {
  TeamSelect();

  @override
  _TeamSelectState createState() => _TeamSelectState();
}

class _TeamSelectState extends State<TeamSelect> {
  List<String> teamList = <String>['team1', 'team2'];

  void _navigation() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => RelayStart(),
      ),
    );
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

    databaseReference.child("Teams").once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((k,v) {
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
            bottom: PreferredSize(
              child: Container(
                color: lightwhite,
                height: 1.0,
                width: MediaQuery.of(context).size.width * 0.9,
              ),
              preferredSize: Size.fromHeight(1.0),
            ),
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
              return Container(
                color: pastelblue,
                alignment: Alignment.center,
                child: Center(
                  child: FlatButton(
                      onPressed: _navigation,
                      child: Container(
                        child: makeText(
                          '${teamList[index]}', Colors.white, 20),
                      ),
                    )),
                );
              }
        ),
    );
  }
}