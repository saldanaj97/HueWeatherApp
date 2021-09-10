import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:mobile/View/decorations/decorations.dart';
import 'package:mobile/Service/lightservice.dart';
import 'package:mobile/Model/light.dart';
import 'package:mobile/View/moods.dart';
import 'package:mobile/View/settings.dart';
import 'package:mobile/View/weather.dart';

class Navbar extends StatefulWidget {
  final List tabActive;
  Navbar(this.tabActive);

  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  Color lightBulbOnColor = Colors.yellow;
  int pageActive = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LightService _lightService = LightService();
    List _lights = Light.listOfLights;

    return Container(
      alignment: Alignment.bottomCenter,
      margin: EdgeInsets.only(top: 5, left: 30, right: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: NeumorphicButton(
              style: widget.tabActive[0][1] ? neumorphicButtonPressed : neumorphicButton,
              //pressed: true,
              child: Icon(
                CupertinoIcons.cloud,
                size: 35,
                color: Colors.white,
              ),
              onPressed: () {
                // If we are NOT on this tab already, route to the page
                if (!widget.tabActive[0][1]) {
                  Navigator.push(context, FadeRoute(WeatherPage()));
                }
                setState(() {});
              },
            ),
          ),
          Container(
            child: NeumorphicButton(
              style: widget.tabActive[1][1] ? neumorphicButtonPressed : neumorphicButton,
              child: Icon(
                CupertinoIcons.smiley,
                size: 35,
                color: Colors.white,
              ),
              onPressed: () {
                if (!widget.tabActive[1][1]) {
                  Navigator.push(context, FadeRoute(MoodsView()));
                }
                setState(() {});
              },
            ),
          ),
          Container(
            child: NeumorphicButton(
              style: widget.tabActive[2][1] ? neumorphicButtonPressed : neumorphicButton,
              child: Icon(
                CupertinoIcons.settings,
                size: 35,
                color: Colors.white,
              ),
              onPressed: () {
                if (!widget.tabActive[2][1]) {
                  Navigator.push(context, FadeRoute(SettingsView()));
                }
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

// This will be used to animate the page transitions
class FadeRoute extends PageRouteBuilder {
  final Widget page;
  FadeRoute(this.page)
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
