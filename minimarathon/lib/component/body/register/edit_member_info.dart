import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:minimarathon/component/body/relay/relay_start.dart';
import '../../header/header.dart';
import 'package:minimarathon/util/FirebaseMethod.dart';
import 'package:minimarathon/util/custom_dialog.dart';
import 'package:minimarathon/util/palette.dart';
import 'package:minimarathon/util/paypal/paypal_payment.dart';
//firebase
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
//phone number
import 'package:libphonenumber/libphonenumber.dart';

import '../../loading.dart';
// model
import '../../../model/model_register.dart';

final databaseReference =
    FirebaseDatabase.instance.reference().child('2020HopeRelay');
final FirebaseAuth auth = FirebaseAuth.instance;

class EditMemberInfo extends StatefulWidget {
  final String teamName;
  final String userName;

  EditMemberInfo({this.teamName, this.userName});

  @override
  _EditMemberInfoState createState() => _EditMemberInfoState();
}

class _EditMemberInfoState extends State<EditMemberInfo> {
  //focusnode
  FocusNode focusDonationFee = new FocusNode();
  FocusNode focusTeamDuplicate = new FocusNode();
  List<FocusNode> focusNameList = new List<FocusNode>();
  List<FocusNode> focusPhoneNumberList = new List<FocusNode>();

  //text controller
  TextEditingController teamnameControlller = new TextEditingController();
  final List<TextEditingController> _editingController =
      new List<TextEditingController>();
  final List<TextEditingController> _memberNumTextController =
      new List<TextEditingController>();

  //firebase auth
  DatabaseReference teamReference = FirebaseDatabase.instance
      .reference()
      .child('2020HopeRelay')
      .child("Teams");
  User _user = FirebaseAuth.instance.currentUser;

  final _formKey = GlobalKey<FormState>(); //form

  //data for push
  Team teamData;
  List<Member> memberList = new List<Member>();
  int memberLength;
  // data from Team Database
  List<String> teamNameList = new List<String>();

  //result state
  bool isPaymentAvailable = false;
  bool isRegisterAvailable = false;
  bool isPaymentFinished = false;
  bool isMemberCheckedAvailable = false;
  bool isTeamnameChecked = false;
  int isTeamnameDuplicate = 0;

  void _checkMemberList() async {
    await databaseReference
        .child("Teams")
        .child(widget.teamName)
        .once()
        .then((DataSnapshot dataSnapshot) {
      dataSnapshot.value.forEach((k, v) {
        if (k == "members") {
          var members = List<Map<dynamic, dynamic>>.from(v);

          members.forEach((values) {
            var eachMemberData = Map<dynamic, dynamic>.from(values);
            Member newMember = new Member();
            newMember.name = eachMemberData['name'];
            newMember.phoneNumber = eachMemberData['phoneNumber'];
            memberList.add(newMember);
          });
        }
      });
    });
  }

  void _navigation() async {
    //수정되었습니다. 알림 주기
    await databaseReference
        .child("Teams")
        .child(widget.teamName)
        .once()
        .then((DataSnapshot dataSnapshot) {
      dataSnapshot.value.forEach((k, v) {
        if (k == "members") {
          var members = List<Map<dynamic, dynamic>>.from(v);
          members.forEach((values) {
            int index = members.indexOf(values);
            databaseReference
                .child("Teams")
                .child(widget.teamName)
                .child("members")
                .child(index.toString())
                .update({
              'name': memberList[index].name,
              'phoneNumber': memberList[index].phoneNumber,
            });
          });
        }
      });
    });
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => RelayStart(
              isLeader: true,
              isTeam: true,
              ismember: false,
              username: widget.userName,
              teamname: widget.teamName,
            )));
  }

  @override
  void initState() {
    super.initState();
    _checkMemberList();
    //init state
    teamData = new Team();
    memberLength = 2; // team >= 2
    teamData.teamName = "ex) han's Family";
    teamData.donationFee = memberLength * 10;

    teamData.members = memberList;
    //focusNode
    for (int i = 0; i < memberLength; ++i) {
      focusNameList.add(new FocusNode());
      focusPhoneNumberList.add(new FocusNode());
      _editingController.add(new TextEditingController(text: ""));
    }
    // fetch data from team database
    teamReference.once().then((DataSnapshot snapshot) {
      var fetchedData = new Map<String, dynamic>.from(snapshot.value);
      fetchedData.forEach((key, value) {
        setState(() {
          teamNameList.add(key.toString());
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isPaymentFinished && isPaymentAvailable) {
      return LoadingPage();
    } else {
      return CustomHeader(
        title: "Edit Member Info",
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
                child: SizedBox(
              height: MediaQuery.of(context).size.height * 1.8,
              width: MediaQuery.of(context).size.width,
              child: Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: deepPastelblue),
                          alignment: Alignment.center,
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text: "NOTICE",
                                  style: TextStyle(
                                    color: white,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20,
                                    letterSpacing: 2.0,
                                  )),
                              TextSpan(
                                  text:
                                      "\nYou can edit your team member's information.",
                                  style: TextStyle(
                                      color: lightwhite,
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              26)),
                            ]),
                          ),
                        )),
                    Expanded(
                        // ---------------------------------------------------------------------------MEMBERS
                        flex: 6,
                        child: Container(
                            margin: EdgeInsets.symmetric(vertical: 10.0),
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                                color: deepPastelblue),
                            child: ListView.builder(
                              //TODO:scrollcontroller height
                              // physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: memberList.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  // ------------------------ index
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  margin: EdgeInsets.symmetric(vertical: 10.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                        margin:
                                            EdgeInsets.symmetric(vertical: 5.0),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Member " + (index + 1).toString(),
                                          style: TextStyle(
                                              color: lightwhite,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 20.0),
                                        ),
                                      ),
                                      // ------------------------ name
                                      Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                          margin: EdgeInsets.symmetric(
                                              vertical: 5.0),
                                          child: TextField(
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.transparent,
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      borderSide:
                                                          new BorderSide(
                                                              color: mandarin,
                                                              width: 3)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  borderSide: BorderSide(
                                                      color: mandarin,
                                                      width: 3)),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  borderSide: new BorderSide(
                                                      color: lightwhite,
                                                      width: 3)),
                                              hintText:
                                                  '${memberList[index].name}',
                                              hintStyle: TextStyle(
                                                  color: Colors.white54),
                                              labelText:
                                                  '${memberList[index].name}',
                                              labelStyle: TextStyle(
                                                  color: Colors.white54,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            enabled: true,
                                            style: TextStyle(color: lightwhite),
                                            onChanged: (name) {
                                              setState(() {
                                                memberList[index].name = name;
                                              });
                                            },
                                            textInputAction:
                                                TextInputAction.next,
                                            keyboardType:
                                                TextInputType.numberWithOptions(
                                                    signed: true),
                                            focusNode: focusNameList[index],
                                            onEditingComplete: () => FocusScope
                                                    .of(context)
                                                .requestFocus(index == 0
                                                    ? focusNameList[index + 1]
                                                    : focusPhoneNumberList[
                                                        index]),
                                            cursorWidth: 4.0,
                                          )),
                                      // ------------------------ phone
                                      Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                          margin: EdgeInsets.symmetric(
                                              vertical: 5.0),
                                          child: TextField(
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.transparent,
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      borderSide:
                                                          new BorderSide(
                                                              color: mandarin,
                                                              width: 3)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  borderSide: BorderSide(
                                                      color: mandarin,
                                                      width: 3)),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  borderSide: new BorderSide(
                                                      color: lightwhite,
                                                      width: 3)),
                                              hintText:
                                                  '${memberList[index].phoneNumber}',
                                              hintStyle: TextStyle(
                                                  color: Colors.white54),
                                              labelText:
                                                  '${memberList[index].phoneNumber}',
                                              labelStyle: TextStyle(
                                                  color: Colors.white54,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            enabled: true,
                                            style: TextStyle(color: lightwhite),
                                            onChanged: (number) {
                                              setState(() {
                                                memberList[index].phoneNumber =
                                                    '+1' + number;
                                              });
                                            },
                                            textInputAction:
                                                TextInputAction.next,
                                            keyboardType:
                                                TextInputType.numberWithOptions(
                                                    signed: true),
                                            focusNode:
                                                focusPhoneNumberList[index],
                                            onEditingComplete: () {
                                              if (index == memberLength - 1) {
                                                //last member
                                                FocusScope.of(context)
                                                    .requestFocus(
                                                        focusDonationFee);
                                              } else {
                                                FocusScope.of(context)
                                                    .requestFocus(focusNameList[
                                                        index + 1]);
                                              }
                                            },
                                            cursorWidth: 4.0,
                                          ))
                                    ],
                                  ),
                                );
                              },
                            ))),
                    Expanded(
                        flex: 2,
                        child: Container(
                            margin: EdgeInsets.symmetric(vertical: 10.0),
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: RaisedButton(onPressed: () {
                              _navigation();
                            }))),
                  ],
                ),
              ),
            ))),
      );
    }
  }
}
