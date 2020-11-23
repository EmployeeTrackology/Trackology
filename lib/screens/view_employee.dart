import 'package:flutter/material.dart';
import "package:emp_tracker/screens/appbar.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emp_tracker/view_model/userCRUD.dart';
import 'package:provider/provider.dart';
import 'package:emp_tracker/models/user.dart';

class ViewEmployees extends StatefulWidget {
  ViewEmployees({Key key}) : super(key: key);

  @override
  _ViewEmployeesState createState() => _ViewEmployeesState();
}

class _ViewEmployeesState extends State<ViewEmployees> {
  List<TheUser> users;

  final empname = [
    'Hiral Sheth',
    'Hasti Shah',
    'Nishi Shah',
    'Divya Sheth',
    'Krishna Patel',
    'Jenil  Doshi',
    'Raj Mehta',
    'Zeel Chheda',
    'Parth Shah',
    'Jill Shetty',
    'Adwait Rane'
  ];

  final post = [
    'Manager',
    'Designer',
    'HR',
    'Web Designer',
    'Content Writer',
    'Sales',
    'Data Analyst',
    'Front End Developer',
    'Data Analyst',
    'Software Engineer',
    'IT',
    'Data Entry Operator'
  ];

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<CRUDModel>(context);
    return Scaffold(
      backgroundColor: Color(0xffC7D3F4),
      appBar: new MyAppBar("View Employees"),
      body:Container(
        child:StreamBuilder(
           stream: userProvider.fetchTheUsersAsStream(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                users = snapshot.data.docs
                    .map((doc) => TheUser.fromMap(doc.data(), doc.id))
                    .toList();
                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (buildContext, index) =>
                      UserCard(userDetails: users[index]),
                );
              } else {
                return Text('fetching');
              }
            }
            )),  
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
      leading: Icon(Icons.account_circle,
          color: Color(0xff603F83), size: 50.0),
      title: Text('${userDetails.name}',
          style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text('${userDetails.emailId}'));
  }
}