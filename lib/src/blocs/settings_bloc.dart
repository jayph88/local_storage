import 'dart:async';

import 'package:local_storage/src/data/shared_prefs.dart';
import 'package:local_storage/src/models/settings_model.dart';


class SettingsBloc {
  late SPSettings sp;

  StreamController<SettingsModel> _settingsController = StreamController.broadcast();

  Stream<SettingsModel> get settingsStream => _settingsController.stream;
  StreamSink<SettingsModel> get settingsSink => _settingsController.sink;
  SettingsModel settings = SettingsModel(0xffffebee, 16);
  static SettingsBloc _instance = SettingsBloc._internal();

  SettingsBloc._internal() {
    sp = SPSettings();
    sp.init().then((value) {
      settings.color = sp.getSPColor();
      settings.size = sp.getSPSize();
      settingsSink.add(settings);
    });
  }

  factory SettingsBloc() {
    if (_instance == null) {
      _instance = SettingsBloc._internal();
    }
    return _instance as SettingsBloc;
  }



  // SettingsBloc() {
  //   sp = SPSettings();
  //   sp.init().then((value) {
  //     settings.color = sp.getSPColor();
  //     settings.size = sp.getSPSize();
  //     settingsSink.add(settings);
  //   });
    // colorStream.listen(addColor);


  void addColor(int color) {
    settings.color = color;
    settingsSink.add(settings);
    // settingsSink.add(SettingsModel(color, 15 ));
    sp.setSPColor(color);
  }

  void addSize(int size) {
    settings.size = size;
    settingsSink.add(settings);
    // settingsSink.add(SettingsModel(color, 15 ));
    sp.setSize(size);
  }

  void dispose() {
    _settingsController.close();
  }
}