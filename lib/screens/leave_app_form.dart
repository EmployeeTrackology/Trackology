import 'package:flutter/material.dart';
import 'package:emp_tracker/screens/appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class LeaveForm extends StatefulWidget {
  LeaveForm({Key key}) : super(key: key);
  @override
  _LeaveFormState createState() => _LeaveFormState();
}

enum Options { Casual, Medical, Annual }

class _LeaveFormState extends State<LeaveForm> {
  Options _site = Options.Casual;
  String type;
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();
  String leaveType;
  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  String desc;
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
    Future<DocumentSnapshot> getData(String eid) async {
      print("eid " + eid);
      DocumentSnapshot result =
          await FirebaseFirestore.instance.collection('users').doc(eid).get();
      return result;
    }

    Future<String> userDetails(String eid) async {
      final details = await getData(eid);
      String name = details.data()['username'];
      print(name);
      return name;
    }

    Future<void> createLeaveApp() async {
      User user = FirebaseAuth.instance.currentUser;
      Object obj = {
        'from': from.text,
        'to': to.text,
        'appliedDate': formatter.format(DateTime.now()),
        'type': type.substring(
          8,
        ),
        'leaveStatus': 'pending',
        'desc': desc
      };

      // Call the user's CollectionReference to add a new user
      await FirebaseFirestore.instance
          .collection("leaves")
          .doc(user.uid)
          .collection("Leaves_sub")
          .add(obj)
          .then((value) => print("Leave form Added"))
          .catchError((error) => print("Failed to add leave: $error"));

      final username = await userDetails(user.uid);
      print(username);
      await FirebaseFirestore.instance
          .collection("leaves")
          .doc(user.uid)
          .set({"username": username})
          .then((value) => print("username form Added"))
          .catchError((error) => print("Failed to add leave: $error"));
    }

    return Scaffold(
        appBar: new MyAppBar("Leave Application Form"),
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Center(
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  onChanged: (val) {
                    desc = val;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Leave description',
                  ),
                ),
              ),
            ),
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
                        from.text = formatter.format(date);
                        fromDate = date;
                        setState(() {
                          differ = toDate.difference(fromDate).inDays;
                        });
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
                        to.text = formatter.format(date);
                        toDate = date;
                        setState(() {
                          differ = toDate.difference(fromDate).inDays;
                        });
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
                    value: Options.Casual,
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
                    value: Options.Medical,
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
                    value: Options.Annual,
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
