// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/src/helper/slider_app_bar.dart';

final topAppBar = SliderAppBar(
  appBarColor: const Color.fromRGBO(58, 66, 86, 1.0),
  appBarHeight: 90,
  drawerIconSize: 30,
  drawerIconColor: Colors.yellowAccent,
  title: const Text(
    'Udhar please',
    style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
  ),
);
