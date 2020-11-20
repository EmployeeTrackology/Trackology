// import 'authentication_service.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(55);
  final name;
  MyAppBar(this.name);
  // print("Myappbar");
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(name,
          style: TextStyle(fontSize: 23, color: Colors.white, fontFamily: "Sansita")),
      backgroundColor: Color(0xff603F83),
      shadowColor: Colors.pink[200],
      leading:  IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
          iconSize: 30,
        ),
      actions: <Widget>[
        IconButton(
            padding: EdgeInsets.only(right: 15.0),
            icon: Icon(Icons.power_settings_new),
            iconSize: 30,
            color: Colors.white,
            onPressed: () {
              // context.read<AuthenticationService>().signOut();
              print("Quit");
              Navigator.pushNamed(context, "/");
            },
        )
      ]);
  }
}
