import 'package:flutter/material.dart';
import 'dart:convert';
import "package:emp_tracker/screens/appbar.dart";


class LeaveRow extends StatelessWidget {
  final String type,from,to,status,appliedOn;

  String _setImage(status) {
    String statusCheck = status;
    if (statusCheck == "rejected") {
      return "images/wrong.jpg";
    } else if (statusCheck == "approved") {
      return "images/right.jpg";
    } else {
      return "images/pending.jpg";
    }
  }

  LeaveRow(this.type, this.from, this.to, this.status, this.appliedOn);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            child: new Image.asset(_setImage(status)),
            margin: EdgeInsets.all(10.0),
          ),
        ),
        Expanded(
          flex: 5,
          child: Container(
            height: 100,
            width: 250,
            child: Padding(
              padding: EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(type,
                      style: TextStyle(fontSize: 18, fontFamily: "Sansita")),
                  Text(from + " to " + to),
                  Text(status,
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationThickness: 1.5)),
                  Text("Applied on: " + appliedOn)
                ]),
            ),
            margin: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class MyLeaves extends StatefulWidget {
  @override
  _LeaveState createState() => _LeaveState();
}

class _LeaveState extends State<MyLeaves> {
  @override
  Widget build(BuildContext context) {
    Future<List<Widget>> createLeaveList() async {
      List<Widget> items = new List<Widget>();
      String fn = await DefaultAssetBundle.of(context)
          .loadString("data_json/emp_leaves.json");
      List<dynamic> fnJson = jsonDecode(fn);
      fnJson.forEach((obj) {
        items.add(LeaveRow(obj['type'], obj['from'], obj['to'], obj['status'],
            obj['appliedOn']));
      });
      return items;
    }

    return Scaffold(
      appBar: new MyAppBar("Leave Status"),
      body: Container(
        child: FutureBuilder(
          initialData: <Widget>[Text("")],
          future: createLeaveList(),
          builder: (context, snapshot) {
            print("Leave status");
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
      ),
        // children: [
        //   LeaveRow("casual", "ahh", "dh", "rejected", "jh"),
        //   LeaveRow("casual", "ahh", "dh", "approved", "jh"),
        //   LeaveRow("casual", "ahh", "dh", "pending", "jh"),
        // ],
      );
  }
}
