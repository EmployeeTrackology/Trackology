import 'dart:convert';
import 'package:flutter/material.dart';
import "panel_appbar.dart";
import 'dart:async';

class AttendRow extends StatelessWidget {
  final String type, date, place, time;
  AttendRow(this.type, this.date, this.place, this.time);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.0),
      decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: Color(0xff603F83)),
          borderRadius: BorderRadius.all(Radius.circular((10.0))),
          boxShadow: [
            BoxShadow(color: Colors.black12),
          ]),
      margin: EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            width: 250,
            height: 110,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Type: Check " + type, style: TextStyle(fontSize: 20.0)),
                SizedBox(height: 5),
                Row(
                  children: <Widget>[
                    Text("Date:" + date, style: TextStyle(fontSize: 17.0)),
                    SizedBox(width: 7),
                    Text("Time:" + time, style: TextStyle(fontSize: 17.0)),
                  ],
                ),
                SizedBox(height: 5),
                Text(
                  "At " + place,
                  style: TextStyle(fontSize: 18.0, color: Colors.black54),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Check extends StatefulWidget {
  @override
  _CheckState createState() => _CheckState();
}

class _CheckState extends State<Check> {
  
  DateTime selectedDate = DateTime.now();
   Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
        
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }
  @override


  Widget build(BuildContext context) {
    Future<List<Widget>> checkTimeList() async {
      List<Widget> items = new List<Widget>();
      String fn = await DefaultAssetBundle.of(context)
          .loadString("data_json/emp_attend_history.json");
      List<dynamic> fnJson = jsonDecode(fn);
      fnJson.forEach((obj) {
        items.add(
            AttendRow(obj['type'], obj['date'], obj['place'], obj['time']));
      });
      return items;
    }

    return Scaffold(
        appBar: new AppBarPanel("Attendance History"),
        body: ListView(children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular((10.0))),
                      boxShadow: [
                        BoxShadow(color: Colors.black),
                      ]),
                  margin: EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Center(
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text("${selectedDate.toLocal()}".split(' ')[0],
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontFamily: "Sansita")),
                                SizedBox(height: 5.0,),
                                RaisedButton(onPressed:()=>_selectDate(context) ,
                                child: Text('Select date',
                                style:TextStyle(fontSize: 10)),
                              ),
                            ]  
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular((10.0))),
                      boxShadow: [
                        BoxShadow(color: Colors.black),
                      ]),
                  margin: EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 90,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("No. of days ",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontFamily: "Sansita")),
                              SizedBox(height: 5),
                              Text("present: 27",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontFamily: "Sansita")),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular((10.0))),
                      boxShadow: [
                        BoxShadow(color: Colors.black),
                      ]),
                  margin: EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        height: 90,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("No. of days",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontFamily: "Sansita")),
                              SizedBox(height: 5),
                              Text("absent :5",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontFamily: "Sansita")),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          // SizedBox(height: 10,),
          Container(
            child: FutureBuilder(
              initialData: <Widget>[Text("")],
              future: checkTimeList(),
              builder: (context, snapshot) {
                print("Employee function");
                if (snapshot.hasData) {
                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ListView(
                      primary: false,
                      shrinkWrap: true,
                      children: snapshot.data,
                    ),
                  );
                } else {
                  print("Loading...");
                  return CircularProgressIndicator();
                }
              },
            ),
          )
        ]));
  }
}
