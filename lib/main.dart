import 'dart:io';

import 'package:cat_vs_dog/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS)
      return CupertinoApp(
        home: MySplashScreen(),
        debugShowCheckedModeBanner: false,
        title: 'Cat VS Dog',
      );
    else
      return MaterialApp(
        title: 'Cat VS Dog',
        home: MySplashScreen(),
        debugShowCheckedModeBanner: false,
      );
  }
}
