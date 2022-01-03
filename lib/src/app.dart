import 'package:flutter/material.dart';
import 'package:local_storage/src/models/settings_model.dart';

import 'blocs/settings_bloc.dart';
import 'screens/settings.dart';


class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  static SettingsBloc bloc = SettingsBloc();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SettingsModel>(
      stream: bloc.settingsStream,
      builder: (context, snapshot) {
        return MaterialApp(
          theme: ThemeData(
              textTheme: TextTheme(bodyText2: TextStyle(fontSize: snapshot.hasData ? snapshot.data!.size.toDouble(): 16.toDouble())),
               // primaryColor: Color(snapshot.hasData ? snapshot.data!.color : 0xff2196f3  ),
              appBarTheme: AppBarTheme(
              color:  Color(snapshot.hasData ? snapshot.data!.color : 0xff2196f3 ),
                  // listTileTheme: ListTileThemeData(),

              )

          ),
          routes: {
            "/" : (BuildContext context) => Settings(),
          },
          initialRoute: "/",
        );
      }
    );
  }
}
