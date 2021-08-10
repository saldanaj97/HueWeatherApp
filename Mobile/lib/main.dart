import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';
import 'package:app_settings/app_settings.dart';
import 'dart:io';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Light Sync',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherData(),
    );
  }
}

class WeatherData extends StatefulWidget {
  @override
  _WeatherDataState createState() => _WeatherDataState();
}

class _WeatherDataState extends State<WeatherData> {
  String longitude = '';
  String latitude = '';

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.granted) {
      print('Location Permissions Granted');
    } else if (_permissionGranted != PermissionStatus.granted) {
      _permissionGranted = await location.requestPermission();
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text('Location Permission'),
          content: Text('This app needs location access to set the lights according to the weather. '),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('Deny'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            CupertinoDialogAction(
              child: Text('Settings'),
              onPressed: () => AppSettings.openAppSettings(),
            ),
          ],
        ),
      );
    }
    _locationData = await location.getLocation();
    setState(() {
      _locationData.longitude.toString() != '' ? longitude = _locationData.longitude.toString() : longitude = 'null';
      _locationData.latitude.toString() != '' ? latitude = _locationData.latitude.toString() : latitude = 'null';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Light Sync',
      home: Scaffold(
        appBar: AppBar(title: const Text('Weather Light Sync')),
        body: Container(
          alignment: Alignment.center,
          child: ElevatedButton(
            onPressed: () => {
              //getUserAPI(),
            },
            child: Text('Get weather data'),
          ),
        ),
      ),
    );
  }
}