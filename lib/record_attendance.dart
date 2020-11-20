import 'package:flutter/material.dart';
// import "appbar.dart";
// import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class Location {
  double latti, longi;
  Future<void> grab() async {
    try {
      Position pos = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      latti = pos.latitude;
      longi = pos.longitude;
      print(latti);
      print(longi);
    } catch (e) {
      print(e);
    }
  }

  Location l = Location();
}

class MarkAttendance extends StatefulWidget {
  @override
  _MarkState createState() => _MarkState();
}

class _MarkState extends State<MarkAttendance> {
  final Geolocator geolocator = Geolocator();

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
            // if (_currentPosition != null) Text(_currentAddress),
            RaisedButton(
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
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      print("fjhfjh");
      setState(() {
        _currentPosition = position;
        print(_currentPosition);
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print("fjhfjh");
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
      });
      print(_currentAddress);
    } catch (e) {
      print(e);
    }
  }
}
