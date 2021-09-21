import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/View/decorations/decorations.dart';
import 'package:mobile/View/widgets/skeleton_loading_widgets.dart';

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
