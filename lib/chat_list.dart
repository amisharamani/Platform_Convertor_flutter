import 'dart:io';

import 'package:flutter/material.dart';

class chat_list {
  final String name;
  // final String bio;
  final String phone;
  final String chat;
  final File myImage;
  final TimeOfDay time;
  final DateTime date;

  chat_list({
    required this.name,
    // this.bio,
    required this.myImage,
    required this.chat,
    required this.phone,
    required this.date,
    required this.time,
  });
}
