import 'dart:io';

import 'package:cat_vs_dog/service/image_classify_service.dart';
import 'package:cat_vs_dog/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider<ImageClassifyService>(
      create: (context) => ImageClassifyService(),
      child: MyApp(),
    ),
  );
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
