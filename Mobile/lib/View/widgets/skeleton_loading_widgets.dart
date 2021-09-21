import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:mobile/Model/light.dart';
import 'package:mobile/View/decorations/decorations.dart';

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

// This widget will be used to build the skeleton loading animation for the list of lights
Widget lightsListSkeleton(BuildContext context) {
  List _lights = Light.listOfLights;
  return Container(
    child: Column(
      children: [
        SizedBox(
          height: 175,
          child: ListView.builder(
            itemCount: 7,
            padding: EdgeInsets.all(0),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: lightItemSkeleton(context, _lights, index),
              );
            },
          ),
        ),
      ],
    ),
  );
}

// This widget will be used to render the individual list item skeleton
Widget lightItemSkeleton(BuildContext context, List _lights, int index) {
  return Column(
    children: [
      Container(
        margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        width: MediaQuery.of(context).size.width / 1.15,
        child: Neumorphic(
          style: neumorphicBox,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(15),
                  alignment: Alignment.centerLeft,
                  child: SkeletonAnimation(
                    borderRadius: BorderRadius.circular(25.0),
                    child: Container(
                      height: 25,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: primaryColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    ],
  );
}
