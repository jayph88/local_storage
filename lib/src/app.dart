import 'package:flutter/material.dart';
import 'package:local_storage/src/models/settings_model.dart';
import 'package:local_storage/src/screens/home.dart';
import 'package:local_storage/src/screens/material_color.dart';
import 'package:local_storage/src/screens/passwords.dart';

import 'blocs/settings_bloc.dart';
import 'screens/settings.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  static SettingsBloc bloc = SettingsBloc();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SettingsModel>(
        stream: bloc.settingsStream,
        initialData: SettingsModel(0xff2196f3, 16),
        builder: (context, snapshot) {
          return MaterialApp(
            theme: ThemeData(
                textTheme: TextTheme(
                    bodyText2: TextStyle(
                        fontSize: snapshot.hasData
                            ? snapshot.data!.size.toDouble()
                            : 16.toDouble())),

                // textTheme: TextTheme(bodyText2: TextStyle(fontSize: snapshot.data!.size.toDouble())), // data is null for few secs
                // primaryColor: Color(snapshot.hasData ? snapshot.data!.color : 0xff2196f3  ),
                appBarTheme: AppBarTheme(
                    // color:  Color(snapshot.data!.color ),
                    // listTileTheme: ListTileThemeData(),
                    ),
                // primaryColor: Color(snapshot.data!.color),
                primarySwatch:
                    createMaterialColor(Color(snapshot.data!.color))),


            routes: {
              "/settings": (BuildContext context) => Settings(),
              "/": (BuildContext context) => Home(),
              "/passwords": (BuildContext context) => PasswordsScreen()
            },
            initialRoute: "/",
          );
        });
  }
}
