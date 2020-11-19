import 'package:flutter/material.dart';
import 'package:minimarathon/component/header/header.dart';
import 'relay_start.dart';
import '../../../util/palette.dart';
import '../../../util/text_style.dart';
import 'ranking.dart';
import 'package:firebase_database/firebase_database.dart';
final databaseReference = FirebaseDatabase.instance.reference();
class RelayFinish extends StatefulWidget {
  @override
  RelayFinishState createState() => RelayFinishState();
}

class RelayFinishState extends State<RelayFinish> {
  final String username = 'Jong Ha Park';

  void _navigationMore() {
    Navigator.pop(context);
  }

  void _navigationRanking() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => Ranking(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomHeader(
        title: Text("Finish Marathon"),
        body: new Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    makeText("2020 Hope Sharing Relay", white, 21),
                    makeText("Let's Run & Share", white, 21),
                  ],
                ),
              ),
              Expanded(flex: 1, child: Container(child: Text(''))),
              Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        // height:  MediaQuery.of(context).size.height * 0.8,
                        //margin: EdgeInsets.symmetric(vertical: 10),
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                            color: mandarin,
                            border: Border.all(color: lightwhite, width: 3),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Column(children: [
                          makeTextThin("Congratulations,", Colors.white, 20),
                          makeTextThin("Jong ha Park" + '!', Colors.white, 20),
                          makeTwoColor("You walked ", "3.2km !", Colors.white,
                              Colors.white, 20),
                        ]))
                  ],
                ),
              ),
              Expanded(flex: 1, child: Container(child: Text(''))),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    makeTwoColor(
                        "We certified ", "4 hours", Colors.white70, white, 20),
                    // makeTextSemiThin(
                    //     "We certified 4 hours", Colors.white70, 20),
                    makeTextSemiThin("volunteer work for", Colors.white70, 20),
                    makeTextSemiThin("Hope Sharing Relay", Colors.white70, 20),
                  ],
                ),
              ),
              Expanded(flex: 1, child: Container(child: Text(''))),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    makeTextSemiThin(
                        "American Korean United Foundation", Colors.white, 15),
                  ],
                ),
              ),
              Expanded(flex: 1, child: Container(child: Text(''))),
              Expanded(
                  flex: 3,
                  child: Container(
                    // height:  MediaQuery.of(context).size.height * 0.8,
                    //margin: EdgeInsets.symmetric(vertical: 10),
                    width: MediaQuery.of(context).size.width * 0.8,

                    decoration: BoxDecoration(
                        color: mandarin,
                        border: Border.all(color: lightwhite, width: 3),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: FlatButton(
                      //onPressed: _navigationMore,
                      onPressed: (){
                        //번호 가져오기 해야됨!!!
                        databaseReference.child('1-260-123-4567').update({
                          'More': 'T'
                        });
                    },
                      child: Container(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          makeTextSemiThin('More Volunteer', white, 25),
                          makeTextSemiThin('Opportunities', white, 25),
                        ],
                      )),
                    ),
                  )),
              Expanded(flex: 1, child: Container(child: Text(''))),
              Expanded(
                  flex: 2,
                  child: Container(
                    // height:  MediaQuery.of(context).size.height * 0.8,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                        border: Border.all(color: lightwhite, width: 3),
                        color: mandarin,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: FlatButton(
                      onPressed: _navigationRanking,
                      child: Container(
                        child: makeTextSemiThin('Show Ranking', lightwhite, 26),
                      ),
                    ),
                  )),
              Expanded(flex: 2, child: Container(child: Text(''))),
            ],
          ),
        ));
  }
}
