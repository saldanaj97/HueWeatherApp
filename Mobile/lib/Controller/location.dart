import 'package:location/location.dart';

import 'package:mobile/Controller/basecommands.dart';

class LocationCommands extends BaseCommands {
  Future<bool> getLocation(context) async {
    // Get the coordinates from the device location
    LocationData _locationData = await locationService.getUserCoordinates(context);

    // If the coordinates are not empty, we update the location coordinates and run the weather service
    if (_locationData.longitude.toString() != '') {
      locationCoordinates.currentLongitude = _locationData.longitude.toString();
      locationCoordinates.currentLatitude = _locationData.latitude.toString();
      weatherService.getCurrentWeather(locationCoordinates);
    } else {
      print('Location retrieval failed. ');
      return false;
    }

    // Return true because the coordinates were retrieved successfully
    print('Location retrieved. ');
    return true;
  }
}
