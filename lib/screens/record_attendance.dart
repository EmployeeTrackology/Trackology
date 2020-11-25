// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:emp_tracker/screens/appbar.dart';

// class MarkAttendance extends StatefulWidget {
//   @override
//   _MarkState createState() => _MarkState();

// }

// class _MarkState extends State<MarkAttendance>  {
//   Position _currentPosition;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: new MyAppBar("Mark Attendance"),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             if (_currentPosition != null)
//               Text(
//                   "LAT: ${_currentPosition.latitude}, LNG: ${_currentPosition.longitude}"),
//             FlatButton(
//               child: Text("Get location"),
//               onPressed: () {
//                 _getCurrentLocation();
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   _getCurrentLocation() {
//     final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

//     geolocator
//         .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
//         .then((Position position) {
//       setState(() {
//         _currentPosition = position;
//       });
//     }).catchError((e) {
//       print(e);
//     });
//   }
// }
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:emp_tracker/screens/appbar.dart';
import 'package:intl/intl.dart';

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
          .doc(user.uid)
          .set(obj)
          .then((value) => print("Attendance recorded"))
          .catchError((error) => print("Failed to record attendance: $error"));
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
                createAttendance();
              },
            ),
            RaisedButton(
              color: Colors.red,
              child: Text("OUT:Get location"),
              onPressed: () {
                _getCurrentLocation('out');
                _type = 'out';
                createAttendance();
              },
            ),
          ],
        ),
      ),
    );
  }

  _getCurrentLocation(String x) {
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
        print(_currentAddress);
        _address = _currentAddress;
        _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
        print(_currentAddress);
      });
    } catch (e) {
      print(e);
    }
  }
}
