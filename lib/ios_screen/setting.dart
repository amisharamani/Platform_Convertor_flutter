import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../Global.dart';
import '../providers/platform_convertor.dart';
import '../providers/themeprovider.dart';

class setting extends StatefulWidget {
  const setting({Key? key}) : super(key: key);

  @override
  State<setting> createState() => _personState();
}

class _personState extends State<setting> {
  PageController pageController = PageController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  final ImagePicker picker = ImagePicker();
  File? imgFile;
  late String name;
  late String chat;
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
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 120,
              ),
              Container(
                margin: EdgeInsets.all(14),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          CupertinoIcons.person,
                          size: 25,
                          color: CupertinoColors.inactiveGray,
                        ),
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Profile",
                                style: TextStyle(
                                  fontSize: 22,
                                ),
                              ),
                              Text(
                                "Update Profile Data",
                                style: TextStyle(
                                  color: CupertinoColors.inactiveGray,
                                ),
                              ),
                            ],
                          ),
                        ),
                        CupertinoSwitch(
                            value: Globals.isdeclareprofile,
                            onChanged: (val) {
                              setState(() {
                                if (val == false) {
                                  Globals.bl = 10;
                                } else {
                                  Globals.bl = 0;
                                }
                                Globals.isdeclareprofile = val;
                              });
                            }),
                      ],
                    ),
                    (Globals.isdeclareprofile == true)
                        ? Form(
                            key: formKey,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 30,
                                ),
                                CircleAvatar(
                                  radius: 60,
                                  backgroundColor: CupertinoColors.activeBlue,
                                  child: FloatingActionButton(
                                    backgroundColor: CupertinoColors.activeBlue,
                                    elevation: 0,
                                    onPressed: () {
                                      showCupertinoModalPopup(
                                          context: context,
                                          builder: (context) {
                                            return CupertinoActionSheet(
                                              title: Text("Pick the Image"),
                                              actions: [
                                                CupertinoActionSheetAction(
                                                  onPressed: () async {
                                                    ImagePicker picker =
                                                        ImagePicker();
                                                    XFile? xfile =
                                                        await picker.pickImage(
                                                            source: ImageSource
                                                                .camera);
                                                    String path = xfile!.path;
                                                    setState(() {
                                                      imgFile = File(path);
                                                    });
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text(
                                                    "Pick the Camera",
                                                  ),
                                                ),
                                                CupertinoActionSheetAction(
                                                  onPressed: () async {
                                                    ImagePicker picker =
                                                        ImagePicker();
                                                    XFile? xfile =
                                                        await picker.pickImage(
                                                            source: ImageSource
                                                                .gallery);
                                                    String path = xfile!.path;
                                                    setState(() {
                                                      imgFile = File(path);
                                                    });
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text(
                                                    "Pick the Gallery",
                                                  ),
                                                ),
                                                CupertinoActionSheetAction(
                                                  isDestructiveAction: true,
                                                  onPressed: () {
                                                    imgFile = null;
                                                  },
                                                  child: Text(
                                                    "Remove the Image",
                                                  ),
                                                ),
                                              ],
                                            );
                                          });
                                    },
                                    child: Icon(
                                      CupertinoIcons.camera,
                                      size: 30,
                                    ),
                                  ),
                                  foregroundImage: (imgFile == null)
                                      ? null
                                      : FileImage(imgFile as File),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                CupertinoTextFormFieldRow(
                                  placeholder: "Enter your Name..",
                                  controller: nameController,
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "Enter your Name";
                                    }
                                    return null;
                                  },
                                  onSaved: (val) {
                                    setState(() {
                                      Globals.name = val!;
                                    });
                                  },
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                  ),
                                ),
                                CupertinoTextFormFieldRow(
                                  placeholder: "Enter your Bio..",
                                  controller: nameController,
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "Enter your Bio...";
                                    }
                                    return null;
                                  },
                                  onSaved: (val) {
                                    setState(() {
                                      Globals.bio = val!;
                                    });
                                  },
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
              Divider(),
              Container(
                margin: EdgeInsets.all(14),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          CupertinoIcons.sun_min,
                          size: 25,
                          color: CupertinoColors.inactiveGray,
                        ),
                        Container(
                          child: Column(
                            children: [
                              Text(
                                "Theme",
                                style: TextStyle(
                                  fontSize: 22,
                                ),
                              ),
                              Text(
                                "Change Theme",
                                style: TextStyle(
                                    color: CupertinoColors.inactiveGray),
                              ),
                            ],
                          ),
                        ),
                        CupertinoSwitch(
                            value: Globals.isdeclaretheme,
                            onChanged: (val) {
                              Provider.of<ThemeProvider>(context, listen: false)
                                  .changetheme();
                              setState(() {
                                Globals.isdeclaretheme = val;
                              });
                            }),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
