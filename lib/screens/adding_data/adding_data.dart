import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:testing_screens/constants/constants.dart';
import 'package:testing_screens/constants/database_helper.dart';
import 'package:testing_screens/mystore.dart';
import 'package:testing_screens/screens/home_page/homepage_screen.dart';
import 'package:testing_screens/screens/listing_page/listing_screen.dart';
import 'package:testing_screens/widgets/photos_card.dart';

class AddingDataScreen extends StatelessWidget {
  AddingDataScreen({Key key}) : super(key: key);
  double height;
  double width;

  GlobalKey formKey = GlobalKey<FormState>();
  MyStore myStore = Get.find();
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  DatabaseHelper databaseHelper = DatabaseHelper.instance;

  void insertRow(String title, String description, String imagePath) async {
    //row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnTitle: title,
      DatabaseHelper.columnDescription: description,
      DatabaseHelper.columnImage: imagePath
    };
    debugPrint('INSERTING DATA: ${row}');

    final id = await databaseHelper.insert(row);
    debugPrint('inserted row id is: $id');

    Get.snackbar("Data inserted", "Inserted row: $id");
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Container(
      color: primaryColor,
      child: SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
          child: Container(
              color: primaryColor,
              child: Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        height: height * 0.15,
                        color: primaryColor,
                        child: Padding(
                          padding: const EdgeInsets.all(22.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  InkWell(
                                    child: const Icon(
                                      Icons.chevron_left,
                                      size: 30,
                                      color: whiteColor,
                                    ),
                                    onTap: () {
                                      Get.to(HomePage());
                                    },
                                  ),
                                  const Text(
                                    'Cupcake',
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: whiteColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Icon(
                                    Icons.share_outlined,
                                    size: 30,
                                    color: whiteColor,
                                  ),
                                ],
                              ),
                              /*FractionalTranslation(
                              translation: Offset(0.6,0.8),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundColor: whiteColor,
                                    child: Icon(
                                      Icons.notifications_active,
                                      color: lightColor,
                                      size: 25,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                      radius: 25,
                                      backgroundColor: whiteColor,
                                      child: Icon(
                                        FontAwesomeIcons.solidStar,
                                        color: Colors.yellow.shade800,
                                        size: 25,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )*/
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            color: deepLightColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(22.0),
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                Row(
                                  children: const [
                                    Icon(Icons.title),
                                    Text(
                                      ' Title',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: titleController,
                                    maxLines: 1,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(
                                          top: 5, bottom: 5, left: 10),
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: "Cupcake",
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: const [
                                    Icon(Icons.description),
                                    Text(
                                      '  Description',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: descController,
                                    maxLines: 10,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText:
                                          "Lorem Ipsum is simply dummy text of the debugPrinting and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,\nwhen an unknown debugPrinter took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    maxLines: 1,
                                    decoration: InputDecoration(
                                      filled: true,
                                      contentPadding: EdgeInsets.zero,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: const [
                                    Icon(Icons
                                        .photo_size_select_actual_outlined),
                                    Text(
                                      ' Photos',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                PhotoCard(),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0, right: 5.0),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: deepLightColor,
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            padding: EdgeInsets.all(15),
                                            side: const BorderSide(
                                                color: primaryColor, width: 1),
                                          ),
                                          onPressed: () {},
                                          child: const Text('cancel',
                                              style: TextStyle(
                                                  color: primaryColor)),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5.0, right: 20.0),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            padding: EdgeInsets.all(15),
                                            elevation: 0,
                                            primary: primaryColor,
                                          ),
                                          onPressed: () async {
                                            if (titleController.text.length >
                                                    0 &&
                                                descController.text.length >
                                                    0 &&
                                                myStore.pickedFile.value
                                                        .length >
                                                    0) {
                                              debugPrint('yes it is');
                                              await getApplicationDocumentsDirectory().then((value) async{
                                                await myStore.image.saveTo(value.path+myStore.image.name).then((value) async{
                                                  insertRow(
                                                      titleController.text,
                                                      descController.text,
                                                      myStore.image.path);
                                                  Get.to(()=> ListingScreen());
                                                });
                                              });


                                            } else {
                                              Get.snackbar("Error!",
                                                  "First insert all data",
                                                  snackPosition:
                                                      SnackPosition.BOTTOM);
                                              debugPrint('it is not');
                                            }
                                            //Get.to(ListingScreen());
                                          },
                                          child: const Text('save'),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: height * 0.11,
                    right: width * 0.08,
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 25,
                          backgroundColor: whiteColor,
                          child: Icon(
                            Icons.notifications_active,
                            color: lightColor,
                            size: 25,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: whiteColor,
                            child: Icon(
                              FontAwesomeIcons.solidStar,
                              color: Colors.yellow.shade800,
                              size: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )),
        )),
      ),
    );
  }
}
