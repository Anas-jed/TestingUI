import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:testing_screens/constants/constants.dart';
import 'package:testing_screens/constants/database_helper.dart';
import 'package:testing_screens/mystore.dart';
import 'package:testing_screens/screens/home_page/homepage_screen.dart';
import 'package:testing_screens/widgets/listing_card.dart';
import 'package:testing_screens/widgets/search_bar.dart';

class ListingScreen extends StatelessWidget {
  ListingScreen({Key key}) : super(key: key);

  double height;
  double width;
  MyStore myStore = Get.find();

  DatabaseHelper databaseHelper = DatabaseHelper.instance;
  List<Map<String, dynamic>> AllRows;

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    AllRows = await databaseHelper.queryAllRows();
    debugPrint('All Rows : $AllRows');
    return AllRows;
  }

  Future<int> queryRowCount() async {
    final count = await databaseHelper.rowCount();
    return count;
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Container(
      color: primaryColor,
      child: SafeArea(
        child: Scaffold(
          body: Container(
            color: deepLightColor,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                              const Icon(
                                Icons.notifications_none,
                                size: 30,
                                color: whiteColor,
                              ),
                            ],
                          ),
                          const Search(text: 'what bookmark are you searching for ?'),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20, left: 20),
                    child: Text(
                      'Labels',
                      style: headingTextStyle,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      child: Container(
                        height: height * 0.04,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: List.generate(myStore.chipsList.length + 1,
                              (index) {
                            if (index == 0) {
                              return const Chip(
                                label: Icon(
                                  Icons.add,
                                  color: primaryColor,
                                ),
                              );
                            } else {
                              return Chip(
                                label: Text('${myStore.chipsList[index - 1]}'),
                              );
                            }
                          }),
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Bookmarks',
                              style: headingTextStyle,
                            ),
                            Row(
                              children: const [
                                Icon(
                                  Icons.bookmark_border,
                                ),
                                Text('154')
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: const [
                            Icon(
                              Icons.delete_outline,
                              color: primaryColor,
                              size: 30,
                            ),
                            Icon(
                              Icons.note_alt_outlined,
                              color: primaryColor,
                              size: 30,
                            ),
                            Icon(
                              Icons.swap_vert_rounded,
                              color: primaryColor,
                              size: 30,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: FutureBuilder(
                      future: queryAllRows(),
                      builder: (cxt, snapshot) {
                        debugPrint('Does it has data: ? ${snapshot.hasData}');
                        if (snapshot.data != null) {
                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemCount: AllRows.length,
                            itemBuilder: (cxt, index) {
                              return ListingCard(
                                title: AllRows[index]['title'],
                                imgPath: AllRows[index]['image'],
                                index: index,
                              );
                            },
                          );
                        } else {
                          return const Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
/*

ListView.builder(
scrollDirection: Axis.vertical,
shrinkWrap: true,
physics: ClampingScrollPhysics(),
itemCount: queryRowCount() > 0 ? myStore.titleList.length:43,
itemBuilder: (cxt,index){
return ListingCard(
title: myStore.titleList[index],
imgNumber: index + 1,
index: index,
);
},
), ListView(
scrollDirection: Axis.vertical,
shrinkWrap: true,
physics: ClampingScrollPhysics(),
children: List.generate(myStore.titleList.length, (index) {
return ListingCard(
title: myStore.titleList[index],
imgNumber: index + 1,
index: index,
);
}),
),*/
