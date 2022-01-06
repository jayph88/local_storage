import 'package:flutter/material.dart';
import 'package:local_storage/src/data/sembast_db.dart';
import 'package:local_storage/src/models/password_model.dart';
import 'package:local_storage/src/screens/password_detail.dart';


class PasswordsScreen extends StatefulWidget {
  const PasswordsScreen({Key? key}) : super(key: key);

  @override
  _PasswordsScreenState createState() => _PasswordsScreenState();
}

class _PasswordsScreenState extends State<PasswordsScreen> {
  static late SembastDb db;
  late Future<List<Password>> allPasswords;


  @override
  void initState() {
    db = SembastDb();

  }

  @override
  Widget build(BuildContext context) {
    allPasswords =  db.getPasswords();
    return Scaffold(
      appBar: AppBar(title: Text("Passwords"),),
      body: FutureBuilder(
        future: allPasswords,
        builder: (BuildContext context, AsyncSnapshot<List<Password>> snapshot) {
          print("rebuilding widget " + snapshot.hasData.toString());
          List<Password> passwords = snapshot.data ?? [];
          return ListView.builder(
              itemCount: snapshot.data == null ? 0 :  passwords.length,
              itemBuilder: (context, index) {
                return Dismissible(
                    key: Key(passwords[index].id.toString()),
                    onDismissed: (direction) {
                      db.deletePassword(passwords[index]);
                    },
                    child: ListTile(
                           title: Text(passwords[index].name),
                      onTap: () {
                        showDialog(context: context,
                            builder:(context) {
                              return PasswordDetail(
                                  passwords[index], false
                              );
                            }
                        );
                      },
                    )
                );
              },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          showDialog(context: context,
              builder:(context) {
           return PasswordDetail(
             Password("", ""), true
           );
          }
          );
        },
      ),
    );
  }
}

    