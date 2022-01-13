import 'package:flutter/material.dart';
import 'package:local_storage/src/blocs/settings_bloc.dart';
import 'package:local_storage/src/data/shared_prefs.dart';
import 'package:local_storage/src/models/settings_model.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int settingColor = 0xff2196f3;
  final List<int>  listTextSize = [10,14, 16, 22, 25];
  List<int> listSettingColor = [
    0xff2196f3,
    0xff9c27b0,
    0xfff44336,
    0xff00bcd4,
    0xff4caf50
  ];

  SPSettings sp = SPSettings();
  late int textSize ;
  late SettingsBloc bloc ;



  @override
  void initState() {

    bloc = SettingsBloc();
    textSize = sp.getSPSize() ;
    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    Widget getColorbox(int color) {
      return GestureDetector(
        onTap: () {
          bloc.addColor(color);
        },
        child: Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Color(color)),
        ),
      );
    }



    return Scaffold(
                appBar: AppBar(
                  title: Text('Settings'),
                ),
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Text Size"),
                    DropdownButton(
                      value: textSize,
                      onChanged: (int? newValue) {
                        setState(() {
                          textSize = newValue!;
                          bloc.addSize(newValue);
                        });
                      },
                        items: listTextSize
                            .map((e) => DropdownMenuItem<int>(
                                  child: Text(e.toString(), style: TextStyle(fontSize: textSize.toDouble())),
                                  value: e,
                                  )
                        ).toList()),
                    Text("pick color"),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: listSettingColor
                            .map((color) => getColorbox(color))
                            .toList()),
                  ],
                )
            );

}

}
