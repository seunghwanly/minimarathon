import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:minimarathon/component/body/relay/relay_start.dart';
import 'package:minimarathon/util/custom_dialog.dart';
import 'package:minimarathon/util/text_style.dart';
import '../../header/header.dart';
import 'package:minimarathon/util/palette.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../model/model_register.dart';
import '../../loading.dart';

DatabaseReference teamReference = FirebaseDatabase.instance.reference().child('2020HopeRelay').child("Teams");

class EditMemberInfo extends StatefulWidget {
  final String teamName;
  final String userName;

  EditMemberInfo({this.teamName, this.userName});

  @override
  _EditMemberInfoState createState() => _EditMemberInfoState();
}

class _EditMemberInfoState extends State<EditMemberInfo> {
  //focusnode
  List<FocusNode> focusNameList = new List<FocusNode>();
  List<FocusNode> focusPhoneNumberList = new List<FocusNode>();
  List<Member> members = new List<Member>();
  int memberLength;

  final _formKey = GlobalKey<FormState>(); //form

  Future<List<Member>> _checkMemberList() async {
    List<Member> memberList = new List<Member>();
    await teamReference
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
    //focusNode
    for (int i = 0; i < memberList.length; ++i) {
      focusNameList.add(new FocusNode());
      focusPhoneNumberList.add(new FocusNode());
    }
    return memberList;
  }

  void _navigation(memberList) async {
    print(memberList);
    //수정되었습니다. 알림 주기
    print(memberList[0].name);
    await teamReference
        .child(widget.teamName)
        .once()
        .then((DataSnapshot dataSnapshot) {
      dataSnapshot.value.forEach((k, v) {
        if (k == "members") {
          var members = List<Map<dynamic, dynamic>>.from(v);
          members.forEach((values) {
            int index = members.indexOf(values);
            teamReference
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
    showMyDialog(context, "Save successfully");

  }

  @override
  void initState() {
    super.initState();

    //memberList
    memberLength = 2;
    for (int i = 0; i < memberLength; ++i) {
      Member newMember = new Member();
      newMember.name = "";
      newMember.phoneNumber = "";
      members.add(newMember);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomHeader(
      title: "Edit Member Info",
      body: FutureBuilder(
        future: _checkMemberList(),
        builder:  (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return new Center(child: LoadingPage());
          } else {
          return Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: SizedBox(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 0,
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
                      flex: 0,
                      child: Container(
                          margin: EdgeInsets.symmetric(vertical: 10.0),
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: deepPastelblue),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return Container(
                                // ------------------------ index
                                width: MediaQuery.of(context).size.width * 0.7,
                                margin: EdgeInsets.symmetric(vertical: 10.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                        margin:
                                            EdgeInsets.symmetric(vertical: 5.0),
                                        child: TextField(
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.transparent,
                                            disabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                borderSide: new BorderSide(
                                                    color: mandarin, width: 3)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                borderSide: BorderSide(
                                                    color: mandarin, width: 3)),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                borderSide: new BorderSide(
                                                    color: lightwhite,
                                                    width: 3)),
                                            hintText:
                                                '${snapshot.data[index].name}',
                                            hintStyle: TextStyle(
                                                color: Colors.white54),
                                            labelText:
                                                '${snapshot.data[index].name}',
                                            labelStyle: TextStyle(
                                                color: Colors.white54,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          enabled: true,
                                          style: TextStyle(color: lightwhite),
                                          onChanged: (name) {
                                            setState(() {
                                              members[index].name = name;
                                            });
                                          },
                                          textInputAction: TextInputAction.next,
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                  signed: true),
                                          focusNode: focusNameList[index],
                                          onEditingComplete: () =>
                                              FocusScope.of(context)
                                                  .requestFocus(index == 0
                                                      ? focusNameList[index + 1]
                                                      : focusPhoneNumberList[
                                                          index]),
                                          cursorWidth: 4.0,
                                        )),
                                    // ------------------------ phone
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                        margin:
                                            EdgeInsets.symmetric(vertical: 5.0),
                                        child: TextField(
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.transparent,
                                            disabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                borderSide: new BorderSide(
                                                    color: mandarin, width: 3)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                borderSide: BorderSide(
                                                    color: mandarin, width: 3)),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                borderSide: new BorderSide(
                                                    color: lightwhite,
                                                    width: 3)),
                                            hintText:
                                                '${snapshot.data[index].phoneNumber}',
                                            hintStyle: TextStyle(
                                                color: Colors.white54),
                                            labelText:
                                                '${snapshot.data[index].phoneNumber}',
                                            labelStyle: TextStyle(
                                                color: Colors.white54,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          enabled: true,
                                          style: TextStyle(color: lightwhite),
                                          onChanged: (number) {
                                            setState(() {
                                              members[index].phoneNumber = number;
                                            });
                                          },
                                          textInputAction: TextInputAction.next,
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                  signed: true),
                                          focusNode:
                                              focusPhoneNumberList[index],
                                          cursorWidth: 4.0,
                                        ))
                                  ],
                                ),
                              );
                            },
                          ))),
                  Expanded(
                      flex: 0,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: RaisedButton(
                          onPressed: () => _navigation(members),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          color: mandarin,
                          child: Container(
                            child: makeText('Save', lightwhite, 28),
                          ),
                        ),
                      )),
                ],
              ),
            ),
          )));
          }}),
          
    );
  }
}
