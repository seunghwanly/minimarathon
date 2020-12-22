import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:minimarathon/component/body/register/need_payment_register.dart';
import 'package:minimarathon/component/body/relay/relay_start.dart';
import 'package:minimarathon/component/header/header.dart';
import 'package:minimarathon/component/loading.dart';
import 'package:minimarathon/util/palette.dart';

class PaidUser {
  final bool isPaidUser;
  final bool isTeam;
  final bool isMember;
  final bool isLeader;
  final String username;
  final String teamname;

  PaidUser({
    this.isPaidUser,
    this.isTeam,
    this.isMember,
    this.isLeader,
    this.username,
    this.teamname,
  });
}

class RoutePage extends StatefulWidget {
  final String telephonecode;
  RoutePage({this.telephonecode});

  @override
  _RoutePageState createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  String telephonecode;
  @override
  void initState() {
    super.initState();
    telephonecode = widget.telephonecode;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: pastelblue,
      body: FutureBuilder(
        future: checkUserisPaid(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return new Center(child: LoadingPage());
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
                telephonecode: this.widget.telephonecode,
              );
            } else {
              return NeedPaymentRegister(
                isoCode: telephonecode,
              );
            }
          }
        },
      ),
    );
  }

  //사용자가 Donation 을 했는지 검사
  Future<PaidUser> checkUserisPaid() async {
    // database
    DatabaseReference dbRef =
        FirebaseDatabase.instance.reference().child('2020HopeRelay');
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
          }
        });
      });

      await dbRef.child("Teams").once().then((DataSnapshot teamSnapshot) {
        var fetchedData = Map<String, dynamic>.from(teamSnapshot.value);
        fetchedData.forEach((key, value) {
          String checkTeamname = key.toString();
          // key -> teamname
          var eachTeamData = Map<dynamic, dynamic>.from(value);
          // for each
          eachTeamData.forEach((key, value) {
            bool checkTeamLeader = false;
            bool checkMember = false;
            String checkUsername = "";

            // Team Leader
            if (key == "leader") {
              if (value['phoneNumber'] == currentUser.phoneNumber) {
                // is Team Leader !
                checkUsername = value['name'];
                checkTeamLeader = true;
              }
            }
            // Member
            else if (key == "members") {
              var memberListData = List<Map<dynamic, dynamic>>.from(value);
              memberListData.forEach((element) {
                var eachMemberData = Map<dynamic, dynamic>.from(element);
                //check number
                if (currentUser.phoneNumber == eachMemberData['phoneNumber']) {
                  checkMember = true;
                  checkUsername = eachMemberData['name'];
                }
              });
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
    return result != null ? result : result = PaidUser(isPaidUser: false);
  }
}
