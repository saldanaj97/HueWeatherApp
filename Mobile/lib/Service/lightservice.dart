import 'package:http/http.dart' as http;
import 'dart:convert';

class LightService {
  Future<http.Response> getLights() async {
    return await http.get(Uri.parse('http://localhost:3000/bridges'));
  }

  Future<http.Response> setLights(ID, state, brightness) async {
    return await Future<http.Response>.value(http.put(Uri.parse('http://localhost:3000/lights/${ID}/${state}/${brightness}')));
  }

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
