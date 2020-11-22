import 'package:flutter/material.dart';
import "package:emp_tracker/screens/appbar.dart";


class ViewEmployees extends StatefulWidget {

  ViewEmployees({Key key}) : super(key: key);

   @override

  _ViewEmployeesState createState() => _ViewEmployeesState();

}

class _ViewEmployeesState extends State<ViewEmployees> {

final empname=['Hiral Sheth','Hasti Shah','Nishi Shah','Divya Sheth','Krishna Patel','Jenil  Doshi','Raj Mehta','Zeel Chheda','Parth Shah','Jill Shetty','Adwait Rane'];

final post=['Manager','Designer','HR','Web Designer','Content Writer','Sales','Data Analyst','Front End Developer','Data Analyst','Software Engineer','IT','Data Entry Operator'];

  @override

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffC7D3F4),

      appBar: new MyAppBar("View Employees"),

      body: ListView.builder

(

itemCount:empname.length,

itemBuilder:(BuildContext context,int index)

{

    return ListTile

    (  leading:Icon(

        Icons.account_circle_sharp,

        color:Color(0xff603F83),

        size:50.0

    ),

        title:Text(empname[index],style:TextStyle(fontWeight:FontWeight.bold)),

        subtitle:Text(post[index])

    );

}),

      floatingActionButton: FloatingActionButton(

        onPressed:(){
          print("Go to add employee form");
          Navigator.pushNamed(context, "/add_employee");
        },

        //tooltip: 'Increment',

        child: Icon(Icons.add),

         backgroundColor: Color(0xff603F83),

        

      ),

    );

  }

}