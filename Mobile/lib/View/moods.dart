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
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Colors.transparent,
        border: null,
        middle: Text(
          'Mood',
          style: TextStyle(fontSize: 25),
        ),
      ),
      child: Container(
        child: Navbar(tabActive),
      ),
    );
  }
}
