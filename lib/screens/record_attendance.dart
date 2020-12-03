import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:emp_tracker/screens/appbar.dart';
import 'package:intl/intl.dart'; //This package provides date formatting and parsing facilities. This library also defines the DateFormat, NumberFormat, and BidiFormatter classes.

class MarkAttendance extends StatefulWidget {
  @override
  _MarkState createState() => _MarkState();
}

class _MarkState extends State<MarkAttendance> {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition;
  String _currentAddress;
  String _type;
  String _address;
  @override
  Widget build(BuildContext context) {
    
    Future<void> createAttendance() async {
      User user = FirebaseAuth.instance.currentUser;
      //TimeOfDay now = TimeOfDay.now();
      var now = new DateTime.now();
      Object obj = {
        'Date': DateTime.now().toString().substring(0, 10),
        'Time': new DateFormat("H:m:s").format(now),
        'type': _type,
        'place': _address
      };

      // Call the user's CollectionReference to add a new user
      await FirebaseFirestore.instance
          .collection("attendance")
          .doc(user.uid).collection("Days")
          .add(obj)
          .then((value) => print("Attendance recorded"))
          .catchError((error) => print("Failed to record attendance: $error"));
    }

     _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);
      Placemark place = p[0];
      setState(() {
        print(_currentAddress);
        _address = _currentAddress;
        _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
        print(_currentAddress);
        createAttendance();
      });
    } catch (e) {
      print(e);
    }
  }
     _getCurrentLocation(String x) async {
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

 

    return Scaffold(
      appBar: new MyAppBar("Mark Attendance"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_currentPosition != null) Text(_currentAddress ?? 'mumbai'),
            RaisedButton(
              color: Colors.green,
              child: Text("IN:Get location"),
              onPressed: () {
                _getCurrentLocation('in');
                _type = 'in';
              },
            ),
            RaisedButton(
              color: Colors.red,
              child: Text("OUT:Get location"),
              onPressed: () {
                _getCurrentLocation('out');
                _type = 'out';
              },
            ),
          ],
        ),
      ),
    );
  }

 
}
