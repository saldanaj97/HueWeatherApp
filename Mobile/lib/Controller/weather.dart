import 'package:http/http.dart' as http;
import 'package:mobile/Controller/basecommands.dart';
import 'package:mobile/Model/location.dart';
import 'package:mobile/Model/weatherdata.dart';

class WeatherCommands extends BaseCommands {
  Future<bool> getWeatherData(LocationCoordinates coordinates) async {
    WeatherData _weatherData = await weatherService.getCurrentWeather(coordinates);

    return true;
  }
}
