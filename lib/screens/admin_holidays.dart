import 'package:flutter/material.dart';
import 'package:emp_tracker/screens/appbar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Holiday extends StatefulWidget {
  @override
  _HolidayState createState() => _HolidayState();
}

class _HolidayState extends State<Holiday> {
  String holiday_name, date;

  @override
  Widget build(BuildContext context) {
    CollectionReference holidays =
        FirebaseFirestore.instance.collection('holidays');

    Future<void> createHoliday() {
      return holidays
          .add({'holiday_name': holiday_name, 'date': date})
          .then((value) => print(" Holidays Added"))
          .catchError((error) => print("Failed to add holidays: $error"));
    }

    void showalertdialog() {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ), //RoundedRectangleBorder
          title: Text(" Add Holidays", textAlign: TextAlign.center),
          content: Column(
            // color:Colors.black,
            //mainAxisSize:MainAxisSize.min,
            children: <Widget>[
              Text("Event name", textAlign: TextAlign.left),
              TextField(
                  autofocus: true,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Padding(
                  padding: EdgeInsets.only(
                top: 10.0,
              )),

              Text("Date", textAlign: TextAlign.left),
              TextField(
                  autofocus: true,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Padding(
                  padding: EdgeInsets.only(
                top: 10.0,
              )),

              RaisedButton(
                color: Color(0xff603F83),
                onPressed: () {
                  createHoliday();
                  Navigator.of(context).pop();
                }, //database
                child: Text("ADD",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
              ), //raisedbutton
              SizedBox(width: 5.0, height: 10.0),
              RaisedButton(
                color: Color(0xff603F83),
                onPressed: () {
                  Navigator.of(context).pop();
                }, //database
                child: Text("CANCEL",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
              ), //raisedbutton
            ], //widget
          ), //column
        ), //alerdialog
      );
    }

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

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: showalertdialog,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ), //icon
          backgroundColor: Color(0xff603F83),
        ), //floating
        appBar: new MyAppBar("Holidays"), //appbar
        backgroundColor: Color(0xffC7D3F4),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              mycard("New Year", "01-01-2020"),
              mycard("Makar Sankranti ", " 14-01-2020"),
              mycard("Republic Day", " 26-01-2020"),
              mycard("Shivaji Jayanti ", "19-02-2020"),
              mycard("Shivaratri", " 21-02-2020"),
              mycard("Holi ", "    10-03-2020"),
              mycard("Ram Navmi ", " 02-04-2020"),
              mycard("Mahavir Jayanti ", " 06-04-2020"),
              mycard("Good Friday ", " 10-04-2020"),
              mycard("Easy Day ", " 12-04-2020"),
            ], //widget
          ), //column
        ), //singlechild
      ); //scaffold
    }
  }
}
