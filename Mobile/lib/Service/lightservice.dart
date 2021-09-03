import 'package:http/http.dart' as http;

class LightService {
  Future<http.Response> getLights() async {
    return await http.get(Uri.parse('http://localhost:3000/bridges'));
  }

  Future<http.Response> setLights(ID, state, brightness) async {
    return await Future<http.Response>.value(http.put(Uri.parse('http://localhost:3000/lights/${ID}/${state}/${brightness}')));
  }
}
