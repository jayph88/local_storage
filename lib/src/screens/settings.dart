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
  List<int> listSettingColor = [
    0xff2196f3,
    0xff9c27b0,
    0xfff44336,
    0xff00bcd4,
    0xff4caf50
  ];

  // SPSettings sp = SPSettings();
  SettingsBloc bloc = SettingsBloc();

  // void setColor(int color){
  //   setState(() {
  //     settingColor = color;
  //     sp.setSPColor(color);
  //   });
  // }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // sp.init().then((color) {
    //   setState(() {
    //     settingColor = sp.getSPColor();
    //   });
    // });
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

    ;

    return StreamBuilder<SettingsModel>(
        stream: bloc.settingsStream,
        // initialData: 0xff2196f3,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
                appBar: AppBar(
                  title: Text('Settings', style: TextStyle(fontSize:snapshot.data!.size.toDouble() ),),
                  backgroundColor: Color(snapshot.data!.color),
                ),
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Text Size"),
                    DropdownButton(
                      value: snapshot.data!.size,
                      onChanged: (int? value) {
                        bloc.addSize(value!);
                      },
                        items: snapshot.data!.listTextSize
                            .map((e) => DropdownMenuItem<int>(
                                  child: Text(e.toString()),
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
                ));
          } else {
            return Scaffold(
              appBar: AppBar(
                title: Text("waiting"),
              ),
            );
          }
        });
  }
}

class ColorBox extends StatelessWidget {
  final int color;
  final ValueSetter<int> _onTap;

  const ColorBox(this.color, this._onTap, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onTap(color),
      child: Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Color(color)),
      ),
    );
  }
}
