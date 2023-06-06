import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../Global.dart';
import '../chat_list.dart';
import '../providers/platform_convertor.dart';

class person extends StatefulWidget {
  const person({Key? key}) : super(key: key);

  @override
  State<person> createState() => _personState();
}

class _personState extends State<person> {
  GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  PageController pageController = PageController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController chatController = TextEditingController();

  final ImagePicker picker = ImagePicker();
  File? imgFile;
  late String name;
  late String chat;
  // late File picimg;
  late String phone;
  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();

  // late TimeOfDay time;
  // late DateTime date;
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
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          alignment: Alignment.center,
          child: Column(
            children: [
              Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 120,
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
                                        ImagePicker picker = ImagePicker();
                                        XFile? xfile = await picker.pickImage(
                                            source: ImageSource.camera);
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
                                        ImagePicker picker = ImagePicker();
                                        XFile? xfile = await picker.pickImage(
                                            source: ImageSource.gallery);
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
                      foregroundImage:
                          (imgFile == null) ? null : FileImage(imgFile as File),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CupertinoTextFormFieldRow(
                      placeholder: "Full Name",
                      prefix: Icon(CupertinoIcons.person),
                      decoration: BoxDecoration(
                        border: Border.all(),
                      ),
                      controller: nameController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter your Name";
                        }
                        return null;
                      },
                      onSaved: (val) {
                        setState(() {
                          name = val!;
                        });
                      },
                    ),
                    CupertinoTextFormFieldRow(
                      placeholder: "Phone Number",
                      prefix: Icon(CupertinoIcons.phone),
                      decoration: BoxDecoration(
                        border: Border.all(),
                      ),
                      controller: phoneController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter your Phone Number...";
                        }
                        return null;
                      },
                      onSaved: (val) {
                        setState(() {
                          phone = val!;
                        });
                      },
                    ),
                    CupertinoTextFormFieldRow(
                      placeholder: "Chat Conversion",
                      prefix: Icon(CupertinoIcons.person),
                      decoration: BoxDecoration(
                        border: Border.all(),
                      ),
                      controller: chatController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter your Chat...";
                        }
                        return null;
                      },
                      onSaved: (val) {
                        setState(() {
                          chat = val!;
                        });
                      },
                    ),
                    Row(
                      children: [
                        Material(
                          child: IconButton(
                            onPressed: () {
                              showCupertinoModalPopup(
                                context: context,
                                builder: (context) {
                                  return CupertinoActionSheet(
                                    title: Text("Pick Date"),
                                    message: Container(
                                      height: 200,
                                      child: CupertinoDatePicker(
                                        onDateTimeChanged: (DateTime date) {
                                          Provider.of<PlatformProvider>(context,
                                                  listen: false)
                                              .pickDate(date);
                                        },
                                        initialDateTime:
                                            Provider.of<PlatformProvider>(
                                                    context,
                                                    listen: true)
                                                .initialDate,
                                        mode: CupertinoDatePickerMode.date,
                                      ),

                                      // date = pickdate;
                                    ),
                                    actions: [
                                      CupertinoActionSheetAction(
                                        isDestructiveAction: true,
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("exit"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            icon: Icon(CupertinoIcons.calendar),
                          ),
                        ),
                        Text("Pick date"),
                      ],
                    ),
                    Row(
                      children: [
                        Material(
                          child: IconButton(
                            onPressed: () {
                              showCupertinoModalPopup(
                                context: context,
                                builder: (context) {
                                  return CupertinoActionSheet(
                                    title: Text("Pick Time"),
                                    message: Container(
                                      height: 200,
                                      child: CupertinoDatePicker(
                                        onDateTimeChanged: (DateTime date) {
                                          Provider.of<PlatformProvider>(context,
                                                  listen: false)
                                              .pickDate(date);
                                        },
                                        initialDateTime:
                                            Provider.of<PlatformProvider>(
                                                    context,
                                                    listen: true)
                                                .initialDate,
                                        mode: CupertinoDatePickerMode.time,
                                      ),
                                    ),
                                    actions: [
                                      CupertinoActionSheetAction(
                                        isDestructiveAction: true,
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("exit"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            icon: Icon(CupertinoIcons.time),
                          ),
                        ),
                        Text("Pick Time"),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CupertinoButton(
                          child: Text("Save"),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              chat_list c1 = chat_list(
                                  name: name,
                                  myImage: imgFile as File,
                                  chat: chat,
                                  phone: phone,
                                  date: date,
                                  time: time);
                              Globals.allchat.add(c1);
                            }
                          },
                        ),
                        CupertinoButton(
                          child: Text("Resent"),
                          onPressed: () {
                            formKey.currentState!.reset();
                            nameController.clear();
                            phoneController.clear();
                            chatController.clear();

                            setState(() {});
                          },
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
