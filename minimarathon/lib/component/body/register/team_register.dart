import 'package:flutter/material.dart';
import 'package:minimarathon/component/body/register/result_register.dart';
import 'package:minimarathon/util/palette.dart';

import '../../header/header.dart';

//model
class Member {
  String name;
  String phoneNumber;
}

class Team {
  String teamName;
  List<Member> members;
  int donationFee;
}

class TeamRegister extends StatefulWidget {
  final title;

  TeamRegister({this.title});

  @override
  _TeamRegisterState createState() => _TeamRegisterState();
}

class _TeamRegisterState extends State<TeamRegister> {
  final _formKey = GlobalKey<FormState>(); //form

  //data for push
  Team teamData;
  List<Member> memberList = new List<Member>();
  int memberLength;
  //result state
  bool isRegisterAvailable = false;

  //focusnode
  FocusNode focusDonationFee = new FocusNode();
  List<FocusNode> focusNameList = new List<FocusNode>();
  List<FocusNode> focusPhoneNumberList = new List<FocusNode>();

  @override
  void initState() {
    super.initState();

    teamData = new Team();
    memberLength = 2; // team >= 2
    //memberList
    for (int i = 0; i < memberLength; ++i) {
      Member newMember = new Member();
      newMember.name = null;
      newMember.phoneNumber = null;
      memberList.add(newMember);
    }
    //focusNode
    for (int i = 0; i < memberLength; ++i) {
      focusNameList.add(new FocusNode());
      focusPhoneNumberList.add(new FocusNode());
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomHeader(
      title: widget.title,
      body: Form(
          key: _formKey,
          child: SingleChildScrollView(
              child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    // ---------------------------------------------------------------------------TEAM NAME
                    flex: 2,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Team Name",
                              style: TextStyle(
                                  color: lightwhite,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            ),
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: TextField(
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide:
                                          BorderSide(color: white, width: 3)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: new BorderSide(
                                          color: lightwhite, width: 3)),
                                  labelText: '  input Team name ...',
                                  labelStyle: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                                style: TextStyle(color: lightwhite),
                                onChanged: (name) {
                                  setState(() {
                                    teamData.teamName = name;
                                  });
                                },
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () => FocusScope.of(context)
                                    .requestFocus(focusNameList[0]),
                                cursorWidth: 4.0,
                              ))
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                            margin: EdgeInsets.symmetric(horizontal: 10.0),
                            child: FlatButton(
                              onPressed: () {
                                if (memberLength > 2)
                                  setState(() {
                                    memberLength--;
                                    memberList.removeLast();
                                    focusNameList.removeLast();
                                    focusPhoneNumberList.removeLast();
                                  });
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              color: lightwhite,
                              child: Container(
                                width: 50,
                                height: 50,
                                child: Icon(
                                  Icons.remove,
                                  color: darkblue,
                                  size: 40,
                                ),
                              ),
                            )),
                        Container(
                            margin: EdgeInsets.symmetric(horizontal: 10.0),
                            child: FlatButton(
                              onPressed: () {
                                if (memberLength < 9)
                                  setState(() {
                                    memberLength++;
                                    memberList.add(new Member());
                                    focusNameList.add(new FocusNode());
                                    focusPhoneNumberList.add(new FocusNode());
                                  });
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              color: mandarin,
                              child: Container(
                                width: 50,
                                height: 50,
                                child: Icon(
                                  Icons.add,
                                  color: white,
                                  size: 40,
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                  Expanded(
                      // ---------------------------------------------------------------------------MEMBERS
                      flex: 6,
                      child: Container(
                          margin: EdgeInsets.symmetric(vertical: 10.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: royalblue),
                          child: ListView.builder(
                            //TODO:scrollcontroller height
                            // physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: memberList.length,
                            // itemCount: 2,
                            itemBuilder: (context, index) {
                              return Container(
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
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0),
                                      ),
                                    ),
                                    Container(
                                        // ---------------------------------------------------------------------------Member name
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                        margin:
                                            EdgeInsets.symmetric(vertical: 5.0),
                                        child: TextField(
                                          decoration: InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                borderSide: BorderSide(
                                                    color: white, width: 3)),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                borderSide: new BorderSide(
                                                    color: lightwhite,
                                                    width: 3)),
                                            labelText: 'Member ' +
                                                (index + 1).toString() +
                                                ' Name',
                                            labelStyle: TextStyle(
                                                color: Colors.white54,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          style: TextStyle(color: lightwhite),
                                          onChanged: (name) {
                                            setState(() {
                                              memberList[index].name = name;
                                            });
                                          },
                                          textInputAction: TextInputAction.next,
                                          focusNode: focusNameList[index],
                                          onEditingComplete: () => FocusScope
                                                  .of(context)
                                              .requestFocus(
                                                  focusPhoneNumberList[index]),
                                          cursorWidth: 4.0,
                                        )),
                                    Container(
                                        // ---------------------------------------------------------------------------MEMBERS phone number
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                        margin:
                                            EdgeInsets.symmetric(vertical: 5.0),
                                        child: TextField(
                                          decoration: InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                borderSide: BorderSide(
                                                    color: white, width: 3)),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                borderSide: new BorderSide(
                                                    color: lightwhite,
                                                    width: 3)),
                                            labelText: 'Member ' +
                                                (index + 1).toString() +
                                                ' Phone Number',
                                            labelStyle: TextStyle(
                                                color: Colors.white54,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          style: TextStyle(color: lightwhite),
                                          onChanged: (number) {
                                            setState(() {
                                              memberList[index].phoneNumber =
                                                  number;
                                            });
                                          },
                                          textInputAction: TextInputAction.next,
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
                                                  .requestFocus(
                                                      focusNameList[index + 1]);
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
                    // ---------------------------------------------------------------------------Donation Fee
                    flex: 3,
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Donation Fee",
                                style: TextStyle(
                                    color: lightwhite,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: TextField(
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide:
                                            BorderSide(color: white, width: 3)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: new BorderSide(
                                            color: lightwhite, width: 3)),
                                    labelText: '\$${memberLength}0',
                                    labelStyle: TextStyle(
                                        color: Colors.white54,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  style: TextStyle(color: lightwhite),
                                  onChanged: (value) {
                                    setState(() {
                                      teamData.donationFee = int.parse(value);
                                    });
                                  },
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.number,
                                  cursorWidth: 4.0,
                                  focusNode: focusDonationFee,
                                )),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                !isRegisterAvailable
                                    ? "You can donate from \$${memberLength}0."
                                    : "You have successfully completed your donation!",
                                style: TextStyle(
                                    color: !isRegisterAvailable
                                        ? mandarin
                                        : white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                            ),
                          ],
                        )),
                  ),
                  // Expanded(
                  //   flex: 1,
                  //   child: SizedBox(
                  //       // child: Text(singleRegisterData.toString() +  // for debugging
                  //       //     ' ' +
                  //       //     (singleRegisterData['donationFee'] is int).toString()),
                  //       ),
                  // ),
                  Expanded(
                    flex: 1,
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: FlatButton(
                            onPressed: () {
                              if (teamData.donationFee >= memberLength * 10) {
                                setState(() {
                                  isRegisterAvailable = true;
                                });
                              } else {
                                setState(() {
                                  isRegisterAvailable = false;
                                });
                              }
                              if (isRegisterAvailable) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Register()));
                              }
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),),
                                color: mandarin,
                            child: Container(
                              width: double.infinity,
                              // height: MediaQuery.of(context).size.width * 0.2,
                              alignment: Alignment.center,
                              child: Text(
                                !isRegisterAvailable
                                    ? 'Pay by PAYPAL'
                                    : 'REGISTER',
                                style: TextStyle(
                                    color: white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 26.0),
                              ),
                            ))),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                ],
              ),
            ),
          ))),
    );
  }
}
