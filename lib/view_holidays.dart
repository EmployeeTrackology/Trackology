import 'package:flutter/material.dart'; 
import 'appbar.dart';

 
class ViewHoliday extends StatefulWidget { 
@override 
_ViewHolidayState createState() => _ViewHolidayState(); 
} 
class _ViewHolidayState extends State<ViewHoliday> { 
   
    Widget mycard(String event,String date1)
    { return Card(
        elevation:5.0,
        margin:EdgeInsets.symmetric(horizontal:10.0,vertical:5.0,), //symmetric
        child:Container(
            padding:EdgeInsets.all(5.0),
            child:ListTile(
                title:Text( "$event\t\t $date1",style:TextStyle(fontWeight:FontWeight.bold)),//text
            ),//listtile
        ),//container
    );}
@override 
Widget build(BuildContext context) { 
    return 
    Scaffold(
 //floating
        appBar:new MyAppBar("Holidays"),//appbar
        backgroundColor:Color(0xffC7D3F4),
        body:SingleChildScrollView(
            child:Column(
                children:<Widget>[
                    mycard("New Year","01-01-2020" ),
                    mycard("Makar Sankranti "," 14-01-2020"),
                    mycard("Republic Day"," 26-01-2020"),
                    mycard("Shivaji Jayanti ","19-02-2020"),
                    mycard("Shivaratri"," 21-02-2020"),
                    mycard("Holi ","    10-03-2020"),
                    mycard("Ram Navmi "," 02-04-2020"),
                    mycard("Mahavir Jayanti ", " 06-04-2020"),
                    mycard("Good Friday "," 10-04-2020"),
                    mycard("Easy Day "," 12-04-2020"),
 
                ],//widget
            ), //column
        ),//singlechild
    ); //scaffold
} 
} 
