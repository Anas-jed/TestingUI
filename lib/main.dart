import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testing_screens/screens/home_page/homepage_screen.dart';

import 'mystore.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);
  MyStore myStore = Get.put(MyStore());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

