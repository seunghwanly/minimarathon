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

class TeamRegister extends StatefulWidget {
  final title;
  final isoCode;

  TeamRegister({this.title, this.isoCode});

  @override
  _TeamRegisterState createState() => _TeamRegisterState();
}

class _TeamRegisterState extends State<TeamRegister> {
  //focusnode
  FocusNode focusDonationFee = new FocusNode();
  FocusNode focusTeamDuplicate = new FocusNode();
  List<FocusNode> focusNameList = new List<FocusNode>();
  List<FocusNode> focusPhoneNumberList = new List<FocusNode>();

  //text controller
  TextEditingController teamnameControlller = new TextEditingController();

  //firebase auth
  DatabaseReference teamReference =
      FirebaseDatabase.instance.reference().child("Teams");
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

  //check team name
  bool checkTeamname(BuildContext context) {
    String name = teamnameControlller.text.trim();
    if (!teamNameList.contains(name)) {
      showMyDialog(context, "You can use that Team name !");
      setState(() {
        isTeamnameDuplicate = 1;
        isTeamnameChecked = true;
      });
      return true;
    }
    // 이름검사결과 중복된갑이 없으면 true
    else {
      showMyDialog(context, "Please use different name !");
      setState(() {
        isTeamnameDuplicate = 2;
        isTeamnameChecked = false;
      });
      return false;
    }
  }

  @override
  void initState() {
    super.initState();

    //init state
    teamData = new Team();
    memberLength = 2; // team >= 2
    teamData.teamName = "";
    teamData.donationFee = memberLength * 10;
    teamData.members = memberList;

    //memberList
    for (int i = 0; i < memberLength; ++i) {
      Member newMember = new Member();
      if (i == 0) {
        newMember.name = "  Leader name";
        newMember.phoneNumber = _user.phoneNumber;
      } else {
        newMember.name = "  Memeber name";
        newMember.phoneNumber = "  Member phone number";
      }

      newMember.moreVolunteer = false;
      memberList.add(newMember);
    }
    //focusNode
    for (int i = 0; i < memberLength; ++i) {
      focusNameList.add(new FocusNode());
      focusPhoneNumberList.add(new FocusNode());
    }

    // fetch data from team database
    teamReference.once().then((DataSnapshot snapshot) {
      var fetchedData = new Map<String, dynamic>.from(snapshot.value);
      fetchedData.forEach((key, value) {
        // print(key.toString());
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
        title: "Team Register",
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
                        width: MediaQuery.of(context).size.width * 0.8,
                        margin: EdgeInsets.only(bottom: 10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                                flex: 3,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Team Name",
                                    style: TextStyle(
                                        color: lightwhite,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0),
                                  ),
                                )),
                            Expanded(
                                flex: 6,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      flex: 7,
                                      child: Container(
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
                                                  color: lightwhite, width: 3)),
                                          hintStyle:
                                              TextStyle(color: Colors.white54),
                                          labelText: '  ${teamData.teamName}',
                                          labelStyle: TextStyle(
                                              color: isTeamnameDuplicate == 0
                                                  ? Colors.white54
                                                  : isTeamnameDuplicate == 1
                                                      ? Colors.green[400]
                                                      : Colors.red[400],
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        style: TextStyle(color: lightwhite),
                                        textInputAction: TextInputAction.done,
                                        onChanged: (name) {
                                          setState(() {
                                            teamData.teamName = name;
                                          });
                                        },
                                        onEditingComplete: () =>
                                            FocusScope.of(context)
                                                .requestFocus(focusNameList[0]),
                                        cursorWidth: 4.0,
                                        controller: teamnameControlller,
                                      )),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: SizedBox(),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            color: lightwhite,
                                          ),
                                          child: Container(
                                              alignment: Alignment.center,
                                              child: isTeamnameDuplicate == 0
                                                  ? Icon(
                                                      Icons.search,
                                                      color: darkblue,
                                                      size: 30,
                                                    )
                                                  : isTeamnameDuplicate == 1
                                                      ? Icon(Icons.check,
                                                          color:
                                                              Colors.green[400],
                                                          size: 30)
                                                      : Icon(Icons.close,
                                                          color:
                                                              Colors.red[400],
                                                          size: 30))),
                                    )
                                  ],
                                ))
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 5.0),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "name duplication check will be done before payment !",
                            style: TextStyle(
                                color: lightwhite,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0),
                          ),
                        )),
                    Expanded(
                      //-------------------------------------------------------------------Buttons
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                              margin: EdgeInsets.symmetric(horizontal: 10.0),
                              child: RaisedButton(
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
                              child: RaisedButton(
                                onPressed: () {
                                  if (memberLength <
                                      9) // upto 10 members to join
                                    setState(() {
                                      memberLength++;
                                      Member newMember = new Member();
                                      newMember.name = "  Memeber name";
                                      newMember.phoneNumber =
                                          "  Member phone number";
                                      newMember.moreVolunteer = false;
                                      memberList.add(newMember);
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
                            padding: EdgeInsets.symmetric(vertical: 5.0),
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
                                  // ---------------------------------------------------------------------------Member index
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
                                          index == 0
                                              ? "Team Leader"
                                              : "Member " + (index).toString(),
                                          style: TextStyle(
                                              color: lightwhite,
                                              fontWeight: index == 0
                                                  ? FontWeight.bold
                                                  : FontWeight.w500,
                                              fontSize: 20.0),
                                        ),
                                      ),
                                      Container(
                                          // ---------------------------------------------------------------------------Member name
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                          margin: EdgeInsets.symmetric(
                                              vertical: 5.0),
                                          child: TextField(
                                            decoration: InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  borderSide: BorderSide(
                                                      color: index == 0
                                                          ? mandarin
                                                          : lightwhite,
                                                      width: 3)),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  borderSide: new BorderSide(
                                                      color: index == 0
                                                          ? mandarin
                                                          : lightwhite,
                                                      width: 3)),
                                              // labelText: 'Member ' +
                                              //     (index + 1).toString() +
                                              //     ' Name',
                                              labelText:
                                                  '${memberList[index].name}',
                                              hintText:
                                                  '  Please type name ...',
                                              hintStyle: TextStyle(
                                                  color: Colors.white54),
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
                                            textInputAction:
                                                TextInputAction.next,
                                            focusNode: focusNameList[index],
                                            onEditingComplete: () => FocusScope
                                                    .of(context)
                                                .requestFocus(index == 0
                                                    ? focusNameList[index + 1]
                                                    : focusPhoneNumberList[
                                                        index]),
                                            cursorWidth: 4.0,
                                          )),
                                      Container(
                                          // ---------------------------------------------------------------------------MEMBERS phone number
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                          margin: EdgeInsets.symmetric(
                                              vertical: 5.0),
                                          child: TextField(
                                            decoration: InputDecoration(
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
                                                      color: white, width: 3)),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  borderSide: new BorderSide(
                                                      color: lightwhite,
                                                      width: 3)),
                                              // TODO : prefix to input
                                              prefixText: '+1', // US
                                              prefixIcon: Text('+1'),
                                              hintText:
                                                  '  Please type phonenumber ...',
                                              hintStyle: TextStyle(
                                                  color: Colors.white54),
                                              labelText: index == 0
                                                  ? _user.phoneNumber
                                                  : '${memberList[index].phoneNumber}',
                                              labelStyle: TextStyle(
                                                  color: Colors.white54,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            enabled: index == 0 ? false : true,
                                            style: TextStyle(color: lightwhite),
                                            onChanged: (number) {
                                              setState(() {
                                                memberList[index].phoneNumber =
                                                    number;
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
                      // ---------------------------------------------------------------------------Donation Fee
                      flex: 2,
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
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
                                              color: lightwhite, width: 3)),
                                      hintText:
                                          '  Please type donation fee ...',
                                      hintStyle:
                                          TextStyle(color: Colors.white54),
                                      labelText: '\$${teamData.donationFee}',
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
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 5.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: !isRegisterAvailable
                                ? mandarin
                                : Colors.green[400]),
                        child: Text(
                          !isRegisterAvailable
                              ? "You can donate from \$${memberLength}0."
                              : "You have successfully completed your donation!",
                          style: TextStyle(
                              color: white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0),
                        ),
                      ),
                    ),
                    // Expanded(
                    //   flex: 1,
                    //   child: SizedBox(),
                    // ),
                    Expanded(
                      flex: 2,
                      child: Container(
                          margin: EdgeInsets.symmetric(vertical: 10.0),
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: RaisedButton(
                              onPressed: () {
                                if (isTeamnameChecked) {
                                  if (!isRegisterAvailable) {
                                    // payment first
                                    if (teamData.donationFee >=
                                                memberLength * 10 &&
                                            teamnameControlller.text.isNotEmpty
                                        //&& teamData.teamName != null
                                        //&& teamData.teamName != "  Team name"
                                        ) {
                                      print('isPaymentAvaialble true');
                                      setState(() {
                                        isPaymentAvailable = true;
                                      });
                                    } else {
                                      showMyDialog(context,
                                          "Please donate least \$10 per members");
                                    }
                                    if (isPaymentAvailable) {
                                      // make payment
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext c) =>
                                                  PaypalPayment(
                                                    donor: teamData.teamName,
                                                    donorPhoneNumber:
                                                        _user.phoneNumber,
                                                    donationFee:
                                                        teamData.donationFee,
                                                    onFinish: (res) async {
                                                      // payment successful
                                                      if (res == "approved") {
                                                        setState(() {
                                                          isRegisterAvailable =
                                                              true;
                                                          isPaymentAvailable =
                                                              false;
                                                          isPaymentFinished =
                                                              !isPaymentFinished;
                                                        });
                                                        teamData.leader =
                                                            memberList
                                                                .elementAt(0);
                                                        memberList.removeAt(0);

                                                        teamData.members =
                                                            memberList;
                                                        // load to firebase
                                                        memberList
                                                            .forEach((element) {
                                                          if (widget.isoCode ==
                                                              "US")
                                                            element.phoneNumber =
                                                                "+1" +
                                                                    element
                                                                        .phoneNumber;
                                                          else if (widget
                                                                  .isoCode ==
                                                              "KR")
                                                            element.phoneNumber =
                                                                "+82" +
                                                                    element
                                                                        .phoneNumber;
                                                        });
                                                        await FirebaseMethod()
                                                            .teamReference
                                                            .child(teamData
                                                                .teamName)
                                                            .set(teamData
                                                                .toJson())
                                                            .then((value) =>
                                                                print(
                                                                    'uploaded !'))
                                                            .catchError(() =>
                                                                print(
                                                                    'onErrr'));

                                                        await showMyDialog(
                                                            context,
                                                            "Payment was succefully done !\n You are now avaiable to register !");
                                                      } else {
                                                        setState(() {
                                                          isPaymentFinished =
                                                              !isPaymentFinished;
                                                        });
                                                        await showMyDialog(
                                                            context,
                                                            'Payment was not Completed !');
                                                      }
                                                    },
                                                  )));
                                    }
                                  } else {
                                    if (isRegisterAvailable &&
                                        !isPaymentAvailable) {
                                      Navigator.of(context)
                                          .pushReplacement(MaterialPageRoute(
                                              builder: (context) => RelayStart(
                                                    isLeader: true,
                                                    isTeam: true,
                                                    ismember: false,
                                                    username:
                                                        teamData.leader.name,
                                                    teamname: teamData.teamName,
                                                  )));
                                    }
                                  }
                                } else
                                  checkTeamname(context);
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              color: royalblue,
                              child: Container(
                                width: double.infinity,
                                // height: MediaQuery.of(context).size.width * 0.2,
                                alignment: Alignment.center,
                                child: Text(
                                  !isTeamnameChecked
                                      ? "Check Team Name"
                                      : !isRegisterAvailable
                                          ? 'Pay by PAYPAL'
                                          : 'REGISTER',
                                  style: TextStyle(
                                      color: white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 26.0),
                                  textAlign: TextAlign.center,
                                ),
                              ))),
                    ),
                  ],
                ),
              ),
            ))),
      );
    }
  }
}
