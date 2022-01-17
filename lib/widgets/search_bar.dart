import 'package:flutter/material.dart';
import 'package:testing_screens/constants/constants.dart';

class Search extends StatelessWidget {
  final text;
  const Search({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: lightColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            const Expanded(flex: 1,child: Icon(Icons.search, color: whiteColor)),
            Expanded(
              flex: 7,
              child: Text(
                '$text',
                style: TextStyle(color: whiteColor,fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }
}
