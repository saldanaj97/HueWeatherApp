import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:mobile/Service/weatherservice.dart';
import 'package:mobile/Service/lightservice.dart';
import 'package:mobile/Controller/location.dart';
import 'package:mobile/Model/location.dart';
import 'package:mobile/Model/light.dart';
import 'package:mobile/View/decorations/hue_light_colors.dart';
import 'package:mobile/View/light.dart';
import 'package:mobile/View/widgets/navbar.dart';
import 'package:mobile/View/decorations/decorations.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  List weatherData = [];
  List temperatureData = [];
  LocationCommands _locationCommands = LocationCommands();
  WeatherService weatherService = WeatherService();

  @override
  void initState() {
    super.initState();
    this.getWeatherDataFromAPI(context);
  }

  // Used to convert kelvin to farenheit
  double toFarenheit(double kelvinTemp) {
    double farenheit = (kelvinTemp - 273.15) * (9 / 5) + 32;
    return farenheit;
  }

  // Function that will grab a list containing an rgb color from the provided color scheme
  List getRandomColorFromWeatherConditions(List colors) {
    final random = new Random();
    var i = random.nextInt(colors.length);
    return colors[i];
  }

  // Used to get the weather conditions from the backend
  /* NOTE: API keeps returning values that are approx. 20 degrees F higher than
  the actual city temperature. To combat this temporarily a 20 degree reduction will
  be displayed to the user until a solution is found. */
  getWeatherDataFromAPI(context) async {
    LocationCoordinates coordinates;
    Map<String, dynamic> responseMap;

    // Get the phones location first, if true, then ping the api for weather response
    _locationCommands.locationFromPhone(context).then(
          (value) => {
            if (value)
              {
                coordinates = _locationCommands.getCoordinates(),
                // Call the API for the weather data
                weatherService
                    .getCurrentWeather(coordinates)
                    .then(
                      (value) => {
                        responseMap = jsonDecode(value.body),
                        weatherData.addAll(responseMap["weather"]),
                        weatherData.add(responseMap["name"]),
                        temperatureData.replaceRange(0, 0, [
                          toFarenheit(responseMap["main"]["temp"]),
                          toFarenheit(responseMap["main"]["feels_like"]),
                          toFarenheit(responseMap["main"]["temp_min"]),
                          toFarenheit(responseMap["main"]["temp_max"]),
                        ]),
                        setState(() {
                          weatherData = weatherData;
                          temperatureData = temperatureData;
                        })
                      },
                    )
                    .catchError((e) => {print('Error: ' + e)}),
              }
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);
    List tabActive = [
      [1, true],
      [2, false],
      [3, false]
    ];
    LightService _lightService = LightService();

    if (!weatherData.isEmpty && !temperatureData.isEmpty) {
      return CupertinoPageScaffold(
        backgroundColor: primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 30, top: 60, bottom: 10),
              child: Text(
                'Weather',
                style: title,
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 1.15,
                    margin: EdgeInsets.only(top: 10, bottom: 35),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Neumorphic(child: displayInformation(date), style: neumorphicBox),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 30, bottom: 10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Lights',
                          style: title,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(0),
                        child: CupertinoButton(
                          child: Icon(
                            Icons.sync,
                            size: 30,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            List lights = Light.listOfLights;
                            // Pass a different color to each light for the specified duration to simulate a color loop using the palette
                            Timer.periodic(
                              Duration(seconds: 5),
                              (Timer timer) => {
                                lights.forEach((light) {
                                  print('${light.id} has been set');
                                  _lightService.syncLightsToWeather(light.id, getRandomColorFromWeatherConditions(thunderStormColors));
                                }),
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  Container(child: LightsView()),
                ],
              ),
            ),
            Container(child: Navbar(tabActive))
          ],
        ),
      );
    } else {
      // Data is loading
      return Center(
        child: CupertinoActivityIndicator(),
      );
    }
  }

// This widget will hold all the containers and data that needs to be displayed
  Widget displayInformation(date) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 15),
          child: Text(
            weatherData[1],
            style: TextStyle(fontSize: 45, color: Colors.white, fontWeight: FontWeight.w400),
          ),
        ),
        Container(
          child: Icon(
            CupertinoIcons.cloud_sun,
            size: 125,
            color: Colors.white,
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 15),
          child: Text(
            temperatureData[0].round().toString() + ' \u2109',
            style: TextStyle(fontSize: 55, color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 15),
          child: Text(weatherData[0]["main"],
              style: TextStyle(
                fontSize: 35,
                color: Colors.white,
              )),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(top: 15),
              child: Text(temperatureData[2].round().toString() + ' \u2109',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  )),
            ),
            Container(
              padding: EdgeInsets.only(top: 15),
              child: Text(' / ',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  )),
            ),
            Container(
              padding: EdgeInsets.only(top: 15),
              child: Text((temperatureData[3].round() - 20).toString() + ' \u2109',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  )),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.only(top: 15),
          margin: EdgeInsets.only(bottom: 20),
          child: Text('Feels like ' + temperatureData[1].round().toString() + ' \u2109',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              )),
        ),
      ],
    );
  }
}
