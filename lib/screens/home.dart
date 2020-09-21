import 'dart:io';

import 'package:cat_vs_dog/service/image_classify_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final backgroudColor = Colors.black87;
  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS)
      return CupertinoPageScaffold(
        backgroundColor: backgroudColor,
        child: SafeArea(
          child: HomeBody(),
        ),
      );
    else
      return Scaffold(
        backgroundColor: backgroudColor,
        body: SafeArea(
          child: HomeBody(),
        ),
      );
  }
}

class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _imageService = Provider.of<ImageClassifyService>(context);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              'TeachableMachine.com CNN',
              style: TextStyle(
                fontSize: 16,
                color: Colors.amber[50],
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              'detect Dogs and Cats',
              style: TextStyle(
                fontSize: 24,
                color: Colors.amber[600],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Consumer<ImageClassifyService>(
                  builder: (context, value, child) {
                if (value.image == null || value.output == null) {
                  return Column(
                    children: [
                      Image.asset('assets/cat.png'),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  );
                } else if (value.output != null) {
                  return Column(
                    children: [
                      Container(
                        height: 250,
                        child: Image.file(
                          value.image,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        '${value.output[0]['label']}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      )
                    ],
                  );
                } else
                  return Container();
              }),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    color: Colors.amber[600],
                    onPressed: _imageService.pickGalleryImage,
                    child: Text(
                      'Choose a photo',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RaisedButton(
                    color: Colors.amber[600],
                    onPressed: _imageService.pickImage,
                    child: Text(
                      'Camera Roll',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
