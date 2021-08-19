import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:mobile/Controller/basecommands.dart' as Commands;
import 'package:mobile/Model/location.dart';
import 'package:mobile/Model/weatherdata.dart';
import 'package:mobile/Service/weatherservice.dart';
import 'package:mobile/Service/locationservice.dart';
import '/View/home.dart';

class HueWeatherSync extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (c) => LocationCoordinates()),
        ChangeNotifierProvider(create: (c) => WeatherData()),
        Provider(create: (c) => WeatherService()),
        Provider(create: (c) => LocationService()),
      ],
      child: Builder(builder: (context) {
        Commands.init(context);
        return CupertinoApp(
          theme: CupertinoThemeData(brightness: Brightness.dark),
          home: Home(),
        );
      }),
    );
  }
}
