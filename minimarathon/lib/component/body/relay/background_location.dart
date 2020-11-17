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
                    await BackgroundLocation.setNotificationTitle(
                        "Background service running");
                    await BackgroundLocation.startLocationService();
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
                              beforeLat, beforeLong, currentLat, currentLong);
                        }
                      });
                      print("""\n
                        beforLat: $beforeLat
                        current: $currentLat
                        Latitude:  $latitude
                        Longitude: $longitude
                        Altitude: $altitude
                        Accuracy: $accuracy
                        Bearing:  $bearing
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
              RaisedButton(
                  onPressed: () {
                    getCurrentLocation();
                  },
                  child: Text("Get Current Location")),
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
    return degrees * 0.0174532925199433;
  }

  double distanceInKmBetweenEarthCoordinates(lat1, lon1, lat2, lon2) {
    var earthRadiusKm = 6371;

    var dLat = degreesToRadians(lat2 - lat1);
    var dLon = degreesToRadians(lon2 - lon1);

    lat1 = degreesToRadians(lat1);
    lat2 = degreesToRadians(lat2);

    var a = sin(dLat / 2) * sin(dLat / 2) +
        sin(dLon / 2) * sin(dLon / 2) * cos(lat1) * cos(lat2);
    var c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadiusKm * c * 1000;
  }

  @override
  void dispose() {
    BackgroundLocation.stopLocationService();
    super.dispose();
  }
}
