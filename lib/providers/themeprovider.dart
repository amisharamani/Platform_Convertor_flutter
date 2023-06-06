import 'package:chat_app/models/thememodel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeModel themeMode;

  ThemeProvider({required this.themeMode});

  void changetheme() async {
    themeMode.isDark = !themeMode.isDark;

    SharedPreferences pref = await SharedPreferences.getInstance();

    pref.setBool("istheme", themeMode.isDark);

    notifyListeners();
  }
}
