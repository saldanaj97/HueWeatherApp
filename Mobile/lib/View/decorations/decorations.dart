import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

// Neumorphic shadows for any rectangular cards
BoxDecoration neumorphic_rectangle_box_decorations = BoxDecoration(
  color: cardColor,
  shape: BoxShape.rectangle,
  borderRadius: BorderRadius.circular(6.0),
  gradient: LinearGradient(begin: Alignment(1, 3), end: Alignment(.3, 0), colors: [
    Color.fromRGBO(26, 27, 38, 1).withOpacity(.3),
    Color.fromRGBO(35, 35, 50, 1).withOpacity(0.2),
  ]),
  boxShadow: [
    BoxShadow(color: Color.fromRGBO(35, 36, 51, 1), spreadRadius: 0.0, blurRadius: 10, offset: Offset(3.0, 3.0)),
    BoxShadow(color: Color.fromRGBO(26, 27, 38, 1), spreadRadius: 0.0, blurRadius: 10 / 2.0, offset: Offset(3.0, 3.0)),
    BoxShadow(color: Color.fromRGBO(50, 50, 70, 1), spreadRadius: 2.0, blurRadius: 5, offset: Offset(-3.0, -3.0)),
    BoxShadow(color: Color.fromRGBO(50, 50, 70, 1), spreadRadius: 2.0, blurRadius: 5 / 2, offset: Offset(-3.0, -3.0)),
  ],
);

// Neumorphic box styling
NeumorphicStyle neumorphicBox = NeumorphicStyle(
  shape: NeumorphicShape.convex,
  color: primaryColor,
  shadowDarkColor: shadowDarkColor_1,
  shadowDarkColorEmboss: shadowDarkColor_1,
  shadowLightColor: shadowLightColor_1,
  shadowLightColorEmboss: shadowLightColor_1,
  intensity: 1,
  surfaceIntensity: 0,
  depth: 5,
);

// Neumorphic button styling
NeumorphicStyle neumorphicButton = NeumorphicStyle(
  shape: NeumorphicShape.convex,
  boxShape: NeumorphicBoxShape.circle(),
  color: primaryColor,
  shadowDarkColor: shadowDarkColor_1,
  shadowDarkColorEmboss: shadowDarkColor_1,
  shadowLightColor: shadowLightColor_1,
  shadowLightColorEmboss: shadowLightColor_1,
  intensity: 1,
  surfaceIntensity: 0,
  depth: 5,
);

// Color palette for the application
Color primaryColor = Color.fromRGBO(44, 45, 64, 1);
Color cardColor = Color.fromRGBO(44, 45, 64, 1);
Color shadowDarkColor_1 = Color.fromRGBO(26, 27, 38, 1);
Color shadowLightColor_1 = Color.fromRGBO(65, 65, 80, 1);
