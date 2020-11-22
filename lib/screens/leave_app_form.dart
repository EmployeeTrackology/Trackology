import 'package:flutter/material.dart'; 
import 'package:emp_tracker/screens/appbar.dart';

class LeaveForm extends StatefulWidget {
  LeaveForm({Key key}) : super(key: key);
  @override
  _LeaveFormState createState() => _LeaveFormState();
}

enum options { casual, medical, annual }  
class _LeaveFormState extends State<LeaveForm> {
  
   options _site = options.casual;  
  
 final dateController = TextEditingController(); //from
 final dateController1 = TextEditingController(); //to
//int differ;
  @override

  void dispose() {
    // Clean up the controller when the widget is removed
    dateController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new MyAppBar("Leave Application Form"),
      body: SingleChildScrollView(
        child:
      
        Column(  
        children: <Widget> [
            Center(child:Container(
            padding:EdgeInsets.fromLTRB(40,10,20,5),    
            child: Text('Available Leaves',
                    style:TextStyle(fontSize:30,fontWeight:FontWeight.bold),textAlign:TextAlign.center ),      
            )//container 
            ), //center
            Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children:[
                Container(
                 margin:EdgeInsets.all(10.0),
               //   width:100,height:50,
                    padding:EdgeInsets.fromLTRB(20,10,10,5),
                    color:Colors.blue[300],
                child:Text("ML - 2 ",style:TextStyle(fontSize:25,color:Colors.white))
                ),

                SizedBox(height:20,width:10),
                Container( padding:EdgeInsets.fromLTRB(10,10,10,10),
                          //padding:EdgeInsets.all(10.0),
                color:Colors.blue[300],
                child:Text("CL - 1 ",style:TextStyle(fontSize:25,color:Colors.white))
                ),
                SizedBox(height:20,width:10),
                Container(
                   margin:EdgeInsets.all(10.0),
                 
                  padding:EdgeInsets.all(10.0),
                color:Colors.blue[300],
                child:Text("AL - 3 ",style:TextStyle(fontSize:25,color:Colors.white)))
            ]),
          Column(
            children: <Widget>[
            SizedBox(height: 5.0,),
            Text("From",style:TextStyle(fontWeight:FontWeight.bold)),
            Center(child:TextField(
         readOnly: true,
         controller: dateController,
         decoration: InputDecoration( hintText: 'Pick your Start Date'),
         onTap: () async {
        var date =  await showDatePicker(
              context: context, 
              initialDate:DateTime.now(),
              firstDate:DateTime(1900),
              lastDate: DateTime(2100));
        dateController.text = date.toString().substring(0,10);      
       }
            
            ),
         
               ),
    ],//contianer           
              ), //column
           Column(
            children: <Widget>[
            SizedBox(height: 5.0,),
            Text("To",style:TextStyle(fontWeight:FontWeight.bold)),
            Center(child:TextField(
         readOnly: true,
         controller: dateController1,
         decoration: InputDecoration( hintText: 'Pick your End  Date'),
         onTap: () async {
        var date =  await showDatePicker(
              context: context, 
              initialDate:DateTime.now(),
              firstDate:DateTime(1900),
              lastDate: DateTime(2100));
        dateController1.text = date.toString().substring(0,10);      
       }
            
            ),
         
               ),
    ],//contianer           
              ),
            
         // differ=diffindate(dateController,dateController1),
          Column(
         // mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("Number of Days for Leave:3",style:TextStyle(fontWeight:FontWeight.bold)),
            SizedBox(height: 10.0,),
            Text("Types of Leaves",style:TextStyle(fontWeight:FontWeight.bold)),
             ListTile(  
          title: const Text('Casual Leave',style:TextStyle(fontWeight:FontWeight.bold)),  
          leading: Radio(  
            value: options.casual,  
            groupValue: _site,  
            onChanged: (options value) {  
              setState(() {  
                _site = value;  
              });  
            },  
          ),  
        ),  
        ListTile(  
          title: const Text('Medical Leave',style:TextStyle(fontWeight:FontWeight.bold)),  
          leading: Radio(  
            value: options.medical,  
            groupValue: _site,  
            onChanged: (options value) {  
              setState(() {  
                _site = value;  
              });  
            },  
          ),  
        ),  
        ListTile(  
          title: const Text('Annual Leave',style:TextStyle(fontWeight:FontWeight.bold)),  
          leading: Radio(  
            value: options.annual,  
            groupValue: _site,  
            onChanged: (options value) {  
              setState(() {  
                _site = value;  
              });   
            },  
          ),  
        ),  //3rdlistile
              Container(  
              //margin: EdgeInsets.all(5),  
              child: FlatButton(  
                child: Text('Submit', style: TextStyle(fontSize: 20.0),),  
                color: Colors.red,  
                textColor: Colors.white,  
                onPressed: () {},  
              ),  
            ),  //submit
                       ],
              ),
      ],
    )
      )
      );
  }
}