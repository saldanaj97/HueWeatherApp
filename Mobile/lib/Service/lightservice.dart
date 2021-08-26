import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class LightService {
  Future<http.Response> getLights() async {
    return await http.get(Uri.parse('http://localhost:3000/bridges'));
  }
}
