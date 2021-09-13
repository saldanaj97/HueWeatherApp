import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/View/widgets/navbar.dart';
import 'package:mobile/View/decorations/decorations.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List tabActive = [
      [1, false],
      [2, false],
      [3, true]
    ];

    return CupertinoPageScaffold(
      backgroundColor: primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(left: 30, top: 60, bottom: 10),
            child: Text(
              'Settings',
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
