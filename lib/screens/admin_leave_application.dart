// import 'package:emp_tracker/models/leave.dart';
import 'package:flutter/material.dart';
// import 'dart:convert';
import "package:emp_tracker/screens/appbar.dart";
// import "package:emp_tracker/services/database.dart";
// import "package:provider/provider.dart";
// import 'package:emp_tracker/models/leave.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminLeaveRow extends StatefulWidget {
  String name;
  String type;
  String from;
  String to;
  String appliedOn;
  String lid;
  AdminLeaveRow(
      this.name, this.type, this.from, this.to, this.appliedOn, this.lid);
  @override
  _AdminLeaveRowState createState() => _AdminLeaveRowState();
}

class _AdminLeaveRowState extends State<AdminLeaveRow> {
  final CollectionReference leaves =
      FirebaseFirestore.instance.collection('leaves');

  Future<void> approval() {
    return leaves
        .doc(widget.lid)
        .update({'leaveStatus': 'approved'})
        .then((value) => print("Leaves updated"))
        .catchError((error) => print("Failed to update leave form: $error"));
  }

  Future<void> reject() {
    return leaves
        .doc(widget.lid)
        .update({'leaveStatus': 'rejected'})
        .then((value) => print("Leaves updated"))
        .catchError((error) => print("Failed to update leave form: $error"));
  }

  Future<void> getData() async {
    DocumentSnapshot result = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.lid)
        .get();
    print(result);
    return result;
  }

  Future<void> _userDetails() async {
    // final details = await getData();
    // String name;
    // setState(() {
    //   widget.name = details.name;
    //   // new Text(firstName);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
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
                    Text(widget.name,
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: "Sansita",
                            decoration: TextDecoration.underline,
                            decorationThickness: 1.5)),
                    Text(widget.type),
                    Text(widget.from + " to " + widget.to),
                    Text("Applied on: " + widget.appliedOn)
                  ]),
            ),
            margin: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
            ),
          ),
        ),
        Container(
            height: 50,
            width: 90,
            child: RaisedButton(
              textColor: Colors.red,
              child: Text(
                'Reject',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
              onPressed: () {
                reject();
              },
            )),
        SizedBox(
          width: 10,
        ),
        Container(
            height: 50,
            width: 90,
            child: RaisedButton(
              textColor: Colors.green,
              child: Text(
                'Approve',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
              onPressed: () {
                approval();
              },
            )),
      ],
    );
  }
}

class LeavesApp extends StatefulWidget {
  @override
  _LeaveState createState() => _LeaveState();
}

class _LeaveState extends State<LeavesApp> {
  @override
  Widget build(BuildContext context) {
    // Dynamic data;

    // Future<List<Widget>> createAdminLeaveList() async {
    //   List<Widget> items = new List<Widget>();
    //   String fn = await DefaultAssetBundle.of(context)
    //       .loadString("data_json/admin_emp_leaves.json");
    //   List<dynamic> fnJson = jsonDecode(fn);
    //   fnJson.forEach((obj) {
    //     items.add(AdminLeaveRow(obj['name'], obj['type'], obj['from'],
    //         obj['to'], obj['appliedOn']));
    //   });
    //   // print(items);
    //   return items;
    // }

    CollectionReference leaves =
        FirebaseFirestore.instance.collection('leaves');
    return Scaffold(
      appBar: new MyAppBar("Leave applications"),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: leaves.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            print("Leave application list");
            if (snapshot.hasData) {
              return Padding(
                padding: EdgeInsets.all(8.0),
                child: ListView(
                  primary: false,
                  shrinkWrap: true,
                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                    // print(document);
                    return AdminLeaveRow(
                        'employee',
                        document.data()['type'].substring(8,),
                        document.data()['from'],
                        document.data()['to'],
                        document.data()['appliedDate'],
                        document.id);
                  }).toList(),
                ),
              );
            } else {
              print("Loading...");
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
