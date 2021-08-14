import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';
import 'package:app_settings/app_settings.dart';
import 'package:http/http.dart' as http;

void syncLights() async {
  var url = Uri.parse('http://localhost:3000/sync');
  var response = await http.get(url);
}
