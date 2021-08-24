import 'package:http/http.dart' as http;
import 'package:mobile/Model/location.dart';

class WeatherService {
  Future<http.Response> getCurrentWeather(LocationCoordinates coordinates) async {
    print(' longitude: ' + coordinates.longitude);
    // Call the API for the weather and save the response
    return await http.get(Uri.parse('http://localhost:3000/conditions/${coordinates.latitude}/${coordinates.longitude}'));
  }
}
