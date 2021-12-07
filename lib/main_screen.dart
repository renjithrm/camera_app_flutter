// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';

import 'package:image_picker/image_picker.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  File? imageGet;
  Future getImageCamera() async {
    final imageGet = await ImagePicker().pickImage(source: ImageSource.camera);
    if (imageGet == null) return;
    final imagePath = File(imageGet.path);
    setState(() {
      if (imageGet != null) {
        this.imageGet = imagePath;
        GallerySaver.saveImage(imageGet.path, albumName: "images");
      }
    });
  }
//==============================================================================
//to find find the path of image to save in out local phone storage

  // Future permanentFile(imagePath) async {
  //   final directoryPage = await getApplicationDocumentsDirectory();
  //   final fileName = basename(imagePath);
  //   final image = File('${directoryPage.path}/$fileName');
  //   return File(imagePath).copy(image.path);
  // }
//==============================================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => getImageCamera(),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        child: Center(
          child: Icon(
            Icons.camera,
            size: 55,
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 8,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.amber[200],
          child: imageGet != null
              ? Center(
                  child: Image.file(
                    imageGet!,
                    width: 300,
                    height: 300,
                  ),
                )
              : Center(
                  child: Text('No image'),
                )),
    );
  }
}
