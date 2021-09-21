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
import 'package:mobile/View/light.dart';
import 'package:mobile/View/skeleton_screens/weatherSkeleton.dart';
import 'package:mobile/View/widgets/navbar.dart';
import 'package:mobile/View/decorations/decorations.dart';
import 'package:mobile/View/widgets/skeleton_loading_widgets.dart';

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
  LightService _lightService = LightService();
  String syncButtonText = 'Sync';
  bool lightsSyncing = false;

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

  /* Function that periodically sends a request to the backend to make the lights change color.
      we pass a new color from the appropriate weather color pallete and simualate a color loop 
      with those colors. If syncing is false, the user wants to sync lights so we set
      syncing to true and sync the lights with the color palette
      If syncing is true, the user wants to stop the light sync so we cancel the timer
      and turn off the lights */
  void syncLights(List lights, List colorPalette, bool lightsSyncing, Timer timer) {
    // Check if we need to turn the light sync on or off
    if (lightsSyncing) {
      lights.forEach((light) {
        _lightService.syncLightsToWeather(light.id, getRandomColorFromWeatherConditions(colorPalette));
      });
    } else {
      timer.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    List tabActive = [
      [1, true],
      [2, false],
      [3, false],
    ];

    // Render the widget now based on whether the weather data has been retrieved or not
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
                    child: Neumorphic(child: displayInformation(), style: neumorphicBox),
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
                        margin: EdgeInsets.only(right: 30),
                        child: syncButton(),
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
      return WeatherSkeletonLoading();
    }
  }

  // This widget will be used for starting the color loop sync with the hue lights
  Widget syncButton() {
    return NeumorphicButton(
      style: neumorphicSyncButton,
      child: Text(
        syncButtonText,
        style: TextStyle(color: Colors.white, fontSize: 15),
      ),
      onPressed: () {
        // Get the color palette for the lights based on the weather
        List lights = Light.listOfLights;
        List colorPalette = weatherService.getColorPalette(weatherData[0]["main"]);

        if (!lightsSyncing) {
          setState(() {
            lightsSyncing = true;
            lights.forEach((light) {
              light.lightState.on = true;
              light.lightState.poweredOn.value = true;
            });
            syncButtonText = 'Stop syncing';
          });
        } else {
          setState(() {
            lightsSyncing = false;
            syncButtonText = 'Sync';
          });
        }

        // Set the light on immedietly since the timer won't turn on the lights right away
        lights.forEach((light) {
          _lightService.syncLightsToWeather(light.id, getRandomColorFromWeatherConditions(colorPalette));
        });

        Timer.periodic(Duration(seconds: 5), (timer) {
          syncLights(lights, colorPalette, lightsSyncing, timer);
        });
      },
    );
  }

// This widget will hold all the containers and data that needs to be displayed
  Widget displayInformation() {
    String mainWeather = weatherData[0]["main"];
    String city = weatherData[1];
    String temp = temperatureData[0].round().toString();
    String feelsLikeTemp = temperatureData[1].round().toString();
    String dailyLow = temperatureData[2].round().toString();
    String dailyHigh = (temperatureData[3].round()).toString();

    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 15),
          child: Text(
            city,
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
            temp + ' \u2109',
            style: TextStyle(fontSize: 55, color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 15),
          child: Text(mainWeather,
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
              child: Text(dailyLow + ' \u2109',
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
              child: Text(dailyHigh + ' \u2109',
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
          child: Text('Feels like ' + feelsLikeTemp + ' \u2109',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              )),
        ),
      ],
    );
  }
}
