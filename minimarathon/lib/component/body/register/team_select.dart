import 'package:flutter/material.dart';
import 'package:minimarathon/component/header/header.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../util/text_style.dart';
import '../relay/relay_start.dart';

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
    return CustomHeader(
        title: "Team Select",
        body: new ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: teamList.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 50, 
                color: Colors.black.withOpacity(0.16), 
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