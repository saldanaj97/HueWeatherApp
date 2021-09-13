import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/View/widgets/navbar.dart';
import 'package:mobile/View/decorations/decorations.dart';

class MoodsView extends StatefulWidget {
  const MoodsView({Key? key}) : super(key: key);

  @override
  _MoodsViewState createState() => _MoodsViewState();
}

class _MoodsViewState extends State<MoodsView> {
  List tabActive = [
    [1, false],
    [2, true],
    [3, false]
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(left: 30, top: 60, bottom: 10),
            child: Text(
              'Moods',
              style: title,
            ),
          ),
          Container(
            child: Center(
              child: Text(
                'Coming soon',
                style: TextStyle(fontSize: 35),
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: Navbar(tabActive),
          )
        ],
      ),
    );
  }
}
