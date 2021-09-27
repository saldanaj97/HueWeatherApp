import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:mobile/Model/bridge.dart';
import 'package:mobile/View/decorations/decorations.dart';
import 'package:mobile/Service/lightservice.dart';

class BridgeSelection extends StatefulWidget {
  @override
  _BridgeSelectionState createState() => _BridgeSelectionState();
}

class _BridgeSelectionState extends State<BridgeSelection> {
  final List tabActive = [
    [1, false],
    [2, false],
    [3, true]
  ];

  void initState() {
    super.initState();
    lightsConnectedToBridge();
  }

  // Function that reads and organizes the bridge data from the api
  lightsConnectedToBridge() async {
    List<dynamic> responseMap;
    LightService _lightService = LightService();
    List bridges = [];

    _lightService.getBridgeList().then((value) => {
          responseMap = jsonDecode(value.body),
          responseMap.forEach((value) => {
                bridges.add(
                  Bridge(
                    value["config"]["ipaddress"],
                    value["config"]["name"],
                  ),
                ),
                setState(() {
                  // Set the global list of bridges
                  Bridge.listOfBridges = bridges;
                }),
              }),
        });
  }

  @override
  Widget build(BuildContext context) {
    var _bridges = Bridge.listOfBridges;
    var height = MediaQuery.of(context).size.height;

    return CupertinoPageScaffold(
      backgroundColor: primaryColor,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: primaryColor,
        border: null,
        leading: CupertinoButton(
          child: Icon(
            CupertinoIcons.back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        middle: Text(
          'Bridge Selection',
          style: settingSubListTitle,
        ),
      ),
      child: Container(
        margin: EdgeInsets.all(10),
        child: SizedBox(
          height: height * .7,
          child: ListView.builder(
            itemCount: _bridges.length,
            padding: EdgeInsets.all(0),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: bridgeItem(_bridges[index]),
              );
            },
          ),
        ),
      ),
    );
  }

  // Widget for each individual light container in the list
  Widget bridgeItem(var bridge) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 10),
      height: height * .06,
      width: width / 1.15,
      child: Neumorphic(
        style: neumorphicBox,
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(15),
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      bridge.name,
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: width * .035, fontWeight: FontWeight.w600, color: Colors.white),
                    ),
                    Text(
                      bridge.ip_addr,
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: width * .035, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
