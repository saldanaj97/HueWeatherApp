import 'package:http/http.dart' as http;
import 'package:mobile/Model/location.dart';
import 'package:mobile/View/decorations/hue_light_colors.dart';

class WeatherService {
  Future<http.Response> getCurrentWeather(LocationCoordinates coordinates) async {
    // Call the API for the weather and save the response
    return await http.get(Uri.parse('http://localhost:3000/conditions/${coordinates.latitude}/${coordinates.longitude}'));
  }

  List getColorPalette(String weather) {
    List colorPalette = [];

    switch (weather) {
      case 'Thunderstorm':
        {
          colorPalette = thunderStormColors;
        }
        break;

      case 'Drizzle':
        {
          colorPalette = rainyColors;
        }
        break;

      case 'Rain':
        {
          colorPalette = rainyColors;
        }
        break;

      case 'Snow':
        {
          colorPalette = snowyColors;
        }
        break;

/*       TODO: Add in color scheme for atmospheric conditions
        case 'Atmosphere':
        {}
        break; 
        */

      case 'Clear':
        {
          colorPalette = clearColors;
        }
        break;

      case 'Clouds':
        {
          colorPalette = cloudyColors;
        }
        break;

      default:
        {
          colorPalette = clearColors;
        }
    }
    return colorPalette;
  }
}
