import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';


class SPSettings {
  final String colorKey = "font_color";
  final String textSizeKey = "text_size";
  final String isMasterSetKey = "master";
  static SPSettings? _instance;
  late SharedPreferences _sp;
  SPSettings._internal();

  factory SPSettings() {
    if (_instance == null) {
      _instance = SPSettings._internal();
    }
    return _instance as SPSettings;
  }

  Future init() async{
    _sp = await SharedPreferences.getInstance();
  }

  Future setSPColor(int color) async{
    await _sp.setInt(colorKey, color);
  }

  int getSPColor() {
    int? value = _sp.getInt(colorKey);
    value ??= 0xffffebee;
    return value;
  }

  Future setSize(int size) async {
    await _sp.setInt(textSizeKey, size);
  }

  int getSPSize() {
    int? size = _sp.getInt(textSizeKey);
    size ??= 16;
    return size;
  }

  Future setMaster() async {
    await _sp.setBool(isMasterSetKey, true);
  }

  bool getMaster() {
    bool? isMasterSet = _sp.getBool(isMasterSetKey);
    return isMasterSet ?? false;
  }

}
