/*
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
*/




import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:emp_tracker/screens/appbar.dart';

class MarkAttendance extends StatefulWidget {
  @override
  _MarkState createState() => _MarkState();

}

class _MarkState extends State<MarkAttendance>  {
  Position _currentPosition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new MyAppBar("Mark Attendance"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_currentPosition != null)
              Text(
                  "LAT: ${_currentPosition.latitude}, LNG: ${_currentPosition.longitude}"),
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
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });
  }
}