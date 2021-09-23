import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/View/widgets/navbar.dart';
import 'package:mobile/View/decorations/decorations.dart';

class SettingsLightList extends StatefulWidget {
  @override
  _SettingsLightListState createState() => _SettingsLightListState();
}

class _SettingsLightListState extends State<SettingsLightList> {
  List tabActive = [
    [1, false],
    [2, false],
    [3, true]
  ];
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(left: 30, top: 60, bottom: 10),
            child: Text(
              'Light List',
              style: title,
            ),
          ),
          Container(
            child: Center(
              child: Text(
                'Coming soon',
                style: TextStyle(fontSize: 35),
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: Navbar(tabActive),
          )
        ],
      ),
    );
  }
}
