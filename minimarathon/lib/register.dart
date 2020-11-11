import 'package:flutter/material.dart';
import 'textStyle.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'relay_start.dart';

class Register extends StatefulWidget {
  @override
  RegisterState createState() => RegisterState();
}

class RegisterState extends State<Register> {
  final String username = 'Jong Ha Park';

  void _navigation() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => RelayStart(),
      ),
    );
  }

  _launchURL() async {
    const url = 'https://naver.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Scaffold(
          appBar: new AppBar(
            title: Text("Register"),
          ),
          body: new Center(
            child: Column(
              children: [
                Expanded(
                  flex: 6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      makeText('The Registation', Colors.black54, 23),
                      makeText('Successfully Completed!', Colors.black54, 23),
                      makeText(
                          'Thank you for your sharing !', Colors.black54, 21),
                      makeText(username + '.', Colors.black54, 24),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      makeText('You can use this app', Colors.black54, 23),
                      makeText('from December 10th.', Colors.black54, 23),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      makeTextUnderLine(
                          'Copy App Download Link', Colors.lightBlue, 22),
                    ],
                  ),
                ),
                Expanded(
                    flex: 4,
                    child: Container(
                      child: FlatButton(
                        color: Colors.black26,
                        onPressed: _navigation,
                        child: Container(
                          child: makeText(
                              'Mini Marathon Start ! !', Colors.black87, 26),
                        ),
                      ),
                    )),
              ],
            ),
          )),
    );
  }
}
