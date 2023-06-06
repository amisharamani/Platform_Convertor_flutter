import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformProvider extends ChangeNotifier {
  bool isIos = true;
  int page = 0;
  DateTime initialDate = DateTime.now();
  TimeOfDay initialTime = TimeOfDay.now();

  void changePlatform(bool n) {
    isIos = n;
    notifyListeners();
  }

  void selectedpage(int n) {
    page = n;
    notifyListeners();
  }

  void pickDate(DateTime n) {
    initialDate = n;
    notifyListeners();
  }

  void pickTime(TimeOfDay n) {
    initialTime = n;
    notifyListeners();
  }
}
