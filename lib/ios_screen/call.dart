import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Global.dart';
import '../providers/platform_convertor.dart';
import '../providers/themeprovider.dart';

class call extends StatefulWidget {
  const call({Key? key}) : super(key: key);

  @override
  State<call> createState() => _personState();
}

class _personState extends State<call> {
  final ImagePicker picker = ImagePicker();
  File? imgFile;
  late File picimg;

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
          height: double.infinity,
          width: double.infinity,
          color: (Provider.of<ThemeProvider>(context).themeMode.isDark)
              ? Colors.white
              : Colors.black,
          child: (Globals.allchat.isNotEmpty)
              ? ListView.builder(
                  itemCount: Globals.allchat.length,
                  itemBuilder: (context, int i) {
                    return ListTile(
                      onTap: () {
                        // Navigator.of(context).pushNamed('history_page',
                        //     arguments: Globals.allchat[i]);
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
                      trailing: IconButton(
                        onPressed: () async {
                          await launchUrl(
                              Uri.parse("tel:+91${Globals.allchat[i].phone}"));
                        },
                        icon: Icon(
                          Icons.call,
                          size: 25,
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
                          "No any call yet...",
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
