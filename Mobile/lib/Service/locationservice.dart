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
      _locationData = await location.getLocation();
      return _locationData;
    } else {
      _permissionGranted = await location.requestPermission();
      return Future<LocationData>.value(null);
    }
  }
}
