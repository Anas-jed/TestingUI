import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:testing_screens/constants/constants.dart';

import '../mystore.dart';

class PhotoCard extends StatelessWidget {
  PhotoCard({Key key}) : super(key: key);
  MyStore myStore = Get.find();
  double height;
  double width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          height: height * 0.13,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
            color: photosBackColor,
          ),
          child: Row(
            children: [
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: myStore.photosList.length + 1,
                  itemBuilder: (cxt, index) {
                    if (index == 0) {
                      debugPrint('Pringing $index');
                      return Obx(
                        () => myStore.pickedFile.value == ""
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  child: Container(
                                    width: width * 0.23,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: primaryColor, width: 1),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.add,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  onTap: () async {
                                    try {
                                      myStore.image = await ImagePicker()
                                          .pickImage(
                                              imageQuality: 90,
                                              source: ImageSource.camera);

                                      /* bytes =
                                          File(image.path).readAsBytesSync();
                                      myStore.imageString = base64Encode(bytes);*/
                                      myStore.pickedFile.value =
                                          myStore.image.path;
                                      debugPrint('imagepath: ${myStore.image.path}');
                                      debugPrint('imagepath: ${myStore.image.name}');
                                      debugPrint(
                                          "iamge path; ${myStore.image.path.replaceAll(myStore.image.name, "")}");
                                    } catch (e) {
                                      debugPrint('problrm here');
                                    }
                                  },
                                ),
                              )
                            : InkWell(
                                onTap: () async {
                                  try {
                                    myStore.image = await ImagePicker()
                                        .pickImage(
                                            source: ImageSource.camera,
                                            imageQuality: 90);
                                    /*final bytes =
                                        File(image.path).readAsBytesSync();
                                    myStore.imageString = base64Encode(bytes);*/
                                    myStore.pickedFile.value =
                                        myStore.image.path;
                                    debugPrint(
                                        'imagepath212 : ${myStore.image.path}');
                                  } catch (e) {
                                    debugPrint('no problrm  is here');
                                  }
                                },
                                child: SizedBox(
                                  width: width * 0.27,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.file(
                                        File(myStore.pickedFile.value),
                                        width: width * 0.23,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      );
                    } else {
                      debugPrint('Pringing $index');
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              'assets/img$index.jpg',
                            )),
                      );
                    }
                  },
                ),
              ),
            ],
          )),
    );
  }
}
