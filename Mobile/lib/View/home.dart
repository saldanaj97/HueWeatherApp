import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../Controller/setLocation.dart';
import '../Controller/setWeather.dart';

class WeatherData extends StatefulWidget {
  @override
  _WeatherDataState createState() => _WeatherDataState();
}

class _WeatherDataState extends State<WeatherData> {
  String longitude = '';
  String latitude = '';
  String weatherConditions = '';
  List bridgeIPAddresses = [];

  @override
  void initState() {
    super.initState();
    setLocation(longitude, latitude, context);
    setWeather(weatherConditions, longitude, latitude);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Weather Light Sync',
      home: CupertinoPageScaffold(
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
                      'Current weather conditions: ${weatherConditions}',
                      style: TextStyle(color: CupertinoColors.black),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        //syncLights();
                      },
                      child: Text("Sync Lights"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
