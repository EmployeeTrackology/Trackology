import 'dart:convert';
import 'package:flutter/material.dart';
import "panel_appbar.dart";

class FunctionRow extends StatelessWidget {
  final String name,desc,img,path;
  FunctionRow(this.name, this.desc, this.img, this.path);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular((10.0))),
          boxShadow: [
            BoxShadow(color: Colors.black12),
          ]),
      margin: EdgeInsets.all(5.0),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, path);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(img, width: 80, height: 80),
            Container(
              padding: EdgeInsets.all(8),
              width: 250,
              height: 110, 
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(name, style: TextStyle(fontSize: 23.0)),
                    SizedBox(height:5),
                      Text(
                        desc,
                        style: TextStyle(fontSize: 18.0, color: Colors.black54),
                      ), 
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}

class AdminPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<List<Widget>> adminFnList() async {
      List<Widget> items = new List<Widget>();
      String fn = await DefaultAssetBundle.of(context)
          .loadString("data_json/admin_fn.json");
      List<dynamic> fnJson = jsonDecode(fn);
      fnJson.forEach((obj) {
        items.add(
          FunctionRow(obj['name'],obj['desc'],obj['img'],obj['path'])
        );
      });
      // print(items);
      return items;
    }
    return Scaffold(
      appBar: new AppBarPanel("Admin Panel"),
      body: Container(
          child: FutureBuilder(
          initialData: <Widget>[Text("")],
          future: adminFnList(),
          builder: (context, snapshot) {
            print("Admin function");
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
      )
    );
  }
}


