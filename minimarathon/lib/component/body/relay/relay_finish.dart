import 'package:flutter/material.dart';
import 'package:minimarathon/component/header/header.dart';
import 'relay_start.dart';
import '../../../util/text_style.dart';
import 'ranking.dart';

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
                    makeText("2020 Hope Sharing Relay", Colors.black54, 20),
                    makeText("Let's Run & Share", Colors.black87, 20),
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
                            color: Color.fromRGBO(234, 85, 24, 1.0),
                            border: Border.all(
                                color: Color.fromRGBO(234, 85, 24, 1.0),
                                width: 3),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Column(children: [
                          makeText("Congratulations,", Colors.white, 20),
                          makeText("Jong ha Park" + '!', Colors.white, 20),
                          makeTextSemiThin(
                              "You walked 3.2km !", Colors.white, 18),
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
                    makeTextSemiThin(
                        "We certified 4 hours", Colors.black54, 20),
                    makeTextSemiThin("volunteer work for", Colors.black54, 20),
                    makeTextSemiThin("Hope Sharing Relay", Colors.black54, 20),
                  ],
                ),
              ),
              Expanded(flex: 1, child: Container(child: Text(''))),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    makeTextSemiThin("American Korean United Foundation",
                        Colors.black54, 15),
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
                        border: Border.all(
                            color: Color.fromRGBO(234, 85, 24, 1.0), width: 3),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: FlatButton(
                      onPressed: _navigationMore,
                      child: Container(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          makeTextThin('More Volunteer',
                              Color.fromRGBO(234, 85, 24, 1.0), 25),
                          makeTextThin('Opportunities',
                              Color.fromRGBO(234, 85, 24, 1.0), 25),
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
                        border: Border.all(
                            color: Color.fromRGBO(218, 155, 104, 1.0),
                            width: 3),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: FlatButton(
                      onPressed: _navigationRanking,
                      child: Container(
                        child: makeTextSemiThin('Show Ranking',
                            Color.fromRGBO(218, 155, 104, 1.0), 26),
                      ),
                    ),
                  )),
              Expanded(flex: 2, child: Container(child: Text(''))),
            ],
          ),
        ));
  }
}
