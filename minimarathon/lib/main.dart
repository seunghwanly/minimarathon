import 'dart:async';
import 'package:flutter/foundation.dart' show kDebugMode;

//firebase
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
// material
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:flutter/services.dart';
import 'dart:io';
//route
import 'package:minimarathon/component/body/register/need_payment_register.dart';
import 'package:minimarathon/component/body/relay/relay_start.dart';
import 'package:minimarathon/component/loading.dart';
import 'package:minimarathon/util/custom_container.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
//header
import './component/header/header.dart';
import './util/custom_dialog.dart';
//util
import 'package:international_phone_input/international_phone_input.dart';
import './util/palette.dart';

void main() async {
  //send errors
  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  // initialize App
  WidgetsFlutterBinding.ensureInitialized();

  if (kDebugMode) {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
    runApp(MyApp());
  } else {
    runZonedGuarded<Future<void>>(() async {
      runApp(MyApp());
    }, FirebaseCrashlytics.instance.recordError);
  }
}

class MyApp extends StatelessWidget {
  //firebase init
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        //initialize Firebase App()
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
                theme: ThemeData(
                    // primaryColor: Colors.white,
                    ),
                home: CustomHeader(
                  title: "",
                  body: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                    },
                    child: MyHomePage(),
                    // child: TeamRegister(),
                  ),
                ));
          }
          if (snapshot.hasError) {
            return Text("Firebase initalize error !");
          }
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: LoadingPage(),
              ),
            ),
          );
        });
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //firebase auth
  FirebaseAuth _auth = FirebaseAuth.instance;
  // user authentication
  DateTime serviceStateDate = new DateTime.utc(2020, 12, 10);
  DatabaseReference readDatabaseReference =
      FirebaseDatabase.instance.reference();
  // user State
  User user = FirebaseAuth.instance.currentUser;
  bool isPaidUser = false;
  bool isTeam = false;
  bool isLeader = false;
  bool ismember = false;

  String username = '';
  String teamname = '';
  // focus Node
  FocusNode smsCode = new FocusNode();

  // for login
  String phoneNumber;
  String phoneIsoCode = "+82";
  String phoneInternationalNumber;

  void isPaidCheck() {
    print('실행');

    // check Single User isPaid
    readDatabaseReference
        .child('Single')
        .child(user.uid)
        .once()
        .then((DataSnapshot dataSnapshot) {
      Map<dynamic, dynamic> values = dataSnapshot.value;
      setState(() {
        username = values['name'];
        isPaidUser = true;
      });
    });
    // check Team User isPaid
    readDatabaseReference
        .child('Teams')
        .once()
        .then((DataSnapshot dataSnapshot) {
      Map<dynamic, dynamic> values = dataSnapshot.value;
      values.forEach((key, value) {
        // check Leader
        readDatabaseReference
            .child('Teams')
            .child(key)
            .child('leader')
            .child('phoneNumber')
            .once()
            .then((DataSnapshot dataSnapshot) {
          if (dataSnapshot.value.toString() == user.phoneNumber) {
            readDatabaseReference
                .child('Teams')
                .child(key)
                .child('leader')
                .child('name')
                .once()
                .then((DataSnapshot dataSnapshot) {
              setState(() {
                isTeam = true;
                isLeader = true;
                isPaidUser = true;
                teamname = key.toString();
                username = dataSnapshot.value.toString();
              });
              return;
            });
          }
        });

        // check Member
        readDatabaseReference
            .child('Teams')
            .child(key)
            .child('members')
            .once()
            .then((DataSnapshot dataSnapshot) {
          List<dynamic> values = dataSnapshot.value;
          for (var i = 0; i < values.length; i++) {
            if (values[i]['phoneNumber'] == user.phoneNumber) {
              print('팀명 : ' + key.toString());
              setState(() {
                username = values[i]['name'];
                isTeam = true;
                ismember = true;
                teamname = key.toString();
                isPaidUser = true;
              });
              return;
            }
          }
        });
      });
    });
  }

  //phone number
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        controller: new ScrollController(
            initialScrollOffset: MediaQuery.of(context).size.height),
        child: Container(
          padding: EdgeInsets.all(20.0),
          // color: Colors.white,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: Image(
                  image: AssetImage('images/home.png'),
                  fit: BoxFit.contain,
                ),
              ),
              Expanded(
                // ---------------------------------------------------------------------------LOGIN
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: white),
                        child: InternationalPhoneInput(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: '  Phone number',
                            labelStyle: TextStyle(
                                color: lightgrey,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                          onPhoneNumberChange: onPhoneNumberChange,
                          initialPhoneNumber: phoneNumber,
                          initialSelection: phoneIsoCode,
                          enabledCountries: ['+82', '+1', '+420'],
                          showCountryCodes: false,
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: RaisedButton(
                            // onPressed: () async {
                            //   // showMyDialog(context,
                            //   //     "You can't use this application before the marathon starts");

                            //   // Navigator.of(context).push(MaterialPageRoute(
                            //   //     builder: (context) => NeedPaymentRegister()));
                            // },
                            onPressed: () => loginUser(context),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              // side: BorderSide(color: mandarin, width: 3.0)
                            ),
                            color: mandarin,
                            child: Container(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.width * 0.2,
                              alignment: Alignment.center,
                              child: Text(
                                'LOGIN',
                                style: TextStyle(
                                    color: white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 26.0),
                              ),
                            )))
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    readDatabaseReference.onDisconnect();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    isPaidCheck();
  }

  Widget loading() {
    // widget.onFinish(widget.res);

    return Container(
        child: LoadingBouncingGrid.circle(
      borderColor: orange,
      size: 50.0,
      backgroundColor: Colors.transparent,
      duration: Duration(milliseconds: 5000),
    ));
  }

  isOpenned(BuildContext context) {
    if (serviceStateDate.compareTo(DateTime.now()) != 0) {
      //begin service
    } else {
      showMyDialog(
          context, "You can't use this application before the marathon starts");
    }
  }

  void onPhoneNumberChange(
      String number, String internationalizedPhoneNumber, String isoCode) {
    setState(() {
      phoneNumber = number;
      phoneIsoCode = isoCode;
      phoneInternationalNumber = internationalizedPhoneNumber;
    });
    print(internationalizedPhoneNumber);
  }

  /////////////////////////////////////////////////////////////////////////////////////////////////////
  // login with firebase
  Future loginUser(BuildContext context) async {
    print("login user " + this.phoneInternationalNumber);
    _auth.verifyPhoneNumber(
        timeout: Duration(seconds: 10),
        /////////////////////////////////////////////////////////////////////////////////////////////////////
        phoneNumber: this.phoneInternationalNumber,
        /////////////////////////////////////////////////////////////////////////////////////////////////////
        verificationCompleted: (PhoneAuthCredential authCredential) {
          _auth.signInWithCredential(authCredential).then((value) {
            if (value.user != null) {
              // LOGIN FINISHED
              isPaidCheck();

              sleep(const Duration(seconds: 2));
              if (isPaidUser == true) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RelayStart(
                              isLeader: isLeader,
                              isTeam: isTeam,
                              ismember: ismember,
                              username: username,
                              teamname: teamname,
                            )));
              } else {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => NeedPaymentRegister()));
              }
            } else
              print("login error");
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            print('The provided phone number is not valid.');
          }
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          final _codeController = TextEditingController();
          /////////////////////////////////////////////////////////////////////////////////////////////////////
          ///TODO : 꾸미기
          /////////////////////////////////////////////////////////////////////////////////////////////////////
          showModalBottomSheet(
              isDismissible: true,
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                    },
                    child: SingleChildScrollView(
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.7,
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: const Radius.circular(30),
                                      topRight: const Radius.circular(30))),
                              child: Column(
                                children: [
                                  Expanded(flex: 1, child: SizedBox()),
                                  Expanded(
                                      flex: 2,
                                      child: Container(
                                          alignment: Alignment.center,
                                          child: Column(
                                            children: [
                                              Text('Phone Number Verification',
                                                  style: TextStyle(
                                                      color: darkblue,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              18)),
                                              RichText(
                                                  textAlign: TextAlign.center,
                                                  text: TextSpan(children: [
                                                    TextSpan(
                                                        text:
                                                            "Enter the code send to ",
                                                        style: TextStyle(
                                                            color: lightgrey,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                24)),
                                                    TextSpan(
                                                        text: this
                                                            .phoneInternationalNumber,
                                                        style: TextStyle(
                                                            color: darkblue,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                20))
                                                  ]))
                                            ],
                                          ))),
                                  Expanded(
                                      flex: 3,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        child: PinCodeTextField(
                                          cursorColor: Colors.black,
                                          appContext: context,
                                          controller: _codeController,
                                          autoDismissKeyboard: true,
                                          length: 6,
                                          pinTheme: PinTheme(
                                              shape: PinCodeFieldShape.box,
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              fieldHeight:
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.16,
                                              fieldWidth: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.107,
                                              activeFillColor: white),
                                          backgroundColor: white,
                                          keyboardType: TextInputType.number,
                                          animationType: AnimationType.fade,
                                          pastedTextStyle: TextStyle(
                                            color: royalblue,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        // child: TextField(
                                        //   controller: _codeController,
                                        //   decoration: InputDecoration(
                                        //       focusedBorder: OutlineInputBorder(
                                        //           borderRadius: BorderRadius.circular(30),
                                        //           borderSide:
                                        //               BorderSide(color: lightgrey, width: 1)),
                                        //       enabledBorder: OutlineInputBorder(
                                        //           borderRadius: BorderRadius.circular(30),
                                        //           borderSide: new BorderSide(
                                        //               color: lightgrey, width: 1)),
                                        //       labelText: '  SMS CODE',
                                        //       labelStyle: TextStyle(
                                        //           color: lightgrey,
                                        //           fontSize: 18,
                                        //           fontWeight: FontWeight.w500),
                                        //       helperText:
                                        //           "Please enter the code sent by text message.",
                                        //       helperStyle: TextStyle(
                                        //           color: lightgrey,
                                        //           fontSize: 14.0,
                                        //           fontWeight: FontWeight.normal)),
                                        // )
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                          child: FlatButton(
                                              onPressed: () {
                                                // Create a PhoneAuthCredential with the code
                                                final code =
                                                    _codeController.text.trim();
                                                var phoneAuthCredential =
                                                    PhoneAuthProvider
                                                        .credential(
                                                            verificationId:
                                                                verificationId,
                                                            smsCode: code);
                                                _auth
                                                    .signInWithCredential(
                                                        phoneAuthCredential)
                                                    .then((value) {
                                                  if (value.user != null) {
                                                    isPaidCheck();

                                                    sleep(const Duration(
                                                        seconds: 2));
                                                    if (isPaidUser == true) {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      RelayStart(
                                                                        isLeader:
                                                                            isLeader,
                                                                        isTeam:
                                                                            isTeam,
                                                                        ismember:
                                                                            ismember,
                                                                        username:
                                                                            username,
                                                                        teamname:
                                                                            teamname,
                                                                      )));
                                                    } else {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  NeedPaymentRegister(
                                                                      isoCode:
                                                                          phoneIsoCode)));
                                                    }

                                                    // Navigator.push(
                                                    //     context,
                                                    //     MaterialPageRoute(
                                                    //         builder: (context) =>
                                                    //             NeedPaymentRegister()));
                                                  } else {
                                                    showMyDialog(context,
                                                        "SignIn Failed !");
                                                    print("Error");
                                                  }
                                                });
                                              },
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                              color: mandarin,
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.15,
                                                alignment: Alignment.center,
                                                child: Text(
                                                  'SIGN-IN',
                                                  style: TextStyle(
                                                      color: white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 22.0),
                                                ),
                                              )))),
                                  Expanded(flex: 3, child: SizedBox())
                                ],
                              ),
                            ))));
              },
              backgroundColor: Color(0x00000000));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationId = verificationId;
        });
  }
}
