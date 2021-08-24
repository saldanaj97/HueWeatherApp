import 'package:location/location.dart';
import 'package:mobile/Controller/basecommands.dart';
import 'package:mobile/Model/location.dart';

class LocationCommands extends BaseCommands {
  String longitude = '';
  String latitude = '';

  Future<bool> locationFromPhone(context) async {
    // Get the coordinates from the device location
    LocationData _locationData = await locationService.getUserCoordinates(context);

    // If the coordinates are not empty, we update the location coordinates and run the weather service
    if (_locationData.longitude.toString() != '') {
      longitude = _locationData.longitude.toString();
      latitude = _locationData.latitude.toString();

      // Return true because the coordinates were retrieved successfully
      print('Location successfully retrieved. ');
      return Future<bool>.value(true);
    }
    print('Location retrieval failed. ');
    return Future<bool>.value(false);
  }

  LocationCoordinates getCoordinates() {
    return LocationCoordinates(longitude, latitude);
  }
}
