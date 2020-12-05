import 'package:flutter/material.dart';
import "package:emp_tracker/screens/appbar.dart";
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminLeaveRow extends StatefulWidget {
  final String name;
  final String type;
  final String from;
  final String to;
  final String appliedOn;
  final String lid;
  final String eId;
  AdminLeaveRow(this.name, this.type, this.from, this.to, this.appliedOn,
      this.lid, this.eId);
  @override
  _AdminLeaveRowState createState() => _AdminLeaveRowState();
}

class _AdminLeaveRowState extends State<AdminLeaveRow> {
  final CollectionReference leaves =
      FirebaseFirestore.instance.collection('leaves');
  var leaves2;
  List leaveApps = [];

  Future<void> approval() {
    return leaves
        .doc(widget.eId)
        .collection('Leaves_sub')
        .doc(widget.lid)
        .update({'leaveStatus': 'approved'})
        .then((value) => print("Leaves updated"))
        .catchError((error) => print("Failed to update leave form: $error"));
  }

  Future<void> reject() {
    return leaves
        .doc(widget.eId)
        .collection('Leaves_sub')
        .doc(widget.lid)
        .update({'leaveStatus': 'rejected'})
        .then((value) => print("Leaves updated"))
        .catchError((error) => print("Failed to update leave form: $error"));
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
  static List leaveApps2 = [];
  static List leaveAppsId = [];
  static List empId = [];
  static List eName = [];
  @override
  Widget build(BuildContext context) {
    Future<List<Widget>> getLeaves() async {
      leaveApps2 = [];
      leaveAppsId = [];
      empId = [];
      eName = [];
      List x = await FirebaseFirestore.instance
          .collection("leaves")
          .get()
          .then((val) => val.docs);

      for (int i = 0; i < x.length; i++) {
        print(x[i].id);
        await FirebaseFirestore.instance
            .collection("leaves")
            .doc(x[i].id)
            .collection("Leaves_sub")
            .get()
            .then((value) {
          value.docs.forEach((ele) {
            leaveApps2.add(ele.data());
            leaveAppsId.add(ele.id);
            empId.add(x[i].id);
            eName.add(x[i].data()['username']);
            print(x[i].data()['username']);
          });
        });
      }

      print(leaveApps2.length);
      List<Widget> items = new List<Widget>();
      int k = 0;
      leaveApps2.forEach((element) {
        // print(element);
        // print(leaveAppsId[k]);
        if (element['leaveStatus'] == "pending") {
          items.add(AdminLeaveRow(eName[k], element['type'], element['from'],
              element['to'], element['appliedDate'], leaveAppsId[k], empId[k]));
        }

        k++;
      });
      return (items);
    }

    // CollectionReference leaves =
    //     FirebaseFirestore.instance.collection('leaves');
    return Scaffold(
      appBar: new MyAppBar("Leave applications"),
      body: Container(
        child: FutureBuilder(
          initialData: <Widget>[Text("")],
          future: getLeaves(),
          builder: (context, snapshot) {
            print("Leave application list");
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
    );
  }
}
