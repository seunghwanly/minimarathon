import 'package:flutter/material.dart';
import 'package:minimarathon/component/body/relay/relay_start.dart';
import 'package:minimarathon/component/route_page.dart';
// util
import 'package:minimarathon/util/custom_dialog.dart';
import 'package:minimarathon/util/palette.dart';
import 'package:minimarathon/util/paypal/paypal_payment.dart';
//component
import '../../header/header.dart';
import 'package:minimarathon/component/body/register/result_register.dart';
import 'package:minimarathon/component/loading.dart';
// firebase
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
// model
import '../../../model/model_register.dart';

final databaseReference =
    FirebaseDatabase.instance.reference().child('2020HopeRelay');

class SingleRegister extends StatefulWidget {
  final title;
  final isoCode;

  SingleRegister({this.title, this.isoCode});

  @override
  _SingleRegisterState createState() => _SingleRegisterState();
}

class _SingleRegisterState extends State<SingleRegister> {
  // text edit focus node
  FocusNode focusName = FocusNode();
  FocusNode focusPhoneNumber = FocusNode();
  FocusNode focusFee = FocusNode();

  // Scroll controller
  ScrollController _scrollController = new ScrollController();

  // Firebase Auth
  User user = FirebaseAuth.instance.currentUser;

  final _formKey = GlobalKey<FormState>(); //form

  Single singleRegisterData = new Single();

  bool isPaymentAvailable = false;
  bool isRegisterAvailable = false;
  bool isPaymentFinished = false;

  @override
  Widget build(BuildContext context) {
    return CustomHeader(
      title: widget.title,
      body: registerBody(),
    );
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  void _navigation() async {

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            // builder: (context) => RelayStart(
            //       isLeader: false,
            //       isTeam: false,
            //       ismember: false,
            //       username: singleRegisterData.name,
            //       teamname: "",
            //     )
            builder: (context) => RoutePage(telephonecode: widget.isoCode,),
                )
                );
    await databaseReference
        .child("Single/" + user.uid)
        .set(singleRegisterData.toJson())
        .then((value) {
      print('uploaded !');
    }).catchError(() => print('error'));
  }

  @override
  void initState() {
    super.initState();
    // get user phonenumber
    singleRegisterData.name = "name";
    singleRegisterData.donationFee = 0;
    singleRegisterData.phoneNumber = user.phoneNumber;
    singleRegisterData.moreVolunteer = false;
    singleRegisterData.relay = Relay(runningDistance: 0, timer: 0);
  }

  Widget registerBody() {
    // if (!isPaymentFinished && isPaymentAvailable) {
    //   return LoadingPage();
    // } else {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          controller: _scrollController,
            child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Container(
            // color: white,
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  // ---------------------------------------------------------------------------NAME
                  flex: 2,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Name",
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
                                hintText: "Enter name",
                                hintStyle: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                                labelText: '  ${singleRegisterData.name}',
                                labelStyle: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                              style: TextStyle(color: lightwhite),
                              onChanged: (name) {
                                setState(() {
                                  singleRegisterData.name = name;
                                });
                              },
                              textInputAction: TextInputAction.next,
                              focusNode: focusName,
                              onEditingComplete: () =>
                                  FocusScope.of(context).requestFocus(focusFee),
                              cursorWidth: 4.0,
                            ))
                      ],
                    ),
                  ),
                ),
                Expanded(
                  // ---------------------------------------------------------------------------Phone Number
                  flex: 2,
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Phone Number",
                              style: TextStyle(
                                  color: lightwhite,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            ),
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              padding: EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 20.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: mandarin,
                                border: Border.all(color: mandarin, width: 3),
                              ),
                              child: Text(singleRegisterData.phoneNumber,
                                  style: TextStyle(
                                      color: white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600)))
                        ],
                      )),
                ),
                // Expanded(
                //   // ---------------------------------------------------------------------------Donation Fee
                //   flex: 5,
                //   child: Container(
                //       width: MediaQuery.of(context).size.width * 0.7,
                //       child: Column(
                //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //         children: [
                //           Container(
                //             alignment: Alignment.centerLeft,
                //             child: Text(
                //               "Donation Fee",
                //               style: TextStyle(
                //                   color: lightwhite,
                //                   fontWeight: FontWeight.bold,
                //                   fontSize: 20.0),
                //             ),
                //           ),
                //           Container(
                //               width: MediaQuery.of(context).size.width * 0.7,
                //               child: TextField(
                //                 decoration: InputDecoration(
                //                   focusedBorder: OutlineInputBorder(
                //                       borderRadius: BorderRadius.circular(30),
                //                       borderSide:
                //                           BorderSide(color: white, width: 3)),
                //                   enabledBorder: OutlineInputBorder(
                //                       borderRadius: BorderRadius.circular(30),
                //                       borderSide: new BorderSide(
                //                           color: lightwhite, width: 3)),
                //                   hintText: "10",
                //                   hintStyle: TextStyle(
                //                       color: Colors.white54,
                //                       fontSize: 18,
                //                       fontWeight: FontWeight.w500),
                //                   prefixText: "\$",
                //                   labelText:
                //                       '  \$${singleRegisterData.donationFee}',
                //                   labelStyle: TextStyle(
                //                       color: Colors.white54,
                //                       fontSize: 18,
                //                       fontWeight: FontWeight.w500),
                //                 ),
                //                 style: TextStyle(color: lightwhite),
                //                 onChanged: (value) {
                //                   setState(() {
                //                     singleRegisterData.donationFee =
                //                         int.parse(value);
                //                   });
                //                 },
                //                 textInputAction: TextInputAction.done,
                //                 focusNode: focusFee,
                //                 keyboardType: TextInputType.number,
                //                 cursorWidth: 4.0,
                //               )),
                //           Container(
                //             alignment: Alignment.center,
                //             padding: EdgeInsets.symmetric(
                //                 horizontal: 15.0, vertical: 5.0),
                //             decoration: BoxDecoration(
                //                 borderRadius: BorderRadius.circular(30.0),
                //                 color: !isRegisterAvailable
                //                     ? mandarin
                //                     : Colors.green[400]),
                //             child: Text(
                //               !isRegisterAvailable
                //                   ? "You can donate from \$10."
                //                   : "You have successfully completed your donation!",
                //               style: TextStyle(
                //                   color: white,
                //                   fontWeight: FontWeight.w600,
                //                   fontSize: 16.0),
                //             ),
                //           ),
                //         ],
                //       )),
                // ),
                // Expanded(
                //   flex: 2,
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
                        if (!isRegisterAvailable) {
                          if (singleRegisterData.name != '' &&
                              singleRegisterData.name !=
                                  "name") {
                            setState(() {
                              isRegisterAvailable = true;
                            });
                          } else {
                            showMyDialog(context,
                                'The form is not Completely finished !');
                            setState(() {
                              isRegisterAvailable = false;
                            });
                          }
                          //   if (isPaymentAvailable) {
                          //     print(singleRegisterData.toJson().isEmpty);
                          //     // make PayPal payment
                          //     Navigator.of(context).push(
                          //       MaterialPageRoute(
                          //         builder: (BuildContext c) => PaypalPayment(
                          //           //------------------------------------------------- send to PaypalPayment config
                          //           donor: singleRegisterData.name,
                          //           donorPhoneNumber:
                          //               singleRegisterData.phoneNumber,
                          //           donationFee: singleRegisterData.donationFee,
                          //           onFinish: (res) async {
                          //             setState(() {
                          //               isPaymentFinished = true;
                          //             });
                          //             // payment done
                          //             if (res == 'approved') {
                          //               setState(() {
                          //                 isRegisterAvailable = true;
                          //                 isPaymentAvailable = false;
                          //               });
                          //               print('> R : ' +
                          //                   isRegisterAvailable.toString() +
                          //                   ' P : ' +
                          //                   isPaymentAvailable.toString());

                          //               await databaseReference
                          //                   .child("Single/" + user.uid)
                          //                   .set(singleRegisterData.toJson())
                          //                   .then((value) {
                          //                 print('uploaded !');
                          //               }).catchError(() => print('error'));
                          //               databaseReference
                          //                   .once()
                          //                   .then((DataSnapshot snapshot) {
                          //                 print('Data : ${snapshot.value}');
                          //               });

                          //               await showMyDialog(context,
                          //                   "Payment was succefully done !\n You are now avaiable to register !");
                          //             } else {
                          //               showMyDialog(context,
                          //                   'Payment was not Completed !');
                          //             }
                          //           },
                          //         ),
                          //       ),
                          //     );
                          //   }
                          // } else {
                          // if (isRegisterAvailable && !isPaymentAvailable) {
                          if (isRegisterAvailable) { _navigation(); }
                        }
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      color: royalblue,
                      child: Container(
                          width: double.infinity,
                          // height: MediaQuery.of(context).size.width * 0.2,
                          alignment: Alignment.center,
                          child: Text('REGISTER',
                              style: TextStyle(
                                  color: white,
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      MediaQuery.of(context).size.width / 16),
                              textAlign: TextAlign.center)),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: SizedBox(),
                ),
              ],
            ),
          ),
        )));
  }
  // }
}
