import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:mobile/Controller/basecommands.dart' as Commands;
import 'package:mobile/Service/weatherservice.dart';
import 'package:mobile/Service/locationservice.dart';
import 'package:mobile/View/weather.dart';
import 'package:mobile/View/home.dart';

class HueWeatherSync extends StatelessWidget {
  @override
  Widget build(BuildContext _) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MultiProvider(
      providers: [
        Provider(create: (c) => LocationService()),
        Provider(create: (c) => WeatherService()),
      ],
      child: Builder(builder: (context) {
        Commands.init(context);
        return CupertinoApp(
          theme: CupertinoThemeData(
            brightness: Brightness.dark,
            primaryColor: Colors.blueGrey[900],
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => HomePage(),
            '/weather': (context) => const WeatherPage(),
          },
        );
      }),
    );
  }
}
