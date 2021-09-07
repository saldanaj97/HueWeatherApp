import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'dart:convert';
import 'package:mobile/Service/weatherservice.dart';
import 'package:mobile/Controller/location.dart';
import 'package:mobile/Model/location.dart';
import 'package:mobile/Model/weatherdata.dart';

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

  double toFarenheit(double kelvinTemp) {
    double farenheit = (kelvinTemp - 273.15) * (9 / 5) + 32;
    return farenheit;
  }

  // Used to get the weather conditions from the backend
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
                        setState(() {})
                      },
                    )
                    .catchError((e) => {print('Error: ' + e)}),
              }
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    if (!weatherData.isEmpty && !temperatureData.isEmpty) {
      print(weatherData);
      print(temperatureData);
      return CupertinoPageScaffold(
        backgroundColor: Colors.blueGrey,
        navigationBar: CupertinoNavigationBar(
          backgroundColor: Colors.transparent,
          border: null,
          middle: Text(
            'Weather',
            style: TextStyle(fontSize: 20),
          ),
        ),
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 1.75,
                width: MediaQuery.of(context).size.width / 1.15,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 15),
                      child: Text(
                        weatherData[1],
                        style: TextStyle(fontSize: 35, color: Colors.black),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 15),
                      child: Text(
                        temperatureData[0].round().toString() + ' \u2109',
                        style: TextStyle(fontSize: 55, color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 15),
                      child: Text(
                        weatherData[0]["main"],
                        style: TextStyle(fontSize: 35, color: Colors.black),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 15),
                      child: Text(
                        temperatureData[2].round().toString(),
                        style: TextStyle(fontSize: 35, color: Colors.black),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 15),
                      child: Text(
                        temperatureData[3].round().toString(),
                        style: TextStyle(fontSize: 35, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
              CupertinoButton(
                  child: Container(
                    height: MediaQuery.of(context).size.height / 20,
                    width: MediaQuery.of(context).size.width / 4,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Sync',
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  onPressed: () {}),
            ],
          ),
        ),
      );
    } else {
      // Data is loading
      return Center(
        child: CupertinoActivityIndicator(),
      );
    }
  }
}
