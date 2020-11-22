import 'package:flutter/material.dart';
import 'dart:convert';
import "package:emp_tracker/screens/appbar.dart";


class AdminLeaveRow extends StatelessWidget {
  final String name;
  final String type;
  final String from;
  final String to;
  final String appliedOn;

  AdminLeaveRow(this.name, this.type, this.from, this.to, this.appliedOn);
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
                    Text(name,
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: "Sansita",
                            decoration: TextDecoration.underline,
                            decorationThickness: 1.5)),
                    Text(type),
                    Text(from + " to " + to),
                    Text("Applied on: " + appliedOn)
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
              onPressed: () {},
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
              onPressed: () {},
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
  @override
  Widget build(BuildContext context) {
    Future<List<Widget>> createAdminLeaveList() async {
      List<Widget> items = new List<Widget>();
      String fn = await DefaultAssetBundle.of(context)
          .loadString("data_json/admin_emp_leaves.json");
      List<dynamic> fnJson = jsonDecode(fn);
      fnJson.forEach((obj) {
        items.add(AdminLeaveRow(obj['name'], obj['type'], obj['from'],
            obj['to'], obj['appliedOn']));
      });
      // print(items);
      return items;
    }

    return Scaffold(
      appBar: new MyAppBar("Leave applications"),
      body:  Container(
          child: FutureBuilder(
            initialData: <Widget>[Text("")],
            future: createAdminLeaveList(),
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
