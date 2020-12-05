import 'package:flutter/material.dart';
import 'package:emp_tracker/screens/appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewHoliday extends StatefulWidget {
  @override
  _ViewHolidayState createState() => _ViewHolidayState();
}

class _ViewHolidayState extends State<ViewHoliday> {
  @override
  Widget build(BuildContext context) {
    CollectionReference holidays =
        FirebaseFirestore.instance.collection('holidays');
    Widget mycard(String event, String date1) {
      return Card(
        elevation: 5.0,
        margin: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 5.0,
        ), //symmetric
        child: Container(
          padding: EdgeInsets.all(5.0),
          child: ListTile(
            title: Text("$event\t\t $date1",
                style: TextStyle(fontWeight: FontWeight.bold)), //text
          ), //listtile
        ), //container
      );
    }

    return Scaffold(
      appBar: new MyAppBar("Holidays"), //appbar
      backgroundColor: Color(0xffC7D3F4),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: holidays.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }
            if (!snapshot.hasData) {
              return Text("no holidays");
            }
            return new ListView(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                return mycard(
                    document.data()['holidayName'], document.data()['date']);
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
