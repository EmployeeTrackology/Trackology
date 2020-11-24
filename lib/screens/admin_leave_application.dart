// import 'package:emp_tracker/models/leave.dart';
import 'package:flutter/material.dart';
// import 'dart:convert';
import "package:emp_tracker/screens/appbar.dart";
// import "package:emp_tracker/services/database.dart";
// import "package:provider/provider.dart";
// import 'package:emp_tracker/models/leave.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class LeavesList extends StatefulWidget {
//   @override
//   _LeavesListState createState() => _LeavesListState();
// }

// class _LeavesListState extends State<LeavesList> {
//   @override
//   Widget build(BuildContext context) {
//     final leaves = Provider.of<List<Leave>>(context);
//     print(leaves);
//     leaves.forEach((leave) {
//       print(leave.type);
//     });
//     return Container();
//   }
// }

class AdminLeaveRow extends StatelessWidget {
  final String name;
  final String type;
  final String from;
  final String to;
  final String appliedOn;

  AdminLeaveRow(this.name, this.type, this.from, this.to, this.appliedOn);
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
                    Text(name,
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: "Sansita",
                            decoration: TextDecoration.underline,
                            decorationThickness: 1.5)),
                    Text(type),
                    Text(from + " to " + to),
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
        Container(
            height: 50,
            width: 90,
            child: RaisedButton(
              textColor: Colors.red,
              child: Text(
                'Reject',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
              onPressed: () {},
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
              onPressed: () {},
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
                    // print(document.data()['appliedDate']);
                    return AdminLeaveRow(
                      'employee',
                      document.data()['type'],
                      document.data()['from'],
                      document.data()['to'],
                      document.data()['appliedDate'],
                    );
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
