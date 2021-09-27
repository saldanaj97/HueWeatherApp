import 'package:http/http.dart' as http;
import 'dart:convert';

class LightService {
  Future<http.Response> getBridgeList() async {
    return await http.get(Uri.parse('http://localhost:3000/bridges'));
  }

  // Call  to the api for getting all lights that belong to a bridge
  Future<http.Response> getLights() async {
    return await http.get(Uri.parse('http://localhost:3000/lights'));
  }

  // Used to change the state of the lights
  Future<http.Response> setLights(ID, state, brightness) async {
    return await Future<http.Response>.value(http.put(Uri.parse('http://localhost:3000/lights/${ID}/${state}/${brightness}')));
  }

  // This function will begin the color loop according to the live local weather
  Future<http.Response> syncLightsToWeather(ID, colors) async {
    Map data = {
      'id': ID,
      'color': [colors[0], colors[1], colors[2]]
    };

    var body = json.encode(data);
    return await Future<http.Response>.value(
      http.post(Uri.parse('http://localhost:3000/sync/'), headers: {"Content-Type": "application/json"}, body: body),
    );
  }

  // This function will be used to stop the light weather sync
  Future<http.Response> stopLightsFromSyncingWithWeather(ID) async {
    Map data = {
      'id': ID,
    };

    var body = json.encode(data);
    return await Future<http.Response>.value(
      http.post(Uri.parse('http://localhost:3000/sync/off'), headers: {"Content-Type": "application/json"}, body: body),
    );
  }
}
