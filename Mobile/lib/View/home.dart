import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile/Controller/location.dart';
import 'package:mobile/View/weather.dart';
import 'package:mobile/View/settings.dart';

class HomePage extends StatelessWidget {
  final LocationCommands _locationCommands = LocationCommands();

  @override
  Widget build(BuildContext context) {
    _locationCommands.locationFromPhone(context);
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.lightbulb), label: 'Lights'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.settings), label: 'Settings'),
        ],
      ),
      tabBuilder: (context, index) {
        late final CupertinoTabView returnValue;
        switch (index) {
          case 0:
            returnValue = CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: Home(),
              );
            });
            break;
          case 1:
            returnValue = CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: WeatherView(),
              );
            });
            break;
          case 2:
            returnValue = CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: SettingsView(),
              );
            });
            break;
        }
        return returnValue;
      },
    );
  }

  Widget Home() {
    return Container(
      child: Text('Home'),
    );
  }

/*   Widget returnWeatherWidget() {
    return FutureBuilder(
        future: weatherSet,
        builder: (context, data) {
          if (data.data == true) {
            return SafeArea(
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Column(
                      children: [
                        Text(
                          'Current weather conditions: ${_weatherCommands.weatherData[0]["main"]}',
                          style: TextStyle(
                            color: CupertinoColors.white,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            //_weatherData.newCurrentWeather = 'Clouds';
                          },
                          child: Text("Get weather"),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          } else {
            return Center(child: CupertinoActivityIndicator());
          }
        });
  } */
}
