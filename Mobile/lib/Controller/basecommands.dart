import 'package:flutter/cupertino.dart';
import 'package:mobile/Service/weatherservice.dart';
import 'package:mobile/Service/locationservice.dart';
import 'package:provider/provider.dart';

late BuildContext _mainContext;
void init(BuildContext c) => {_mainContext = c};

// Use this to provide quick lookup methods for all top-level models and services
class BaseCommands {
  //Services
  LocationService locationService = _mainContext.read();
  WeatherService weatherService = _mainContext.read();
}
