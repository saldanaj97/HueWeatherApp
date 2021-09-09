import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:mobile/View/decorations/decorations.dart';

class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  Color lightBulbOnColor = Colors.yellow;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      margin: EdgeInsets.only(left: 30, right: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: NeumorphicButton(
              style: neumorphicButton,
              child: Icon(
                CupertinoIcons.cloud,
                size: 35,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {});
              },
            ),
          ),
          Container(
            child: NeumorphicButton(
              style: neumorphicButton,
              child: Icon(
                CupertinoIcons.smiley,
                size: 35,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {});
              },
            ),
          ),
          Container(
            child: NeumorphicButton(
              style: neumorphicButton,
              child: Icon(
                CupertinoIcons.settings,
                size: 35,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {});
              },
            ),
          ),
          Container(
            child: NeumorphicButton(
              style: neumorphicButton,
              child: Icon(
                CupertinoIcons.lightbulb,
                size: 35,
                color: lightBulbOnColor,
              ),
              onPressed: () {
                setState(() {
                  if (lightBulbOnColor == Colors.yellow) {
                    lightBulbOnColor = Colors.white;
                  } else {
                    lightBulbOnColor = Colors.yellow;
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
