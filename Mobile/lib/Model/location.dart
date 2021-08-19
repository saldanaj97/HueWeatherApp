import 'package:flutter/material.dart';

class LocationCoordinates extends ChangeNotifier {
  String longitude = '';
  String latitude = '';

  String get currentLongitude => (longitude);
  set currentLongitude(String currentLongitude) {
    longitude = currentLongitude;
    notifyListeners();
  }

  String get currentLatitude => (latitude);
  set currentLatitude(String currentLatitude) {
    latitude = currentLatitude;
    notifyListeners();
  }
}
