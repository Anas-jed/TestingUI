import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/route_manager.dart';
import 'package:testing_screens/constants/constants.dart';
import 'package:testing_screens/mystore.dart';

class ListingCard extends StatelessWidget {
  String imgPath;
  String title;
  int index;

  double height;
  double width;

  ListingCard({Key key, this.imgPath, this.title, this.index})
      : super(key: key);
  MyStore myStore = Get.find();

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Obx(() => Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              debugPrint('index is clicked; $index');
              myStore.clickedIndex.value = index;
            },
            child: Container(
              /*decoration: myStore.clickedIndex.value == index
                  ? BoxDecoration(
                      //shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 1, color: Colors.grey, spreadRadius: 0.1)
                      ],
                    )
                  : null,*/
              child: Card(
                elevation: myStore.clickedIndex.value == index ? 3 : 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: whiteColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        height: 220,
                        width: width * 0.15,
                        child: Image.file(
                          File(imgPath),
                          height: 220,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    //Image.asset('assets/img${imgNumber}.jpg')),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('$title'),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(
                                () => InkWell(
                                    child: Icon(
                                      Icons.notifications_active,
                                      color: myStore.isBellClicked.value
                                          ? Colors.yellow.shade800
                                          : lightColor,
                                      size: 20,
                                    ),
                                    onTap: () {
                                      debugPrint('clicked');
                                      if (myStore.isBellClicked.value) {
                                        myStore.isBellClicked.value = false;
                                      } else {
                                        myStore.isBellClicked.value = true;
                                      }
                                      debugPrint(
                                          'clicked ${myStore.isBellClicked.value}');
                                    }),
                              ),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Obx(
                                    () => InkWell(
                                      onTap: () {
                                        debugPrint('clicked');
                                        if (myStore.isStarClicked.value) {
                                          myStore.isStarClicked.value = false;
                                        } else {
                                          myStore.isStarClicked.value = true;
                                        }
                                        debugPrint(
                                            'clicked ${myStore.isStarClicked.value}');
                                      },
                                      child: Icon(
                                        FontAwesomeIcons.solidStar,
                                        color: myStore.isStarClicked.value
                                            ? Colors.yellow.shade800
                                            : lightColor,
                                        size: 17,
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                    //Text('$title'),
                    /*subtitle: Row(
                  children: [
                    Icon(
                      Icons.notifications_active,
                      color: lightColor,
                      size: 25,
                    ),
                    Icon(
                      FontAwesomeIcons.solidStar,
                      color: Colors.yellow.shade800,
                      size: 25,
                    ),
                  ],
                ),*/
                    trailing: Container(
                      height: height * 0.05,
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 4,
                              color: Colors.yellow.shade300,
                              spreadRadius: 0.8)
                        ],
                      ),
                      child: RawMaterialButton(
                        onPressed: () {},
                        elevation: 0,
                        padding: const EdgeInsets.all(0),
                        fillColor: Colors.yellow.shade800,
                        //Color(0xFFF5F6F9),
                        child: const Icon(
                          Icons.door_front_door_outlined,
                          color: whiteColor,
                        ),
                        //padding: EdgeInsets.all(10.0),
                        shape: const CircleBorder(),
                      ), /*CircleAvatar(
                    backgroundColor: Colors.yellow.shade800,

                    child: Icon(
                      FontAwesomeIcons.doorOpen,
                      color: whiteColor,
                      //size: 15,
                    ),
                  ),*/
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
