import 'package:flutter/material.dart';


class APPDrawer extends StatelessWidget {
  const APPDrawer({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text("Password Manager"),
          ),
          ListTile(
            title: Text("Home"),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, "/");
            },
          ),
          ListTile(
            title: Text("Settings"),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, "/settings");},
          ),
          ListTile(
            title: Text("Passowrds"),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, "/passwords");},
          )
        ],
      ),
    );
  }
}
