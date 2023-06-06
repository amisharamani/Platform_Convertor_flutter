import 'package:chat_app/ios_screen/homepage.dart';
import 'package:chat_app/providers/platform_convertor.dart';
import 'package:chat_app/providers/themeprovider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'android_screens/home_page.dart';
import 'models/thememodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();
  bool istheme = pref.getBool("istheme") ?? false;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PlatformProvider()),
        ChangeNotifierProvider(
            create: (context) =>
                ThemeProvider(themeMode: ThemeModel(isDark: istheme))),
      ],
      child: Consumer<PlatformProvider>(
        builder: (context, value, _) => (value.isIos == false)
            ? MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  useMaterial3: true,
                  textTheme: TextTheme(
                      // displayLarge: TextStyle(
                      //   color: Colors.indigo,
                      //   fontSize: 50,
                      //   fontWeight: FontWeight.bold,
                      // ),
                      ),
                  // colorScheme: ColorScheme.light(
                  //   brightness: Brightness.light,
                  //   primary: Colors.greenAccent,
                  // ),
                ),
                darkTheme: ThemeData(
                  useMaterial3: true,
                  colorScheme: ColorScheme.dark(
                      // brightness: Brightness.light,
                      // primary: Colors.greenAccent,
                      ),
                ),
                themeMode:
                    (Provider.of<ThemeProvider>(context).themeMode.isDark)
                        ? ThemeMode.light
                        : ThemeMode.dark,
                routes: {
                  '/': (context) => HomePage(),
                },
              )
            : CupertinoApp(
                theme: CupertinoThemeData(
                  brightness:
                      (Provider.of<ThemeProvider>(context).themeMode.isDark)
                          ? Brightness.light
                          : Brightness.dark,
                ),
                debugShowCheckedModeBanner: false,
                home: HomePageios(),
              ),
      ),
    ),
  );
}
