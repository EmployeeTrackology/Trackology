
/*
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

class MarkAttendance extends StatefulWidget {
  @override
  _MarkState createState() => _MarkState();

}
class _MarkState extends State<MarkAttendance> {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  Position _currentPosition;
  String _currentAddress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_currentPosition != null) Text(_currentAddress ?? 'mumbai'),
            FlatButton(
              child: Text("Get location"),
              onPressed: () {
                _getCurrentLocation();
              },
            ),
          ],
        ),
      ),
    );
  }

  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }
}
*/

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:emp_tracker/screens/appbar.dart';

class MarkAttendance extends StatefulWidget {
  @override
  _MarkState createState() => _MarkState();

}
class _MarkState extends State<MarkAttendance>  {

  String _locationMessage = ""; 

  void _getCurrentLocation() async {

    final position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);

    setState(() {
      _locationMessage = "latitude =${position.latitude},longitude =${position.longitude}";
    });
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mark Attendance',
      home: Scaffold(
        appBar: new MyAppBar("Mark Attendance"),
        body: Align(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            Text(_locationMessage), 
            FlatButton(
              onPressed: () {
                  _getCurrentLocation();
              },
              color: Colors.green,
              child: Text("Find Location")
            )
          ]),
        )
      )
    );
  }
}

