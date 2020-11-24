import 'package:flutter/material.dart';
import 'package:emp_tracker/screens/appbar.dart';
// import 'package:emp_tracker/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// import "package:provider/provider.dart";

// class LeavesList extends StatefulWidget {
//   @override
//   _LeavesListState createState() => _LeavesListState();
// }

// class _LeavesListState extends State<LeavesList> {
//   @override
//   Widget build(BuildContext context) {
//     final leaves = Provider.of<QuerySnapshot>(context);
//     print(leaves);
//     for (var doc in leaves.docs) {
//       print(doc.data);
//     }
//     return Container();
//   }
// }

class LeaveForm extends StatefulWidget {
  LeaveForm({Key key}) : super(key: key);
  @override
  _LeaveFormState createState() => _LeaveFormState();
}

enum Options { casual, medical, annual }
enum LeaveStatus { approved, pending, rejected }

class _LeaveFormState extends State<LeaveForm> {
  Options _site = Options.casual;
  String type;
  DateTime fromDate, toDate;
  final from = TextEditingController(); //from
  final to = TextEditingController(); //to
  int differ = 0;
  @override
  void dispose() {
    // Clean up the controller when the widget is removed
    from.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> createLeaveApp() async {
      User user = FirebaseAuth.instance.currentUser;

      // Call the user's CollectionReference to add a new user
      await FirebaseFirestore.instance
          .collection("leaves")
          .doc(user.uid)
          .set({
            'from': from.text,
            'to': to.text,
            'appliedDate': DateTime.now().toString().substring(0, 10),
            'type': type,
            'leaveStatus':LeaveStatus.pending
          })
          .then((value) => print("Leave form Added"))
          .catchError((error) => print("Failed to add leave: $error"));
    }

    return Scaffold(
        appBar: new MyAppBar("Leave Application Form"),
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Center(
                child: Container(
              padding: EdgeInsets.fromLTRB(40, 10, 20, 5),
              child: Text('Available Leaves',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center),
            ) //container
                ), //center
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Container(
                  margin: EdgeInsets.all(10.0),
                  //   width:100,height:50,
                  padding: EdgeInsets.fromLTRB(20, 10, 10, 5),
                  color: Colors.blue[300],
                  child: Text("ML - 2 ",
                      style: TextStyle(fontSize: 25, color: Colors.white))),
              SizedBox(height: 20, width: 10),
              Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  //padding:EdgeInsets.all(10.0),
                  color: Colors.blue[300],
                  child: Text("CL - 1 ",
                      style: TextStyle(fontSize: 25, color: Colors.white))),
              SizedBox(height: 20, width: 10),
              Container(
                  margin: EdgeInsets.all(10.0),
                  padding: EdgeInsets.all(10.0),
                  color: Colors.blue[300],
                  child: Text("AL - 3 ",
                      style: TextStyle(fontSize: 25, color: Colors.white)))
            ]),
            Column(
              children: <Widget>[
                SizedBox(
                  height: 5.0,
                ),
                Text("From", style: TextStyle(fontWeight: FontWeight.bold)),
                Center(
                  child: TextField(
                      readOnly: true,
                      controller: from,
                      decoration:
                          InputDecoration(hintText: 'Pick your Start Date'),
                      onTap: () async {
                        var date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100));
                        from.text = date.toString().substring(0, 10);
                        fromDate = date;
                        differ = toDate.difference(fromDate).inDays;
                      }),
                ),
              ], //contianer
            ), //column
            Column(
              children: <Widget>[
                SizedBox(
                  height: 5.0,
                ),
                Text("To", style: TextStyle(fontWeight: FontWeight.bold)),
                Center(
                  child: TextField(
                      readOnly: true,
                      controller: to,
                      decoration:
                          InputDecoration(hintText: 'Pick your End  Date'),
                      onTap: () async {
                        var date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100));
                        to.text = date.toString().substring(0, 10);
                        toDate = date;
                        differ = toDate.difference(fromDate).inDays;
                      }),
                ),
              ], //contianer
            ),

            Column(
              // mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("Number of Days for Leave:",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 10.0,
                ),
                Text(differ.toString()),
                SizedBox(
                  height: 10.0,
                ),
                Text("Types of Leaves",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                ListTile(
                  title: const Text('Casual Leave',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  leading: Radio(
                    value: Options.casual,
                    groupValue: _site,
                    onChanged: (Options value) {
                      setState(() {
                        _site = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Medical Leave',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  leading: Radio(
                    value: Options.medical,
                    groupValue: _site,
                    onChanged: (Options value) {
                      setState(() {
                        _site = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Annual Leave',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  leading: Radio(
                    value: Options.annual,
                    groupValue: _site,
                    onChanged: (Options value) {
                      setState(() {
                        _site = value;
                      });
                    },
                  ),
                ), //3rdlistile
                Container(
                  //margin: EdgeInsets.all(5),
                  child: FlatButton(
                    child: Text(
                      'Submit',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    color: Colors.red,
                    textColor: Colors.white,
                    onPressed: () {
                      type = _site.toString();
                      createLeaveApp();
                      Navigator.pushNamed(context, '/employee');
                    },
                  ),
                ), //submit
              ],
            ),
          ],
        )));
  }
}
