import 'dart:io';

import 'package:chat_app/providers/platform_convertor.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Global.dart';
import '../chat_list.dart';
import '../providers/themeprovider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
  late File picimg;
  late String phone;
  late TimeOfDay time;
  late DateTime date;

  @override
  Widget build(BuildContext context) {
    // chat_list con = ModalRoute.of(context)!.settings.arguments as chat_list;
    return Scaffold(
      key: scaffoldkey,
      appBar: AppBar(
        title: Text("Platform Convertor"),
        actions: [
          Switch(
            value: Provider.of<PlatformProvider>(context, listen: true).isIos,
            onChanged: (val) {
              Provider.of<PlatformProvider>(context, listen: false)
                  .changePlatform(val);
            },
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        currentIndex: Provider.of<PlatformProvider>(context).page,
        onTap: (val) {
          Provider.of<PlatformProvider>(context, listen: false)
              .selectedpage(val);
          pageController.animateToPage(val,
              duration: Duration(milliseconds: 400), curve: Curves.bounceInOut);
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.person_add_alt_1_rounded), label: "ADD"),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chats"),
          BottomNavigationBarItem(icon: Icon(Icons.call), label: "Call"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Setting"),
        ],
      ),
      body: PageView(
        controller: pageController,
        children: [
          SingleChildScrollView(
            child: Container(
                margin: EdgeInsets.all(15),
                child: Column(
                  children: [
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.grey,
                            child: FloatingActionButton(
                              backgroundColor: Colors.grey,
                              elevation: 0,
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
                              child: Icon(
                                Icons.camera_alt_outlined,
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
                          TextFormField(
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
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              labelText: "Full Name",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
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
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.call),
                              labelText: "Phone Number",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
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
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.chat),
                              labelText: "Chat Conversion",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () async {
                                  DateTime? pickdate = await showDatePicker(
                                    context: context,
                                    initialDate: Provider.of<PlatformProvider>(
                                            context,
                                            listen: false)
                                        .initialDate,
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2050),
                                  );
                                  Provider.of<PlatformProvider>(context,
                                          listen: false)
                                      .pickDate(pickdate!);
                                  date = pickdate;
                                },
                                icon: Icon(
                                  Icons.date_range,
                                  size: 30,
                                ),
                              ),
                              Text(
                                "${Provider.of<PlatformProvider>(context).initialDate.day}/${Provider.of<PlatformProvider>(context).initialDate.month}/${Provider.of<PlatformProvider>(context).initialDate.year}",
                                style: TextStyle(fontSize: 17),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () async {
                                  TimeOfDay? pickedTime = await showTimePicker(
                                    context: context,
                                    initialTime: Provider.of<PlatformProvider>(
                                            context,
                                            listen: false)
                                        .initialTime,
                                  );
                                  Provider.of<PlatformProvider>(context,
                                          listen: false)
                                      .pickTime(pickedTime!);

                                  time = pickedTime;
                                },
                                icon: Icon(
                                  Icons.watch_later_outlined,
                                  size: 30,
                                ),
                              ),
                              Text(
                                "${Provider.of<PlatformProvider>(context).initialTime.hour}:${Provider.of<PlatformProvider>(context).initialTime.minute}",
                                style: TextStyle(fontSize: 17),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                chat_list c1 = chat_list(
                                    name: name,
                                    myImage: picimg as File,
                                    chat: chat,
                                    phone: phone,
                                    date: date,
                                    time: time);
                                Globals.allchat.add(c1);
                              }
                            },
                            child: Text("Save"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              formKey.currentState!.reset();
                              nameController.clear();
                              phoneController.clear();
                              chatController.clear();

                              setState(() {});
                            },
                            child: Text("Resent"),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
          ),
          Container(
            child: (Globals.allchat.isNotEmpty)
                ? ListView.builder(
                    itemCount: Globals.allchat.length,
                    itemBuilder: (context, int i) {
                      return ListTile(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                height: 300,
                                width: 400,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    CircleAvatar(
                                      foregroundImage:
                                          (Globals.allchat[i].myImage != null)
                                              ? FileImage(
                                                  Globals.allchat[i].myImage)
                                              : null,
                                      radius: 60,
                                      child:
                                          (Globals.allchat[i].myImage != null)
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
                                        IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.edit),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            Globals.allchat
                                                .remove(Globals.allchat[i]);
                                            Navigator.of(context).pop();
                                            setState(() {});
                                          },
                                          icon: Icon(Icons.delete),
                                        ),
                                      ],
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Cancel"),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
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
                          style: TextStyle(fontSize: 20),
                        ),
                        subtitle: Text(
                          Globals.allchat[i].chat,
                          style: TextStyle(color: Colors.grey),
                        ),
                        trailing: Text(
                            "${Globals.allchat[i].date.day}/${Globals.allchat[i].date.month}/${Globals.allchat[i].date.year}"),
                      );
                    },
                  )
                : Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text("No any chat yet...")]),
                  ),
          ),
          Container(
            child: (Globals.allchat.isNotEmpty)
                ? ListView.builder(
                    itemCount: Globals.allchat.length,
                    itemBuilder: (context, int i) {
                      return ListTile(
                        onTap: () {
                          Navigator.of(context).pushNamed('history_page',
                              arguments: Globals.allchat[i]);
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
                          style: TextStyle(fontSize: 20),
                        ),
                        subtitle: Text(
                          Globals.allchat[i].chat,
                          style: TextStyle(color: Colors.grey),
                        ),
                        trailing: IconButton(
                          onPressed: () async {
                            await launchUrl(Uri.parse(
                                "tel:+91${Globals.allchat[i].phone}"));
                          },
                          icon: Icon(
                            Icons.call,
                            size: 25,
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text("No any call yet...")]),
                  ),
          ),
          Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(14),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.person,
                              size: 25,
                              color: Colors.grey,
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
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            Switch(
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 30,
                                    ),
                                    CircleAvatar(
                                      radius: 60,
                                      backgroundColor: Colors.grey,
                                      child: FloatingActionButton(
                                        backgroundColor: Colors.grey,
                                        elevation: 0,
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
                                        child: Icon(
                                          Icons.camera_alt_outlined,
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
                                    TextFormField(
                                      controller: nameController,
                                      textAlign: TextAlign.center,
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
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Enter your Name.."),
                                    ),
                                    TextFormField(
                                      controller: nameController,
                                      textAlign: TextAlign.center,
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
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Enter your Bio.."),
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
                              Icons.light_mode_outlined,
                              size: 25,
                              color: Colors.grey,
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
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            Switch(
                                value: Globals.isdeclaretheme,
                                onChanged: (val) {
                                  Provider.of<ThemeProvider>(context,
                                          listen: false)
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
        ],
      ),
    );
  }
}
