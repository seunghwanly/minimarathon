import 'package:background_location/background_location.dart';
import 'package:flutter/material.dart';
import 'package:minimarathon/util/custom_dialog.dart';
import 'dart:math';
import 'dart:async';
import '../relay/relay_finish.dart';
import 'package:minimarathon/component/header/header.dart';

//firebase database
import 'package:firebase_database/firebase_database.dart';
//util
import '../../../util/palette.dart';

class MyBackgroundLocation extends StatefulWidget {
  final String teamName;
  final String userName;

  MyBackgroundLocation({this.teamName, this.userName});
  @override
  MyBackgroundLocationState createState() => MyBackgroundLocationState();
}

class MyBackgroundLocationState extends State<MyBackgroundLocation> {
  final databaseReference =
      FirebaseDatabase.instance.reference().child('2020HopeRelay');
  double beforeLat = 0;
  double beforeLong = 0;
  double currentLat = 1;
  double currentLong = 0;

  String latitude = "waiting...";
  String longitude = "waiting...";
  String altitude = "waiting...";
  String accuracy = "waiting...";
  String bearing = "waiting...";
  String speed = "0.0";
  String time = "waiting...";

  double totalDistance = 0;
  double totalDistance2 = 0;
  var date = new DateTime(1996, 5, 23, 0, 0, 0);
  Timer _timer;
  int _start = 0;
  int lastTimer = 0;
  bool isStart = false;

  String _printDuration(Duration duration) {
    if (_start == 10) {
      writeData();
    }
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  void writeData() async {
    await databaseReference
        .child("Single")
        .once()
        .then((DataSnapshot singleSnapshot) {
      var uidInfo = Map<String, dynamic>.from(singleSnapshot.value);
      uidInfo.forEach((k, v) {
        if (auth.currentUser.uid == k) {
          lastTimer = _start;
          databaseReference
              .child("Single")
              .child(k)
              .child("relay")
              .update({'timer': lastTimer, 'runningDistance': totalDistance});
        }
      });
    });
    await databaseReference
        .child("Teams")
        .once()
        .then((DataSnapshot dataSnapshot) {
      dataSnapshot.value.forEach((k, v) {
        String teamInfo = k.toString();
        Map<dynamic, dynamic> eachTeamData = v;
        eachTeamData.forEach((k, v) {
          if (k == "leader") {
            if (v['phoneNumber'] == auth.currentUser.phoneNumber) {
              lastTimer = _start;
              databaseReference
                  .child("Teams")
                  .child(teamInfo)
                  .child(k)
                  .child("relay")
                  .update(
                      {'timer': lastTimer, 'runningDistance': totalDistance});
            }
          } else if (k == "members") {
            var memberList = List<Map<dynamic, dynamic>>.from(v);
            memberList.forEach((values) {
              var eachMemberData = Map<dynamic, dynamic>.from(values);
              if (auth.currentUser.phoneNumber ==
                  eachMemberData['phoneNumber']) {
                lastTimer = _start;
                var index = memberList.indexOf(values).toString();
                databaseReference
                    .child("Teams")
                    .child(teamInfo)
                    .child(k)
                    .child(index)
                    .child("relay")
                    .update(
                        {'timer': lastTimer, 'runningDistance': totalDistance});
              }
            });
          }
        });
      });
    });
  }

  void startTimer() {
    if (isStart == true) return;
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (isStart == false) isStart = true;
          _start = _start + 1;

          // date = (new DateTime(1996,5,23, _start~/3600 ,
          //  (_start-(_start~/3600)*3600) ~/ 60 ,
          //  ((_start-(_start~/3600)*3600) ~/ 60 ) * 60
          //  );
        },
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
        title: 'Relay Start',
        body: Center(
            child: Container(
                padding:
                    EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                // color: Colors.white,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(children: [
                  Expanded(
                      flex: 7,
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: deepPastelblue,
                          ),
                          child: Container(
                            width: double.infinity,
                            // height: MediaQuery.of(context).size.width * 0.2,
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 20.0),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Expanded(
                                  //   flex: 1,
                                  //   child: SizedBox(),
                                  // ),
                                  Expanded(
                                      flex: 4,
                                      child: RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(children: <TextSpan>[
                                          TextSpan(
                                              text: "5K RUN\n",
                                              style: TextStyle(
                                                color: white,
                                                fontWeight: FontWeight.w800,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    20,
                                                letterSpacing: 2.0,
                                              )),
                                          TextSpan(
                                              text: "\nTips\n",
                                              style: TextStyle(
                                                color: superlight,
                                                decoration:
                                                    TextDecoration.underline,
                                                decorationStyle:
                                                    TextDecorationStyle.solid,
                                                fontWeight: FontWeight.bold,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    22,
                                                letterSpacing: 2.0,
                                              )),
                                          TextSpan(
                                              text: "\nUnder ",
                                              style: TextStyle(
                                                color: superlight,
                                                fontWeight: FontWeight.w600,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    26,
                                              )),
                                          TextSpan(
                                              text: "5km",
                                              style: TextStyle(
                                                color: white,
                                                backgroundColor: mandarin,
                                                fontWeight: FontWeight.bold,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    24,
                                              )),
                                          TextSpan(
                                              text:
                                                  ",the record will not be ranked !",
                                              style: TextStyle(
                                                color: superlight,
                                                fontWeight: FontWeight.w600,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    26,
                                              )),
                                          TextSpan(
                                              text: " So be aware of pressing ",
                                              style: TextStyle(
                                                color: white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    26,
                                              )),
                                          TextSpan(
                                              text: "End",
                                              style: TextStyle(
                                                color: white,
                                                backgroundColor:
                                                    Colors.green[400],
                                                fontWeight: FontWeight.w600,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    24,
                                              )),
                                        ]),
                                      )

                                      // style: TextStyle(
                                      //         color: lightwhite,
                                      //         fontWeight: FontWeight.bold,
                                      //         fontSize: MediaQuery.of(context)
                                      //                 .size
                                      //                 .width /
                                      //             20
                                      ),
                                  Expanded(
                                      flex: 2,
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '"Speed',
                                                  style: TextStyle(
                                                      color: lightwhite,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              18),
                                                  textAlign: TextAlign.center,
                                                ),
                                                Text(
                                                  double.parse(speed)
                                                          .toStringAsFixed(1) +
                                                      ' m/s',
                                                  style: TextStyle(
                                                      color: lightwhite,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              18),
                                                  textAlign: TextAlign.center,
                                                )
                                              ],
                                            )
                                          ])),
                                  Expanded(
                                      flex: 2,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '"Distance',
                                                style: TextStyle(
                                                    color: lightwhite,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            18),
                                                textAlign: TextAlign.center,
                                              ),
                                              Text(
                                                (totalDistance / 1000)
                                                        .toStringAsPrecision(
                                                            2) +
                                                    ' km',
                                                style: TextStyle(
                                                    color: lightwhite,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            18),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          )
                                        ],
                                      )),
                                  Expanded(
                                      flex: 2,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '"Timer',
                                                style: TextStyle(
                                                    color: lightwhite,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            18),
                                                textAlign: TextAlign.center,
                                              ),
                                              Text(
                                                _printDuration(
                                                    Duration(seconds: _start)),
                                                style: TextStyle(
                                                    color: lightwhite,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            18),
                                                textAlign: TextAlign.center,
                                              )
                                            ],
                                          ),
                                        ],
                                      )),
                                  // Expanded(
                                  //   flex: 1,
                                  //   child: SizedBox(),
                                  // ),
                                ]),
                          ))),
                  Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                  Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                              flex: 4,
                              child: RaisedButton(
                                  onPressed: () async {
                                    startTimer();
                                    BackgroundLocation.setNotificationTitle(
                                        "Background service running");
                                    BackgroundLocation.startLocationService();
                                    BackgroundLocation.getLocationUpdates(
                                        (location) {
                                      setState(() {
                                        //초기상태

                                        if (beforeLat == 0 && currentLat == 1) {
                                          this.beforeLat = location.latitude;
                                          this.beforeLong = location.longitude;
                                          this.currentLat = location.latitude;
                                          this.currentLong = location.longitude;
                                        } else {
                                          this.beforeLat =
                                              double.parse(this.latitude);
                                          this.beforeLong =
                                              double.parse(this.longitude);
                                          this.currentLat = location.latitude;
                                          this.currentLong = location.longitude;
                                        }

                                        this.latitude =
                                            location.latitude.toString();
                                        this.longitude =
                                            location.longitude.toString();
                                        this.accuracy =
                                            location.accuracy.toString();
                                        this.altitude =
                                            location.altitude.toString();
                                        this.bearing =
                                            location.bearing.toString();
                                        this.speed = location.speed.toString();
                                        this.time =
                                            DateTime.fromMillisecondsSinceEpoch(
                                                    location.time.toInt())
                                                .toString();

                                        if (((beforeLat == 0 &&
                                                    currentLat == 1) ==
                                                false) &&
                                            ((beforeLat == currentLat) ==
                                                false)) {
                                          totalDistance +=
                                              distanceInKmBetweenEarthCoordinates(
                                                  beforeLat,
                                                  beforeLong,
                                                  currentLat,
                                                  currentLong,
                                                  location.speed);

                                          // totalDistance2 += distance(beforeLat, beforeLong,
                                          //     currentLat, currentLong, 'm', location.speed);
                                        }
                                      });
                                      print("""\n
                        beforLat: $beforeLat
                        current: $currentLat
                        Latitude:  $latitude
                        Longitude: $longitude
                        Accuracy: $accuracy
                        Speed: $speed
                        Time: $time
                      """);
                                    });
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  color: mandarin,
                                  child: Container(
                                      width: double.infinity,
                                      // height:
                                      //     MediaQuery.of(context).size.width *
                                      //         0.2,
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Start',
                                            style: TextStyle(
                                                color: lightwhite,
                                                fontWeight: FontWeight.bold,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    14),
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
                              child: RaisedButton(
                                  onPressed: () {
                                    customAlert(
                                        context: context,
                                        str:
                                            "Are you sure you want to exit the relay?",
                                        function: () => handleDialogYes());
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  color: Colors.green[400],
                                  child: Container(
                                      //margin: EdgeInsets.only(left: 10),
                                      width: double.infinity,
                                      // height:
                                      //     MediaQuery.of(context).size.width *
                                      //         0.2,
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'End',
                                            style: TextStyle(
                                                color: lightwhite,
                                                fontWeight: FontWeight.bold,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    14),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      )))),
                        ],
                      )),
                  Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                ]))));
  }

  void handleDialogYes() {
    // Navigator.of(context).pop();
    if (_start != 0) {
      isStart = false;
      _timer.cancel();
      writeData();
    }
    //이 거리만큼 이동시에 Finish_Relay 으로 이동.
    //테스팅용
    //실제에서는 if(totalDistance > 3500)
    //if (totalDistance > 3500) {
    //if (_start > 5) {
    Route route = MaterialPageRoute(
        builder: (context) => RelayFinish(
              recordTime: _start != null ? _start : 0,
              totalDistance: totalDistance,
              teamName: widget.teamName,
              userName: widget.userName,
            ));

    Navigator.pushReplacement(context, route);
    // }

    BackgroundLocation.stopLocationService();
  }

  Widget locationData(String data) {
    return Text(
      data,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: Colors.white,
      ),
      textAlign: TextAlign.center,
    );
  }

  getCurrentLocation() {
    BackgroundLocation().getCurrentLocation().then((location) {
      print("This is current Location" + location.longitude.toString());
    });
  }

  double degreesToRadians(degrees) {
    // return degrees * 0.0174532925199432954743716805978692718781530857086181640625;   // max : 52 | min 14
    return degrees * 0.017453292519943295474371; // jongsTest
    // 0.017453292519943295474371680597869271878153085708618; // max : 65 | min 14
    // return degrees * 0.01745329251994329547437168059786927187815;          // max : 49 | min 15
  }

  double distanceInKmBetweenEarthCoordinates(lat1, lon1, lat2, lon2, speed) {
    if (speed > 0.8 && speed < 6) {
      var earthRadiusKm = 6371;
      var dLat = degreesToRadians(lat2 - lat1);
      var dLon = degreesToRadians(lon2 - lon1);

      lat1 = degreesToRadians(lat1);
      lat2 = degreesToRadians(lat2);

      var a = sin(dLat / 2) * sin(dLat / 2) +
          sin(dLon / 2) * sin(dLon / 2) * cos(lat1) * cos(lat2);
      var c = 2 * atan2(sqrt(a), sqrt(1 - a));
      return earthRadiusKm * c * 1000;
    } else
      return 0;
  }

  double distance(lat1_, lon1_, lat2_, lon2_, String unit, speed) {
    if (speed > 0.8 && speed < 6) {
      double lat1 = lat1_;
      double lon1 = lon1_;
      double lat2 = lat2_;
      double lon2 = lon2_;

      double theta = lon1 - lon2;
      double dist = sin(deg2rad(lat1)) * sin(deg2rad(lat2)) +
          cos(deg2rad(lat1)) * cos(deg2rad(lat2)) * cos(deg2rad(theta));
      dist = acos(dist);
      dist = rad2deg(dist);
      dist = dist * 60 * 1.1515;
      if (unit == 'm') {
        //meters
        dist = dist * 1.609344 * 1000;
      } else if (unit == 'N') {
        //nautical miles
        dist = dist * 0.8684;
      }
      return (dist); //miles
    } else
      return 0;
  }

  double deg2rad(double deg) {
    return (deg * pi / 180.0);
  }

  double rad2deg(double rad) {
    return (rad * 180.0 / pi);
  }

  @override
  void dispose() {
    //_timer.cancel(); ->> 사라진 위젯에서 cancel하려고 해서 에러 발생
    BackgroundLocation.stopLocationService();
    super.dispose();
  }
}
