import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minimarathon/component/body/register/result_register.dart';
import 'package:minimarathon/component/loading.dart';
import 'package:minimarathon/util/custom_dialog.dart';
import 'package:minimarathon/util/palette.dart';
import 'package:minimarathon/util/paypal/paypal_model.dart';
import 'package:minimarathon/util/paypal/paypal_payment.dart';

//component
import '../../header/header.dart';
import 'package:firebase_database/firebase_database.dart';

final databaseReference = FirebaseDatabase.instance.reference();

class SingleRegister extends StatefulWidget {
  final title;

  SingleRegister({this.title});

  @override
  _SingleRegisterState createState() => _SingleRegisterState();
}

class _SingleRegisterState extends State<SingleRegister> {
  FocusNode focusName = FocusNode();
  FocusNode focusPhoneNumber = FocusNode();
  FocusNode focusFee = FocusNode();

  final _formKey = GlobalKey<FormState>(); //form

  // TODO : 로그인 된 핸드폰 번호로 초기화 하기
  Map<String, dynamic> singleRegisterData = {
    "name": "  Please type your name . . .",
    "phoneNumber": "  Please type your phonenumber . . .",
    // "phoneNumber": firebase.auth().currentUser.phonenumber 사실 함수 잘 모름 예시임
    "donationFee": 10
  };

  bool isPaymentAvailable = false;
  bool isRegisterAvailable = false;

  @override
  Widget build(BuildContext context) {
    return CustomHeader(
      title: widget.title,
      body: isPaymentAvailable && !isRegisterAvailable
          ? LoadingPage()
          : registerBody(),
    );
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Firebase.initializeApp().whenComplete(() {
    //   print("completed");
    //   setState(() {});

    // });
  }

  Widget registerBody() {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
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
                                labelText: '  ${singleRegisterData['name']}',
                                labelStyle: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                              style: TextStyle(color: lightwhite),
                              onChanged: (name) {
                                setState(() {
                                  singleRegisterData['name'] = name;
                                });
                              },
                              textInputAction: TextInputAction.next,
                              focusNode: focusName,
                              onEditingComplete: () => FocusScope.of(context)
                                  .requestFocus(focusPhoneNumber),
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
                                  labelText:
                                      '  ${singleRegisterData['phoneNumber']}',
                                  labelStyle: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                                style: TextStyle(color: lightwhite),
                                onChanged: (text) {
                                  setState(() {
                                    singleRegisterData['phoneNumber'] = text;
                                  });
                                },
                                keyboardType: TextInputType.phone,
                                textInputAction: TextInputAction.next,
                                focusNode: focusPhoneNumber,
                                onEditingComplete: () => FocusScope.of(context)
                                    .requestFocus(focusFee),
                                cursorWidth: 4.0,
                              ))
                        ],
                      )),
                ),
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
                                  labelText:
                                      '  \$${singleRegisterData['donationFee']}',
                                  labelStyle: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                                style: TextStyle(color: lightwhite),
                                onChanged: (value) {
                                  setState(() {
                                    singleRegisterData['donationFee'] =
                                        int.parse(value);
                                  });
                                },
                                textInputAction: TextInputAction.done,
                                focusNode: focusFee,
                                keyboardType: TextInputType.number,
                                cursorWidth: 4.0,
                              )),
                          Container(
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
                                  ? "You can donate from \$10."
                                  : "You have successfully completed your donation!",
                              style: TextStyle(
                                  color: white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18.0),
                            ),
                          ),
                        ],
                      )),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                      // child: Text(singleRegisterData.toString() +  // for debugging
                      //     ' ' +
                      //     (singleRegisterData['donationFee'] is int).toString()),
                      ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: FlatButton(
                      onPressed: () {
                        print(isPaymentAvailable.toString() +
                            '\t' +
                            isRegisterAvailable.toString());
                        if (!isRegisterAvailable) {
                          if (singleRegisterData['donationFee'] >= 10 &&
                              singleRegisterData['name'] != '' &&
                              singleRegisterData['name'] !=
                                  "  Please type your name . . ." &&
                              singleRegisterData['phoneNumber'] != '' &&
                              singleRegisterData['phoneNumber'] !=
                                  "  Please type your phonenumber . . .") {
                            setState(() {
                              isPaymentAvailable = true;
                            });
                          } else {
                            showMyDialog(context,
                                'The form is not Completely finished !');
                            setState(() {
                              isPaymentAvailable = false;
                            });
                          }
                          if (isPaymentAvailable) {
                            // make PayPal payment

                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext c) => PaypalPayment(
                                  donationFee:
                                      singleRegisterData['donationFee'],
                                  onFinish: (res) async {
                                    print('> : single_register.dart :- \t' +
                                        res.toString());
                                    // payment done
                                    if (res == 'approved') {
                                      setState(() {
                                        isRegisterAvailable = true;
                                        isPaymentAvailable = false;
                                      });
                                      print('> R : ' +
                                          isRegisterAvailable.toString() +
                                          ' P : ' +
                                          isPaymentAvailable.toString());

                                      databaseReference
                                          .child("single")
                                          .child(FirebaseAuth.instance.currentUser.uid)
                                          .set({'isPaid': true});
                                      databaseReference
                                          .once()
                                          .then((DataSnapshot snapshot) {
                                        print('Data : ${snapshot.value}');
                                      });

                                      await showMyDialog(context,
                                          "Payment was succefully done !\n You are now avaiable to register !");
                                    } else {
                                      showMyDialog(context,
                                          'Payment was not Completed !');
                                    }
                                  },
                                ),
                              ),
                            );
                          }
                        } else {
                          if (isRegisterAvailable && !isPaymentAvailable) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Register()));
                          }
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
                          child: Text(
                              !isRegisterAvailable
                                  ? 'Pay by PAYPAL'
                                  : 'REGISTER',
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
                  flex: 2,
                  child: SizedBox(),
                ),
              ],
            ),
          ),
        )));
  }
}
