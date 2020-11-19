import 'package:flutter/material.dart';
import 'package:minimarathon/util/custom_container.dart';
//header
import './component/header/header.dart';
//util
import './util/palette.dart';
import './util/custom_dialog.dart';
//route
import 'package:minimarathon/component/body/register/single_register.dart';
import 'package:minimarathon/component/body/register/team_register.dart';
import 'package:minimarathon/component/body/relay/relay_start.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
          ),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime serviceStateDate = new DateTime.utc(2020, 12, 10);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  isOpenned(BuildContext context) {
    if (serviceStateDate.compareTo(DateTime.now()) != 0) {
      //begin service
    } else {
      showMyDialog(
          context, "You can't use this application before the marathon starts");
    }
  }

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
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage('images/home.png'),
                      fit: BoxFit.cover,
                      // colorFilter: ColorFilter.mode(
                      //     Colors.black.withOpacity(0.3), BlendMode.darken),
                    )),
                  )),
              Expanded(
                // ---------------------------------------------------------------------------LOGIN
                flex: 3,
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
                          style: TextStyle(color: lightwhite),
                          onChanged: (value) {},
                          cursorWidth: 4.0,
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: FlatButton(
                            onPressed: () {
                              showMyDialog(context,
                                  "You can't use this application before the marathon starts");
                              // isOpenned(context);
                            },
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
              // Expanded(
              //   flex: 1,
              //   child: Divider(
              //     thickness: 2.0,
              //     color: lightwhite,
              //   ),
              // ),
              Expanded(
                // ---------------------------------------------------------------------------REGISTER
                flex: 2,
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
                                            title: Text("Register"),
                                          )));
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            color: royalblue,
                            child: Container(
                                width: double.infinity,
                                height: MediaQuery.of(context).size.width * 0.2,
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
                                              16),
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

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        TeamRegister(
                                      title: Text("Register"),
                                    ),
                                  ));

                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (BuildContext context) =>
                              //         RelayStart(),
                              //   ),
                              // );
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            color: royalblue,
                            child: Container(
                                width: double.infinity,
                                height: MediaQuery.of(context).size.width * 0.2,
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
                                              16),
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
                                ))))
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
