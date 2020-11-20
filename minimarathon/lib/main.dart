//firebase
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
// amaterial
import 'package:flutter/material.dart';
import 'package:minimarathon/component/body/register/need_payment_register.dart';
//route
import 'package:minimarathon/component/body/register/single_register.dart';
import 'package:minimarathon/component/body/register/team_register.dart';
import 'package:minimarathon/component/body/relay/relay_start.dart';
import 'package:minimarathon/component/loading.dart';
import 'package:minimarathon/util/custom_container.dart';

//header
import './component/header/header.dart';
import './util/custom_dialog.dart';
//util
import './util/palette.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
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
                    // child: LoginScreen(),
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

  String phoneNumber;

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
                        child: TextField(
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: white, width: 3)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: new BorderSide(
                                    color: lightwhite, width: 3)),
                            labelText: '  Phone number',
                            labelStyle: TextStyle(
                                color: lightwhite,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                          keyboardType: TextInputType.phone,
                          style: TextStyle(color: lightwhite),
                          onChanged: (value) {
                            setState(() {
                              phoneNumber = value;
                            });
                          },
                          cursorWidth: 4.0,
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
  void initState() {
    super.initState();
  }

  isOpenned(BuildContext context) {
    if (serviceStateDate.compareTo(DateTime.now()) != 0) {
      //begin service
    } else {
      showMyDialog(
          context, "You can't use this application before the marathon starts");
    }
  }

  /////////////////////////////////////////////////////////////////////////////////////////////////////
  // login with firebase
  Future loginUser(BuildContext context) async {
    print("login user " + this.phoneNumber);
    _auth.verifyPhoneNumber(
        timeout: Duration(seconds: 10),
        /////////////////////////////////////////////////////////////////////////////////////////////////////
        // 한국
        //phoneNumber: '+82'+this.phoneNumber,
        // 체코
        phoneNumber: '+420'+this.phoneNumber,
        /////////////////////////////////////////////////////////////////////////////////////////////////////
        verificationCompleted: (PhoneAuthCredential authCredential) {
          _auth.signInWithCredential(authCredential).then((value) {
            if (value.user != null) {
              // LOGIN FINISHED
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => NeedPaymentRegister()));
            
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
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(30),
                          topRight: const Radius.circular(30))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: TextField(
                            controller: _codeController,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide:
                                      BorderSide(color: lightgrey, width: 3)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: new BorderSide(
                                      color: lightgrey, width: 3)),
                              labelText: '  SMS CODE',
                              labelStyle: TextStyle(
                                  color: lightgrey,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                          )),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: FlatButton(
                              onPressed: () {
                                // Create a PhoneAuthCredential with the code
                                final code = _codeController.text.trim();
                                var phoneAuthCredential =
                                    PhoneAuthProvider.credential(
                                        verificationId: verificationId,
                                        smsCode: code);
                                _auth
                                    .signInWithCredential(phoneAuthCredential)
                                    .then((value) {
                                  if (value.user != null) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                NeedPaymentRegister()));
                                  } else {
                                    print("Error");
                                  }
                                });
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              color: mandarin,
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.width * 0.15,
                                alignment: Alignment.center,
                                child: Text(
                                  'SIGN-IN',
                                  style: TextStyle(
                                      color: white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22.0),
                                ),
                              )))
                    ],
                  ),
                );
              },
              backgroundColor: Color(0x00000000));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationId = verificationId;
        });
  }
}
