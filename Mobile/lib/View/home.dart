import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:mobile/Model/location.dart';
import 'package:mobile/Model/weatherdata.dart';
import 'package:mobile/Controller/location.dart';
import 'package:mobile/Controller/basecommands.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  LocationCoordinates _coordinates = LocationCoordinates();
  LocationCommands _locationCommands = LocationCommands();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void setCoordinates(LocationCoordinates _coordinates) {
      _locationCommands.getLocation(context);
      _coordinates.currentLongitude = context.select<LocationCoordinates, String>((value) => value.currentLongitude);
      _coordinates.currentLatitude = context.select<LocationCoordinates, String>((value) => value.currentLatitude);
      print(_coordinates);
    }

    setCoordinates(_coordinates);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Weather Light Sync'),
      ),
      child: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Column(
                children: [
                  Text(
                    'Current weather conditions:',
                    style: TextStyle(
                      color: CupertinoColors.white,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {},
                    child: Text("Get weather"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
