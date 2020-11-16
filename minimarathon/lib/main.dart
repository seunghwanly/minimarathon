import 'package:flutter/material.dart';
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
          primaryColor: Colors.white,
        ),
        home: CustomHeader(
          title: Text(''),
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
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          padding: EdgeInsets.all(20.0),
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        '2020 Hope Sharing Relay',
                        style: TextStyle(
                            color: Colors.grey[850],
                            fontWeight: FontWeight.w500,
                            fontSize: 20),
                      ),
                      width: MediaQuery.of(context).size.width * 0.7,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text("Let's Run & Share",
                          style: TextStyle(
                              color: Colors.grey[900],
                              fontWeight: FontWeight.bold,
                              fontSize: 22)),
                      width: MediaQuery.of(context).size.width * 0.7,
                    ),
                  ],
                ),
              ),
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
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: lightgrey)),
                            labelText: 'Phone number',
                            labelStyle: TextStyle(
                                color: lightgrey,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
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
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(color: mandarin, width: 3.0)),
                            child: Container(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.width * 0.2,
                              alignment: Alignment.center,
                              child: Text(
                                'LOGIN',
                                style: TextStyle(
                                    color: mandarin,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 26.0),
                              ),
                            )))
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Divider(
                  thickness: 2.0,
                  color: lightgrey,
                ),
              ),
              Expanded(
                // ---------------------------------------------------------------------------REGISTER
                flex: 4,
                child: Column(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width * 0.7,
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
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(color: orange, width: 3.0)),
                            child: Container(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.width * 0.2,
                              alignment: Alignment.center,
                              child: Text(
                                'Single REGISTER',
                                style: TextStyle(
                                    color: orange,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 26.0),
                              ),
                            ))),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: FlatButton(
                            onPressed: () {
                              // ** 개발상 편의를 위해 팀 Register 버튼 -> Start Relay 로 이동으로 변경
                              // 2020-11-17

                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (BuildContext context) =>
                              //           TeamRegister(
                              //         title: Text("Register"),
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
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(color: orange, width: 3.0)),
                            child: Container(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.width * 0.2,
                              alignment: Alignment.center,
                              child: Text(
                                'Team REGISTER',
                                style: TextStyle(
                                    color: orange,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 26.0),
                              ),
                            )))
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
