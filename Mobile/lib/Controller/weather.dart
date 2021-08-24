import 'dart:convert';
import 'package:mobile/Controller/basecommands.dart';
import 'package:mobile/Model/location.dart';
import 'package:mobile/Model/weatherdata.dart';

class WeatherCommands extends BaseCommands {
  List weatherData = [];
  List temperatureData = [];

  double toFarenheit(double kelvinTemp) {
    double farenheit = (kelvinTemp - 273.15) * (9 / 5) + 32;
    return farenheit;
  }

  Future<bool> getWeatherDataFromAPI(LocationCoordinates coordinates) {
    Map<String, dynamic> responseMap;
    // Call the API for the weather data
    weatherService.getCurrentWeather(coordinates).then(
          (value) => {
            responseMap = jsonDecode(value.body),
            weatherData.addAll(responseMap["weather"]),
            temperatureData.replaceRange(0, 0,
                [responseMap["main"]["temp"], responseMap["main"]["feels_like"], responseMap["main"]["temp_min"], responseMap["main"]["temp_max"]])
          },
        );

    return Future<bool>.value(true);
  }

  Future<WeatherData> setLocalWeather() async {
    if (temperatureData.length > 0) {
      return Future<WeatherData>.value(WeatherData(
        toFarenheit(temperatureData[0]),
        toFarenheit(temperatureData[0]),
        toFarenheit(temperatureData[0]),
        toFarenheit(temperatureData[0]),
        weatherData[0]['main'],
        weatherData[0]['description'],
      ));
    }
    return Future<WeatherData>.value(WeatherData(0.0, 0.0, 0.0, 0.0, '', ''));
  }
}
