import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS)
      return CupertinoPageScaffold(
        child: HomeBody(),
      );
    else
      return Scaffold(
        body: HomeBody(),
      );
  }
}

class HomeBody extends StatefulWidget {
  const HomeBody({
    Key key,
  }) : super(key: key);

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  bool _loading = true;
  File _image;
  List _output;
  final _picker = ImagePicker();

  Future classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.5,
      imageStd: 127.5,
      imageMean: 127.5,
    );
    setState(() {
      _output = output;
      _loading = false;
    });
  }

  Future loadModel() async {
    await Tflite.loadModel(
      model: 'assets/tflite/model_unquant.tflite',
      labels: 'assets/tflite/labels.txt',
    );
  }

  @override
  void initState() {
    loadModel().then((value) {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
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
              child: _loading
                  ? Column(
                      children: [
                        Image.asset('assets/cat.png'),
                        SizedBox(
                          height: 50,
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        Container(
                          height: 250,
                          child: Image.file(
                            _image,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        _output != null
                            ? Text(
                                '${_output[0]}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              )
                            : Container(),
                      ],
                    ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    color: Colors.amber[600],
                    onPressed: pickGalleryImage,
                    child: Text(
                      'Take a photo',
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
                    onPressed: pickImage,
                    child: Text(
                      'Camera Roll',
                      style: TextStyle(color: Colors.white, fontSize: 20),
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

  Future pickImage() async {
    var image = await _picker.getImage(
      source: ImageSource.camera,
    );
    if (image == null) return null;
    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image);
  }

  Future pickGalleryImage() async {
    var image = await _picker.getImage(
      source: ImageSource.gallery,
    );
    if (image == null) return null;
    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image);
  }
}
