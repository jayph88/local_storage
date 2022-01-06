import 'dart:async';

import 'package:local_storage/src/models/password_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class SembastDb {
   late Database db;
   bool isDbInitialized = false;
  // late Completer<Database> _dbOpenCompleter;
  var store = intMapStoreFactory.store('my_store');
  static SembastDb _singelton = SembastDb._internal();

  SembastDb._internal() {
    // getApplicationDocumentsDirectory().then((value)  {
    //   final dbPath = join(value.path, 'pass.db');
    //   databaseFactoryIo.openDatabase(dbPath).then((value) {
    //     db = value;
    //   });
    // });
  }

  factory SembastDb() {
    return _singelton;
  }

  Future<void> _openDb() async {
    if (isDbInitialized == false) {
      final docsDir = await getApplicationDocumentsDirectory();
      final dbPath = join(docsDir.path, 'pass.db');
      db = await databaseFactoryIo.openDatabase(dbPath);
      isDbInitialized = true;
    }
  }

  Future<int> addPassword(Password password) async {
    print("adding password");
    int id = await store.add(db, password.toMap());
    print("password added ");
    return id;
  }

  Future<List<Password>> getPasswords() async {
    print("i get called");
    await _openDb();
    final finder = Finder(sortOrders: [SortOrder('name')]);
    final snapshot = await store.find(db, finder: finder);
    return snapshot.map((field) {
      var password = Password.fromMap(field.value);
      password.id = field.key;
      return password;
    }).toList();
  }

  Future updatePassword(Password password) async{
    final finder = Finder(filter: Filter.byKey(password.id));
    await store.update(db, password.toMap(), finder: finder);
    print("update completed");
  }

  Future deletePassword(Password password) async{
    final finder = Finder(filter: Filter.byKey(password.id));
    await store.delete(db, finder: finder);
  }

}
