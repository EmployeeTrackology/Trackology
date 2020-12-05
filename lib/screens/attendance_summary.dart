import 'package:flutter/material.dart';
import 'package:emp_tracker/screens/appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emp_tracker/screens/admin_attend_history.dart';

/*
class Summary extends StatefulWidget {
  @override
  _SummaryState createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new MyAppBar("Holidays"),
        body: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Month Name',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Year',
                    ),
                  ),
                ),
                RaisedButton(
                  textColor: Colors.white,
                  color: Colors.blue,
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AttendanceSummary()),
                    );
                  },
                ) //raised
              ],
            )));
  }
}
*/

class AttendanceSummary extends StatefulWidget {
  @override
  _AttendanceSummaryState createState() => _AttendanceSummaryState();
}

class _AttendanceSummaryState extends State<AttendanceSummary> {
  @override
  Widget build(BuildContext context) {
    Widget mycard(String event, String date1, String eid) {
      return Card(
          elevation: 5.0,
          margin: EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 5.0,
          ),
          //symmetric
          child: InkWell(
              child: Container(
                padding: EdgeInsets.all(5.0),
                child: ListTile(
                  title: Text("$event\t-\t $date1",
                      style: TextStyle(fontWeight: FontWeight.bold)), //text
                ), //listtile
              ),
              onTap: () {
                print(eid);
               Navigator.push(
              context, MaterialPageRoute(builder: (context) => History(eid)));
              }) //container
          );
    }

    CollectionReference employees =
        FirebaseFirestore.instance.collection('users');

    return Scaffold(
      appBar: new MyAppBar("Attendance Summary"), //appbar
      backgroundColor: Color(0xffC7D3F4),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: employees.where('role', isEqualTo: "employee").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }
            if (!snapshot.hasData) {
              return Text("no employees");
            }
            return new ListView(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                if (document.data()['role'] == "employee") {
                  return mycard(document.data()['username'],
                      document.data()['department'], document.id);
                }
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
