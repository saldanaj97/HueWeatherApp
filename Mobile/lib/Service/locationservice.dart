import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';
import 'package:app_settings/app_settings.dart';

class LocationService {
  Future<LocationData> getUserCoordinates(BuildContext context) async {
    Location location = new Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    while (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
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
    return _locationData;
  }
}
