import 'package:flutter/cupertino.dart';

BoxDecoration neumorphic_card_decorations = BoxDecoration(
  borderRadius: BorderRadius.circular(6.0),
  color: Color.fromRGBO(44, 45, 64, 1),
  shape: BoxShape.rectangle,
  gradient: RadialGradient(center: Alignment(0.5, 0.6), radius: .7, colors: [
    Color.fromRGBO(26, 27, 38, 1).withOpacity(.3),
    Color.fromRGBO(30, 33, 46, 1).withOpacity(.35),
    Color.fromRGBO(35, 35, 50, 1).withOpacity(0.05),
  ]),
  boxShadow: [
    BoxShadow(color: Color.fromRGBO(35, 36, 51, 1), spreadRadius: 0.0, blurRadius: 10, offset: Offset(3.0, 3.0)),
    BoxShadow(color: Color.fromRGBO(26, 27, 38, 1), spreadRadius: 0.0, blurRadius: 10 / 2.0, offset: Offset(3.0, 3.0)),
    BoxShadow(color: Color.fromRGBO(50, 50, 70, 1), spreadRadius: 2.0, blurRadius: 5, offset: Offset(-3.0, -3.0)),
    BoxShadow(color: Color.fromRGBO(50, 50, 70, 1), spreadRadius: 2.0, blurRadius: 5 / 2, offset: Offset(-3.0, -3.0)),
  ],
);

BoxDecoration neumorphic_rectangle_box_decorations = BoxDecoration(
  color: Color.fromRGBO(44, 45, 64, 1),
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
