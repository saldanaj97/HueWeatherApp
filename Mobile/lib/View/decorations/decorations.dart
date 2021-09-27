import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

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

NeumorphicStyle neumorphicButtonPressed = NeumorphicStyle(
  shape: NeumorphicShape.concave,
  boxShape: NeumorphicBoxShape.circle(),
  color: primaryColor,
  shadowDarkColor: shadowDarkColor_1,
  shadowDarkColorEmboss: shadowDarkColor_1,
  shadowLightColor: shadowLightColor_1,
  shadowLightColorEmboss: shadowLightColor_1,
  intensity: 1,
  surfaceIntensity: 0,
  depth: -3,
);

// Neumorphic sync weather button styling
NeumorphicStyle neumorphicSyncButton = NeumorphicStyle(
  shape: NeumorphicShape.convex,
  boxShape: NeumorphicBoxShape.rect(),
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
Color shadowLightColor_1 = Color.fromRGBO(53, 53, 70, 1);

// Styling for the different headings and titles
TextStyle title = TextStyle(fontSize: 35, fontWeight: FontWeight.w600);
TextStyle settingSubListTitle = TextStyle(fontSize: 25, fontWeight: FontWeight.w600);
