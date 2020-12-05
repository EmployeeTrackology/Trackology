
import 'package:flutter/material.dart';
import "package:emp_tracker/screens/appbar.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emp_tracker/models/user.dart';

class ViewEmployees extends StatefulWidget {
  ViewEmployees({Key key}) : super(key: key);
  @override
  _ViewEmployeesState createState() => _ViewEmployeesState();
}
class _ViewEmployeesState extends State<ViewEmployees> {

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return Scaffold(
      backgroundColor: Color(0xffC7D3F4),
      appBar: new MyAppBar("View Employees"),
      body: Container(
      child:StreamBuilder<QuerySnapshot>(
      stream: users.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return new ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            return new ListTile(
              title: new Text(document.data()['username']),
              subtitle: new Text(document.data()['department']),
            );
          }).toList(),
        );
      },
    ),
          
    ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Go to add employee form");
          Navigator.pushNamed(context, "/add_employee");
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xff603F83),
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  final TheUser userDetails;
  UserCard({@required this.userDetails});
  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading:
            Icon(Icons.account_circle, color: Color(0xff603F83), size: 50.0),
        title: Text('${userDetails.name}',
            style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('${userDetails.emailId}'));
  }
}
