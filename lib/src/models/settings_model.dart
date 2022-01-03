class SettingsModel{
  List<int> listColor = [0xff2196f3, 0xff9c27b0, 0xfff44336, 0xff00bcd4, 0xff4caf50];
  List<int>  listTextSize = [10,12, 16, 18, 20];
  late int color;
  late int size;
  SettingsModel(this.color, this.size);

  // singelton implementation
  // static  SettingsModel _instance  = SettingsModel._internal();
  //
  // factory SettingsModel(int color, int size) {
  //   _instance.size = size;
  //   _instance.color = color;
  //   return _instance;
  // }
  //
  // SettingsModel._internal();
}