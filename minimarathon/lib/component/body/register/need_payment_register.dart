import 'package:flutter/material.dart';
import 'package:minimarathon/component/body/register/single_register.dart';
import 'package:minimarathon/component/body/relay/relay_start.dart';
import 'package:minimarathon/component/header/header.dart';
import 'package:minimarathon/util/palette.dart';
import 'package:bubble/bubble.dart';

class NeedPaymentRegister extends StatefulWidget {
  NeedPaymentRegister();

  @override
  _NeedPaymentRegisterState createState() => _NeedPaymentRegisterState();
}

class _NeedPaymentRegisterState extends State<NeedPaymentRegister> {
  @override
  Widget build(BuildContext context) {
    return CustomHeader(
        title: "Register",
        body: Container(
            padding: EdgeInsets.all(20.0),
            child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
              Expanded(
                //----------------------------speech bubble for single Register
                flex: 3,
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                            'If you would like to join Hope Sharing Relay in Single, Please press SINGLE REGISTER',
                            style: TextStyle(
                                color: white,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.width / 24),
                            textAlign: TextAlign.center),
                        Text('We need at least \$10 to join us !',
                            style: TextStyle(
                                color: lightwhite,
                                fontWeight: FontWeight.w600,
                                fontSize:
                                    MediaQuery.of(context).size.width / 30),
                            textAlign: TextAlign.center),
                      ],
                    )),
              ),
              Expanded(
                // ---------------------------------------------------------------------------REGISTER
                flex: 3,
                child: Row(
                  children: [
                    Expanded(
                        flex: 4,
                        child: FlatButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SingleRegister(
                                            title: "Single Register",
                                          )));
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            color: mandarin,
                            child: Container(
                                width: double.infinity,
                                height: MediaQuery.of(context).size.width * 0.3,
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Single',
                                      style: TextStyle(
                                          color: lightwhite,
                                          fontWeight: FontWeight.bold,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              12),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      'REGISTER',
                                      style: TextStyle(
                                          color: lightwhite,
                                          fontWeight: FontWeight.bold,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              24),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                )))),
                    Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
                    Expanded(
                        flex: 4,
                        child: FlatButton(
                            onPressed: () {
                              // ** 개발상 편의를 위해 팀 Register 버튼 -> Start Relay 로 이동으로 변경
                              // 2020-11-17

                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (BuildContext context) =>
                              //           TeamRegister(
                              //         title: "Team Register",
                              //       ),
                              //     ));

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      RelayStart(),
                                ),
                              );
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            color: royalblue,
                            child: Container(
                                width: double.infinity,
                                height: MediaQuery.of(context).size.width * 0.3,
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Team',
                                      style: TextStyle(
                                          color: lightwhite,
                                          fontWeight: FontWeight.bold,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              12),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      'REGISTER',
                                      style: TextStyle(
                                          color: lightwhite,
                                          fontWeight: FontWeight.bold,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              24),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                )))),
                  ],
                ),
              ),
              Expanded(
                //----------------------------speech bubble for single Register
                flex: 3,
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Column(
                      children: [
                        Text(
                            'If you would like to join Hope Sharing Relay in Team, Please press TEAM REGISTER',
                            style: TextStyle(
                                color: white,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.width / 24),
                            textAlign: TextAlign.center),
                        Text('We need at least \$10 per members to join us !',
                            style: TextStyle(
                                color: lightwhite,
                                fontWeight: FontWeight.w600,
                                fontSize:
                                    MediaQuery.of(context).size.width / 30),
                            textAlign: TextAlign.center),
                      ],
                    )),
              ),
            ])));
  }
}
