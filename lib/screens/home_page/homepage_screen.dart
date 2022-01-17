import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:testing_screens/constants/constants.dart';
import 'package:testing_screens/constants/database_helper.dart';
import 'package:testing_screens/screens/adding_data/adding_data.dart';
import 'package:testing_screens/widgets/search_bar.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);
  double height;
  double width;

  rowsCount() async {
    print("ROWS COUNT: ${await databaseHelper.rowCount()}");

    final AllRows = await databaseHelper.queryAllRows();
    print('All Rows : $AllRows');
/*
    print('Directory mine app: ${await getApplicationDocumentsDirectory()}');
    getApplicationDocumentsDirectory().then((value) => print('this path: ${value.path}'));*/
  }

  DatabaseHelper databaseHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context){
    rowsCount();
    //databaseHelper.deleteAllData();

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Container(
      color: primaryColor,
      child: SafeArea(
        child: Scaffold(
          bottomNavigationBar: Container(
            padding: EdgeInsets.zero,
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: deepLightColor, spreadRadius: 0, blurRadius: 0),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              /*BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),*/
              child: BottomNavigationBar(
                backgroundColor: whiteColor,
                elevation: 20,
                items: const [
                  BottomNavigationBarItem(
                      backgroundColor: whiteColor,
                      label: "",
                      icon: Icon(
                        Icons.add,
                        color: whiteColor,
                      )),
                  BottomNavigationBarItem(
                      backgroundColor: whiteColor,
                      label: "",
                      icon: Icon(
                        Icons.add,
                        color: whiteColor,
                      )),
                ],
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            backgroundColor: primaryColor,
            child: Icon(Icons.add),
            onPressed: () {
              Get.to(() => AddingDataScreen());
            },
          ),
          body: Container(
            color: deepLightColor,
            child: Column(
              //mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: height * 0.25,
                  decoration: const BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Icon(
                              Icons.face,
                              size: 30,
                              color: whiteColor,
                            ),
                            Icon(
                              Icons.notifications_none,
                              size: 30,
                              color: whiteColor,
                            ),
                          ],
                        ),
                        const Text(
                          'Hi, Sonia',
                          style: TextStyle(fontSize: 22, color: whiteColor),
                        ),
                        Row(
                          children: [
                            const Text(
                              'Welcome Back  ',
                              style: TextStyle(
                                  fontSize: 22,
                                  color: whiteColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              FontAwesomeIcons.mitten,
                              color: Colors.yellow.shade500,
                              size: 20,
                            ),
                          ],
                        ),
                        const Search(text: "what category are you searching for?"),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Categories',
                        style: headingTextStyle,
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.delete_outline,
                            color: lightColor,
                            size: 30,
                          ),
                          Icon(
                            Icons.note_alt_outlined,
                            color: lightColor,
                            size: 30,
                          ),
                          Icon(
                            Icons.swap_vert_rounded,
                            color: primaryColor,
                            size: 30,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: GridView.count(
                        crossAxisCount: 2,
                        children: List.generate(categoriesList.length, (index) {
                          return CategoryCards(
                            category: categoriesList[index],
                          );
                        }),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Categories {
  final String text;
  final IconData iconData;
  final Color lightCategoryColor;
  final Color textColor;

  Categories(
      {this.text, this.iconData, this.lightCategoryColor, this.textColor});
}

List<Categories> categoriesList = <Categories>[
  Categories(
      text: 'New Ideas',
      iconData: Icons.lightbulb_outline,
      textColor: Colors.yellow,
      lightCategoryColor: Colors.yellow.shade100),
  Categories(
      text: 'Music',
      iconData: Icons.music_note,
      textColor: Colors.blue,
      lightCategoryColor: Colors.blue.shade100),
  Categories(
      text: 'Programming',
      iconData: Icons.computer,
      textColor: Colors.purple,
      lightCategoryColor: Colors.purple.shade100),
  Categories(
      text: 'Cooking',
      iconData: Icons.emoji_food_beverage,
      textColor: Colors.pink.shade200,
      lightCategoryColor: Colors.pink.shade100),
  Categories(
      text: 'Flight',
      iconData: Icons.airplanemode_active_rounded,
      textColor: Colors.green,
      lightCategoryColor: Colors.green.shade100),
  Categories(
      text: 'Reactive',
      iconData: Icons.swap_horizontal_circle,
      textColor: Colors.orange,
      lightCategoryColor: Colors.orange.shade100),
];

class CategoryCards extends StatelessWidget {
  Categories category;

  CategoryCards({Key key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('working');
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 30,
        child: Card(
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          color: category.lightCategoryColor,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: whiteColor,
                    child: Icon(
                      category.iconData,
                      color: category.textColor,
                      size: 50,
                    ),
                  ),
                ),
                Text(
                  category.text,
                  style: TextStyle(color: category.textColor),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
