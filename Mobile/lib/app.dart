import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:mobile/View/settings/bridgeSelection.dart';
import 'package:mobile/View/settings/locationPermissions.dart';
import 'package:mobile/View/settings/settingsLightList.dart';
import 'package:mobile/Controller/basecommands.dart' as Commands;
import 'package:mobile/Service/weatherservice.dart';
import 'package:mobile/Service/locationservice.dart';
import 'package:mobile/View/weather.dart';
import 'package:mobile/View/moods.dart';
import 'package:mobile/View/settings.dart';
import 'package:mobile/View/decorations/decorations.dart';

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
            primaryColor: primaryColor,
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {
            '/': (context) => WeatherPage(),
            '/settings': (context) => SettingsView(),
            '/moods': (context) => MoodsView(),

            // When adding a new settings page, make sure to add to the corresponding
            // index in the settingsItems list in the settings.dart file
            '/settings/hue/0': (context) => BridgeSelection(),
            '/settings/hue/1': (context) => SettingsLightList(),
            '/settings/location/0': (context) => LocationPermissions(),
          },
        );
      }),
    );
  }
}
