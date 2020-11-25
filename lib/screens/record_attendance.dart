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
// import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
 import 'package:emp_tracker/screens/appbar.dart';
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
     appBar: new MyAppBar("Mark Attendance"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_currentPosition != null) Text(_currentAddress ?? 'mumbai'),
            RaisedButton(
              color:Colors.green,
              child: Text("IN:Get location"),
              onPressed: () {
                _getCurrentLocation('in');
              },
            ),
            RaisedButton(
              color:Colors.red,
              child: Text("OUT:Get location"),
              onPressed: () {
                _getCurrentLocation('out');
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
        _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
            print(_currentAddress);
      });
    } catch (e) {
      print(e);
    }
  }
}


