import 'package:flutter/material.dart';

class AppBarPanel extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(55);
  final name;
  AppBarPanel(this.name);
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(name,
            style: TextStyle(
                fontSize: 23, color: Colors.white, fontFamily: "Sansita")),
        backgroundColor: Color(0xff603F83),
        shadowColor: Colors.pink[200],
        leading:Icon(Icons.person, size: 32),
        actions: <Widget>[
          IconButton(
          padding: EdgeInsets.only(right: 20.0),
          icon: Icon(Icons.power_settings_new),
          iconSize: 30,
          color: Colors.white,
          onPressed: () {
            print("Quit");
            Navigator.pushNamed(context, "/");
          },
        ),
              
      ]);
  }
}
