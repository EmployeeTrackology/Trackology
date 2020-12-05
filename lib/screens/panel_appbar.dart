import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppBarPanel extends StatelessWidget implements PreferredSizeWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Size get preferredSize => const Size.fromHeight(55);
  final name;
  AppBarPanel(this.name);
    @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(name,
            style: TextStyle(
                fontSize: 23, color: Colors.white, fontFamily: "Sansita")),
        backgroundColor: Color(0xff603F83),
        shadowColor: Colors.pink[200],
        leading: Icon(Icons.person, size: 32),
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.only(right: 20.0),
            icon: Icon(Icons.power_settings_new),
            iconSize: 30,
            color: Colors.white,
            onPressed: () {
              //Confiramtion Dailoag 
              _exitApp(context);
            },
          ),
        ]);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
   Future<bool> _exitApp(BuildContext context) {
    return showDialog(
          context: context,
          child: AlertDialog(
            title: Text('Do you want to exit this application?'),
            content: Text('See you again...'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  print("you choose no");
                  Navigator.of(context).pop(false);
                },
                child: Text('No'),
              ),
              FlatButton(
                onPressed: () {
                  signOut();
                  print("Quit");
                  Navigator.pushNamed(context, "/");
                 
                },
                child: Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }


}
