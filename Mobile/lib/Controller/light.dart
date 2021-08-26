import 'dart:convert';
import 'package:mobile/Controller/basecommands.dart';
import 'package:mobile/Service/lightservice.dart';
import 'package:mobile/Model/light.dart';

class LightCommands extends BaseCommands {
  LightService _lightService = LightService();
  List<Light> lights = [];
}
