import 'package:chat_app/ios_screen/chat.dart';
import 'package:chat_app/ios_screen/setting.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../providers/platform_convertor.dart';
import 'add_person.dart';
import 'call.dart';

class HomePageios extends StatefulWidget {
  const HomePageios({Key? key}) : super(key: key);

  @override
  State<HomePageios> createState() => _HomePageiosState();
}

class _HomePageiosState extends State<HomePageios> {
  List<Widget> pages = [person(), chat(), call(), setting()];
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        currentIndex: Provider.of<PlatformProvider>(context).page,
        onTap: (val) {
          Provider.of<PlatformProvider>(context, listen: false)
              .selectedpage(val);
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person), label: "ADD"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.chat_bubble_text), label: "Chat"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.phone), label: "Call"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.settings), label: "Setting"),
        ],
      ),
      tabBuilder: (context, index) => CupertinoTabView(
        builder: (BuildContext) {
          return pages[index];
        },
      ),
    );
  }
}
