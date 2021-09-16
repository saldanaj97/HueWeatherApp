import 'package:flutter/material.dart';

// This will be used to generate which colors should be sent to the lights based
// on weather conditions
List cloudyColors = [
  Color.fromRGBO(196, 223, 221, 1),
  Color.fromRGBO(146, 182, 177, 1),
  Color.fromRGBO(119, 150, 158, 1),
  Color.fromRGBO(98, 120, 141, 1),
  Color.fromRGBO(49, 59, 70, 1),
];

List clearColors = [
  Color.fromRGBO(253, 189, 135, 1),
  Color.fromRGBO(241, 212, 51, 1),
  Color.fromRGBO(252, 162, 99, 1),
  Color.fromRGBO(255, 239, 74, 1),
  Color.fromRGBO(255, 255, 255, 1),
];

List rainyColors = [
  Color.fromRGBO(156, 175, 242, 1),
  Color.fromRGBO(143, 168, 238, 1),
  Color.fromRGBO(143, 150, 246, 1),
  Color.fromRGBO(128, 146, 231, 1),
  Color.fromRGBO(113, 133, 236, 1),
];

List thunderStormColors = [
  Color.fromRGBO(94, 71, 221, 1),
  Color.fromRGBO(4, 4, 32, 1),
  Color.fromRGBO(70, 51, 203, 1),
  Color.fromRGBO(152, 109, 219, 1),
  Color.fromRGBO(203, 84, 148, 1),
];

List snowyColors = [
  Color.fromRGBO(181, 229, 231, 1),
  Color.fromRGBO(113, 195, 219, 1),
  Color.fromRGBO(34, 179, 210, 1),
  Color.fromRGBO(20, 122, 159, 1),
  Color.fromRGBO(33, 59, 84, 1),
];
