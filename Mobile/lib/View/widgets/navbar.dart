import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:mobile/View/decorations/decorations.dart';
import 'package:mobile/Service/lightservice.dart';
import 'package:mobile/Model/light.dart';

class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  Color lightBulbOnColor = Colors.yellow;
  int pageActive = 0;
  @override
  void initState() {
    super.initState();
    pageActive = 1;
  }

  @override
  Widget build(BuildContext context) {
    LightService _lightService = LightService();
    List _lights = Light.listOfLights;

    return Container(
      alignment: Alignment.bottomCenter,
      margin: EdgeInsets.only(top: 15, left: 30, right: 30),
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
                Navigator.pushNamed(context, '/');
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
                Navigator.pushNamed(context, '/moods');
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
                Navigator.pushNamed(context, '/settings');
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
                  // Yellow = All lights ON / White = All lights OFF
                  if (lightBulbOnColor == Colors.yellow) {
                    lightBulbOnColor = Colors.white;
                    _lights.forEach((light) {
                      light.lightState.on = false;
                      _lightService.setLights(light.id, false, light.lightState.bri);
                    });
                  } else {
                    lightBulbOnColor = Colors.yellow;
                    _lights.forEach((light) {
                      light.lightState.on = true;
                      _lightService.setLights(light.id, true, light.lightState.bri);
                    });
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
