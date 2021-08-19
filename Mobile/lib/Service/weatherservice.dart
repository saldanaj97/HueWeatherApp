import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:app_settings/app_settings.dart';
import 'package:mobile/Model/weatherdata.dart';
import 'package:mobile/Controller/weather.dart';
import 'package:mobile/Model/location.dart';

class WeatherService {
  Future<WeatherData> getCurrentWeather(LocationCoordinates coordinates) async {
    WeatherData _weatherData = WeatherData();

    // Call the API for the weather and save the response
    var url = Uri.parse('http://localhost:3000/conditions/${coordinates.latitude}/${coordinates.longitude}');
    var response = await http.get(url);

    print(response.body);
    return _weatherData;
  }
}
