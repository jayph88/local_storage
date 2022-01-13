import 'package:flutter/material.dart';
import 'package:local_storage/src/data/sembast_db.dart';


class APPDrawer extends StatelessWidget {
  APPDrawer({Key? key}) : super(key: key);
  var db = SembastDb();

  @override
  Widget build(BuildContext context) {
    Widget home = ListTile(
      title: Text("Home"),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, "/");
      },
    );

    Widget setting = ListTile(
      title: Text("Settings"),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, "/settings");},
    );

    Widget password = ListTile(
      title: Text("Passwords"),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, "/passwords");},
    );

    Widget header = DrawerHeader(
      decoration: BoxDecoration(color: Colors.blue),
      child: Text("Password Manager"),
    );

    List<Widget> drawerWidgets = [header, home, password, setting];
    if (!db.isDbInitialized) {
      drawerWidgets.remove(password);
    }
    return Drawer(
      child: ListView(
        children: drawerWidgets
      ),
    );
  }
}
