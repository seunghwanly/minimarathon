import 'package:flutter/material.dart';
//header
import './component/header/header.dart';
//util
import './util/palette.dart';
//route
import 'package:minimarathon/component/body/register/single_register.dart';
import 'package:minimarathon/component/body/register/team_register.dart';

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
      showMyDialog(context);
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
                            fontSize: 22),
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
                              showMyDialog(context);
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        TeamRegister(
                                      title: Text("Register"),
                                    ),
                                  ));
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

showMyDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
          elevation: 16.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.width * 0.5,
            padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 6,
                  child: Text(
                    "You can't use this application before the marathon starts",
                    style: TextStyle(
                        color: darkgrey,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(flex: 2, child: Divider()),
                Expanded(
                  flex: 2,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'OK',
                      style: TextStyle(
                          color: Colors.blue[400],
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                  ),
                ),
              ],
            ),
          ));
    },
  );
}
