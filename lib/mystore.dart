import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class MyStore extends GetxController{

  var isBellClicked = true.obs;
  var isStarClicked = false.obs;
  var clickedIndex = 5.obs;

  var pickedFile = "".obs;

  String imageString;
  XFile image;
  Uint8List bytes;

  List<Photos> photosList = [
    Photos(image: 'assets/img1.jpg'),
    Photos(image: 'assets/img2.jpg'),
    Photos(image: 'assets/img3.jpg'),
    Photos(image: 'assets/img4.jpg'),
  ];



  List<String> titleList = [
    'Vanilla Cake',
    'Cup Cake',
    'Pan Cake',
    'Donat',
  ];

  List<String> chipsList = [
    'All',
    'Cake',
    'Fast Food',
    'Kabab',
    'Shawarma',
  ];
}

class Photos{
  String image;
  Photos({this.image});
}