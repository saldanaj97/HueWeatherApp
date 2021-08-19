import 'package:flutter/material.dart';

class WeatherData extends ChangeNotifier {
  Weather _currentWeather = Weather();
  Temperatures _temperatures = Temperatures();

  Weather get currentWeather => (_currentWeather);
  set currentWeather(Weather currentWeather) {
    _currentWeather = currentWeather;
    notifyListeners();
  }

  Temperatures get currentTemperatures => (_temperatures);
  set currentTemperatures(Temperatures currentTemperatures) {
    _temperatures = currentTemperatures;
    notifyListeners();
  }
}

class Weather {
  String main = '';
  String description = '';
}

class Temperatures {
  int temp = 0;
  int feels_like = 0;
  int temp_min = 0;
  int temp_max = 0;
}
