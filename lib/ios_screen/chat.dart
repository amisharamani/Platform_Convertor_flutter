import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Global.dart';
import '../providers/platform_convertor.dart';
import '../providers/themeprovider.dart';

class chat extends StatefulWidget {
  const chat({Key? key}) : super(key: key);

  @override
  State<chat> createState() => _personState();
}

class _personState extends State<chat> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Platform Convertor"),
        trailing: CupertinoSwitch(
          value: Provider.of<PlatformProvider>(context, listen: true).isIos,
          onChanged: (val) {
            Provider.of<PlatformProvider>(context, listen: false)
                .changePlatform(val);
          },
        ),
      ),
      child: Material(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: (Provider.of<ThemeProvider>(context).themeMode.isDark)
              ? Colors.white
              : Colors.black,
          child: (Globals.allchat.isNotEmpty)
              ? ListView.builder(
                  itemCount: Globals.allchat.length,
                  itemBuilder: (context, int i) {
                    return ListTile(
                      onTap: () {
                        showCupertinoModalPopup(
                            context: context,
                            builder: (context) {
                              return CupertinoActionSheet(
                                actions: [
                                  Container(
                                    height: 300,
                                    width: double.infinity,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        CircleAvatar(
                                          foregroundImage: (Globals
                                                      .allchat[i].myImage !=
                                                  null)
                                              ? FileImage(
                                                  Globals.allchat[i].myImage)
                                              : null,
                                          radius: 60,
                                          child: (Globals.allchat[i].myImage !=
                                                  null)
                                              ? Text("")
                                              : Icon(Icons.person),
                                          backgroundColor: Colors.grey.shade400,
                                        ),
                                        Text(
                                          Globals.allchat[i].name,
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        Text(
                                          Globals.allchat[i].chat,
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CupertinoButton(
                                                child:
                                                    Icon(CupertinoIcons.pencil),
                                                onPressed: () {}),
                                            CupertinoButton(
                                                child:
                                                    Icon(CupertinoIcons.delete),
                                                onPressed: () {
                                                  Globals.allchat.remove(
                                                      Globals.allchat[i]);
                                                  Navigator.of(context).pop();
                                                }),
                                          ],
                                        ),
                                        CupertinoButton(
                                            child: Text("Cancle"),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            }),
                                      ],
                                    ),
                                  )
                                  // CupertinoActionSheetAction(
                                  //     onPressed: () {},
                                  //     child: Text("Edit Page"))
                                ],
                              );
                            });
                      },
                      leading: CircleAvatar(
                        foregroundImage: (Globals.allchat[i].myImage != null)
                            ? FileImage(Globals.allchat[i].myImage)
                            : null,
                        radius: 60,
                        child: (Globals.allchat[i].myImage != null)
                            ? Text("")
                            : Icon(Icons.person),
                        backgroundColor: Colors.grey.shade400,
                      ),
                      title: Text(
                        Globals.allchat[i].name,
                        style: TextStyle(
                          fontSize: 20,
                          color: (Provider.of<ThemeProvider>(context)
                                  .themeMode
                                  .isDark)
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                      subtitle: Text(
                        Globals.allchat[i].chat,
                        style: TextStyle(color: Colors.grey),
                      ),
                      trailing: Text(
                        "${Globals.allchat[i].date.day}/${Globals.allchat[i].date.month}/${Globals.allchat[i].date.year}",
                        style: TextStyle(
                          color: (Provider.of<ThemeProvider>(context)
                                  .themeMode
                                  .isDark)
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "No any chat yet...",
                          style: TextStyle(
                            color: (Provider.of<ThemeProvider>(context)
                                    .themeMode
                                    .isDark)
                                ? Colors.black
                                : Colors.white,
                          ),
                        )
                      ]),
                ),
        ),
      ),
    );
  }
}
