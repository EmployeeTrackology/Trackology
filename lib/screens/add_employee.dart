import 'package:flutter/material.dart';
import "package:emp_tracker/screens/appbar.dart";
 
class AddEmployee extends StatefulWidget {
  @override
  _State createState() => _State();
}
 
class _State extends State<AddEmployee> {
 
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor:Color(0xffC7D3F4),
        appBar:new MyAppBar("Add Employee"),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Enter employee details',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 20),
                    )),
           
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                 Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
             
                    ),
                  ),
                ),
                 Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Phone no.',
                    ),
                  ),
                ),
                 Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Department',
                    ),
                  ),
                ),
                SizedBox(height:20),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xff603FF3), Color(0xff603F83)],
                        stops: [0, 1],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    padding: EdgeInsets.all(5),
                    child: RaisedButton(

                      textColor: Colors.white,
                      color:Color(0xff603F83),
                      child: Text(
                        'ADD',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 30),),
                      onPressed: () {
                      },
                    )),
             
              ],
            )));
  }
}