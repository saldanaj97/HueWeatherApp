import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:mobile/View/widgets/navbar.dart';
import 'package:mobile/View/decorations/decorations.dart';
import 'package:mobile/Model/light.dart';

class SettingsLightList extends StatefulWidget {
  @override
  _SettingsLightListState createState() => _SettingsLightListState();
}

class _SettingsLightListState extends State<SettingsLightList> {
  List _lights = Light.listOfLights;
  List tabActive = [
    [1, false],
    [2, false],
    [3, true]
  ];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return CupertinoPageScaffold(
      backgroundColor: primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(left: 30, top: 60, bottom: 10),
            child: Text(
              'Light List',
              style: title,
            ),
          ),
          SizedBox(
            height: height * .7,
            child: ListView.builder(
              itemCount: _lights.length,
              padding: EdgeInsets.all(0),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: settingsLightListItem(_lights[index]),
                );
              },
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

  // Widget for each individual light container in the list
  Widget settingsLightListItem(var light) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 10),
      height: height * .09,
      width: width / 1.15,
      child: Neumorphic(
        style: neumorphicBox,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 15, left: 15, right: 15),
              alignment: Alignment.centerLeft,
              child: Text(
                light.lightInfo.name,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: width * .04, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 15, left: 15, right: 15),
              alignment: Alignment.centerLeft,
              child: Text(
                light.lightInfo.productName,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: width * .035, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
