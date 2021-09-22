import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:mobile/View/decorations/decorations.dart';
import 'package:mobile/View/skeleton_screens/lightSkeleton.dart';
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

  // This will be the skeleton loading widget for the weather card on the weather screen
  Widget weatherCardSkeleton(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 1.15,
              margin: EdgeInsets.only(top: 10, bottom: 35),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Neumorphic(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 15),
                        margin: EdgeInsets.only(bottom: 15),
                        child: SkeletonAnimation(
                          borderRadius: BorderRadius.circular(25.0),
                          child: Container(
                            height: 45,
                            width: MediaQuery.of(context).size.width * 0.75,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(25.0), color: primaryColor),
                          ),
                        ),
                      ),
                      Container(
                        child: SkeletonAnimation(
                          borderRadius: BorderRadius.circular(100.0),
                          child: Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(25.0), color: primaryColor),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 15),
                        child: SkeletonAnimation(
                          borderRadius: BorderRadius.circular(25.0),
                          child: Container(
                            height: 45,
                            width: MediaQuery.of(context).size.width * 0.55,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(25.0), color: primaryColor),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 15),
                        child: SkeletonAnimation(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Container(
                            height: 75,
                            width: MediaQuery.of(context).size.width * 0.2,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0), color: primaryColor),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 15),
                        child: SkeletonAnimation(
                          borderRadius: BorderRadius.circular(25.0),
                          child: Container(
                            height: 25,
                            width: MediaQuery.of(context).size.width * 0.6,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(25.0), color: primaryColor),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 15),
                        margin: EdgeInsets.only(bottom: 20),
                        child: SkeletonAnimation(
                          borderRadius: BorderRadius.circular(25.0),
                          child: Container(
                            height: 25,
                            width: MediaQuery.of(context).size.width * 0.5,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(25.0), color: primaryColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                  style: neumorphicBox),
            ),
          ],
        ),
      )
    ]);
  }
}
