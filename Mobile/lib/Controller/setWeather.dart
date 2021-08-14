import 'package:http/http.dart' as http;

void setWeather(String weatherConditions, String longitude, String latitude) async {
  var url = Uri.parse('http://localhost:3000/conditions/${latitude}/${longitude}');
  var response = await http.get(url);
  weatherConditions = response.body;
}
