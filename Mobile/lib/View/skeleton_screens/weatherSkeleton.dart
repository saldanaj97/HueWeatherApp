import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/View/decorations/decorations.dart';
import 'package:mobile/View/widgets/skeleton_loading_widgets.dart';
import 'package:mobile/View/widgets/navbar.dart';

class WeatherSkeletonLoading extends StatelessWidget {
  final List tabActive = [
    [1, true],
    [2, false],
    [3, false],
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: primaryColor,
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(left: 30, top: 60, bottom: 10),
            child: Text(
              'Weather',
              style: title,
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: weatherCardSkeleton(context),
          ),
          Container(
            margin: EdgeInsets.only(left: 30, bottom: 10),
            alignment: Alignment.centerLeft,
            child: Text(
              'Lights',
              style: title,
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: lightsListSkeleton(context),
          ),
          Container(child: Navbar(tabActive))
        ],
      ),
    );
  }
}
