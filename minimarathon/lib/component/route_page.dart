import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:minimarathon/component/body/register/need_payment_register.dart';
import 'package:minimarathon/component/body/relay/relay_start.dart';
import 'package:minimarathon/component/header/header.dart';
import 'package:minimarathon/component/loading.dart';

class PaidUser {
  final bool isPaidUser;
  final bool isTeam;
  final bool isMember;
  final bool isLeader;
  final String username;
  final String teamname;

  PaidUser(
      {this.isPaidUser,
      this.isTeam,
      this.isMember,
      this.isLeader,
      this.username,
      this.teamname});
}

class RoutePage extends StatefulWidget {
  RoutePage({Key key}) : super(key: key);

  @override
  _RoutePageState createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: FutureBuilder(
        future: checkUserisPaid(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return LoadingPage();
          } else if (snapshot.hasError) {
            return Text("LOGIN ERROR !");
          } else {
            PaidUser result = snapshot.data;
            if (result.isPaidUser) {
              return RelayStart(
                isLeader: result.isLeader,
                isTeam: result.isTeam,
                ismember: result.isMember,
                username: result.username,
                teamname: result.teamname,
              );
            } else {
              return NeedPaymentRegister();
            }
          }
        },
      ),
    );
  }

  Future<PaidUser> checkUserisPaid() async {
    // database
    DatabaseReference dbRef = FirebaseDatabase.instance.reference();
    // user
    User currentUser = FirebaseAuth.instance.currentUser;
    //return value
    PaidUser result;

    if (currentUser != null) {
      //Single
      await dbRef.child('Single').once().then((DataSnapshot singleSnapshot) {
        var fetchedUids = Map<String, dynamic>.from(singleSnapshot.value);
        fetchedUids.forEach((key, value) {
          if (currentUser.uid == key) {
            print("this user is paid for single > " +
                key +
                ' | ' +
                currentUser.uid);
            result = PaidUser(
                isLeader: false,
                isMember: false,
                isTeam: false,
                isPaidUser: true,
                username: value['name'],
                teamname: "");
            print(result.toString());
            return result;
          }
        });
      });

      await dbRef.child("Teams").once().then((DataSnapshot teamSnapshot) {
        var fetchedData = Map<String, dynamic>.from(teamSnapshot.value);
        print("Team");
        fetchedData.forEach((key, value) {
          // key -> teamname
          print('> ' + key);
          var eachTeamData = Map<dynamic, dynamic>.from(value);
          // for each
          eachTeamData.forEach((key, value) {
            print('> > ' + key.toString());
            bool checkTeamLeader = false;
            bool checkMember = false;
            String checkUsername = "";
            String checkTeamname = "";
            // Team Leader
            if (key == "leader") {
              if (value['phoneNumber'] == currentUser.phoneNumber) {
                // is Team Leader !
                print('Team Leader');
                checkTeamLeader = true;
              }
            }
            // Member
            else if (key == "members") {
              var memberListData = List<Map<dynamic, dynamic>>.from(value);
              memberListData.forEach((element) {
                print('> > > ' + element.toString());
                var eachMemberData = Map<dynamic, dynamic>.from(element);
                //check number
                if (currentUser.phoneNumber == eachMemberData['phoneNumber']) {
                  print("Team Member");
                  checkMember = true;
                  checkUsername = eachMemberData['name'];
                }
              });
            } else if (key == "teamName") {
              checkTeamname = key.toString();
            }

            if (checkMember || checkTeamLeader) {
              result = PaidUser(
                  isLeader: checkTeamLeader,
                  isMember: checkMember,
                  isPaidUser: true,
                  isTeam: true,
                  username: checkUsername,
                  teamname: checkTeamname);
            }
          });
        });
      });
    }
    return result;
  }
}
