import 'package:background_location/background_location.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class MyBackgroundLocation extends StatefulWidget {
  @override
  MyBackgroundLocationState createState() => MyBackgroundLocationState();
}

class MyBackgroundLocationState extends State<MyBackgroundLocation> {
  double beforeLat = 0;
  double beforeLong = 0;
  double currentLat = 1;
  double currentLong = 0;

  String latitude = "waiting...";
  String longitude = "waiting...";
  String altitude = "waiting...";
  String accuracy = "waiting...";
  String bearing = "waiting...";
  String speed = "waiting...";
  String time = "waiting...";

  double totalDistance = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Background Location Service'),
        ),
        body: Center(
          child: ListView(
            children: <Widget>[
              locationData("Latitude: " + latitude),
              locationData("Longitude: " + longitude),
              locationData("Altitude: " + altitude),
              locationData("Accuracy: " + accuracy),
              locationData("Bearing: " + bearing),
              locationData("Speed: " + speed),
              locationData("Time: " + time),
              locationData("TotalDistance: " + totalDistance.toString()),
              RaisedButton(
                  onPressed: () async {
                    BackgroundLocation.setNotificationTitle(
                        "Background service running");
                    BackgroundLocation.startLocationService();
                    BackgroundLocation.getLocationUpdates((location) {
                      setState(() {
                        //초기상태

                        if (beforeLat == 0 && currentLat == 1) {
                          this.beforeLat = location.latitude;
                          this.beforeLong = location.longitude;
                          this.currentLat = location.latitude;
                          this.currentLong = location.longitude;
                        } else {
                          this.beforeLat = double.parse(this.latitude);
                          this.beforeLong = double.parse(this.longitude);
                          this.currentLat = location.latitude;
                          this.currentLong = location.longitude;
                        }

                        this.latitude = location.latitude.toString();
                        this.longitude = location.longitude.toString();
                        this.accuracy = location.accuracy.toString();
                        this.altitude = location.altitude.toString();
                        this.bearing = location.bearing.toString();
                        this.speed = location.speed.toString();
                        this.time = DateTime.fromMillisecondsSinceEpoch(
                                location.time.toInt())
                            .toString();

                        if (((beforeLat == 0 && currentLat == 1) == false) &&
                            ((beforeLat == currentLat) == false)) {
                          totalDistance += distanceInKmBetweenEarthCoordinates(
                              beforeLat,
                              beforeLong,
                              currentLat,
                              currentLong,
                              location.speed);
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
                  child: Text("Start Location Service")),
              RaisedButton(
                  onPressed: () {
                    BackgroundLocation.stopLocationService();
                  },
                  child: Text("Stop Location Service")),
              // RaisedButton(
              //     onPressed: () {
              //       getCurrentLocation();
              //     },
              //     child: Text("Get Current Location")),
            ],
          ),
        ),
      ),
    );
  }

  Widget locationData(String data) {
    return Text(
      data,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
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
    if (speed > 0.3 && speed < 5) {
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

  double distance(lat1_, lon1_, lat2_, lon2_, String unit) {
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
  }

  double deg2rad(double deg) {
    return (deg * pi / 180.0);
  }

  double rad2deg(double rad) {
    return (rad * 180.0 / pi);
  }

  @override
  void dispose() {
    BackgroundLocation.stopLocationService();
    super.dispose();
  }
}
