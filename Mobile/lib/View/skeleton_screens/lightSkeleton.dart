import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:mobile/View/decorations/decorations.dart';

class LightsSkeletonLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          children: [
            SizedBox(
              height: 175,
              child: ListView.builder(
                itemCount: 8,
                padding: EdgeInsets.all(0),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: lightItemSkeleton(context),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// This widget will be used to build the skeleton loading animation for the list of lights
Widget lightsListSkeleton(BuildContext context) {
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
                child: lightItemSkeleton(context),
              );
            },
          ),
        ),
      ],
    ),
  );
}

// This widget will be used to render the individual list item skeleton
Widget lightItemSkeleton(BuildContext context) {
  return Column(
    children: [
      Container(
        margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 10),
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
