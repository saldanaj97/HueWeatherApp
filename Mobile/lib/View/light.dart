import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:mobile/Model/light.dart';
import 'package:mobile/Service/lightservice.dart';

class LightsView extends StatefulWidget {
  @override
  _LightsViewState createState() => _LightsViewState();
}

class _LightsViewState extends State<LightsView> {
  List _lights = [];

  @override
  void initState() {
    super.initState();
    this.localBridges();
  }

  // Method to get the lights connected to a local bridge
  localBridges() async {
    List<dynamic> responseMap;
    LightService _lightService = LightService();
    List lights = [];

    _lightService.getLights().then((value) => {
          responseMap = jsonDecode(value.body),
          responseMap.forEach((value) => {
                lights.add(
                  Light(
                      value["id"],
                      LightInfo(
                        value["type"],
                        value["name"],
                        value["uniqueid"],
                        value["productname"],
                      ),
                      LightState(
                        value["state"]["on"],
                        value["state"]["bri"],
                        value["state"]["hue"],
                        value["state"]["sat"],
                        value["state"]["effect"],
                        value["state"]["xy"][0],
                        value["state"]["xy"][1],
                      )),
                ),
                setState(() {
                  _lights = lights;
                }),
              }),
        });
  }

  @override
  Widget build(BuildContext context) {
    // Data is ready
    if (_lights.length > 0) {
      return Container(
        height: MediaQuery.of(context).size.height,
        child: CustomScrollView(
          slivers: [
            CupertinoSliverNavigationBar(
              largeTitle: Text('Lights and Scenes'),
            ),
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 5.0,
                crossAxisSpacing: 5.0,
                childAspectRatio: 2,
              ),
              delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                return lightScenes();
              }, childCount: 1),
            ),
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 2,
              ),
              delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Lights',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                );
              }, childCount: 1),
            ),
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 450,
                mainAxisSpacing: 5.0,
                crossAxisSpacing: 5.0,
                childAspectRatio: 6,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, int index) {
                  return Container(
                    child: lightList(_lights, index),
                  );
                },
                childCount: _lights.length,
              ),
            ),
          ],
        ),
      );
    } else {
      // Data is loading
      return Center(
        child: CupertinoActivityIndicator(),
      );
    }
  }

  // Widget for each scene category in the list
  Widget lightScenes() {
    return Container(
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(15),
            child: Text(
              'Scenes',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height / 8,
                  decoration: BoxDecoration(color: CupertinoColors.activeOrange, borderRadius: BorderRadius.all(Radius.circular(15))),
                  margin: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  child: TextButton(
                    child: Text(
                      'Weather',
                      style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/weather');
                      print('Button pressed');
                    },
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height / 8,
                  decoration: BoxDecoration(color: CupertinoColors.activeOrange, borderRadius: BorderRadius.all(Radius.circular(15))),
                  margin: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  child: Text(
                    'Moods',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget for each individual light container in the list
  Widget lightList(_lights, index) {
    LightService _lightService = LightService();
    List rgb = XYtoRGB(_lights[index].lightState.x, _lights[index].lightState.y, _lights[index].lightState.bri.toDouble() / 254);

    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 10, right: 10, top: 10),
          decoration: BoxDecoration(
              color: Color.fromRGBO(rgb[0].round() * 255, rgb[1].round() * 255, rgb[2].round() * 255, _lights[index].lightState.bri.toDouble() / 254),
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(15),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _lights[index].lightInfo.name,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: CupertinoSwitch(
                    value: _lights[index].lightState.on,
                    onChanged: (bool value) {
                      setState(() {
                        _lights[index].lightState.on = value;
                        _lightService.setLights(_lights[index].id, value, _lights[index].lightState.bri);
                      });
                    },
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

// Formulas for hue xy to rgb color conversion are from the link below:
// https://github.com/PhilipsHue/PhilipsHueSDK-iOS-OSX/commit/00187a3db88dedd640f5ddfa8a474458dff4e1db
  List XYtoRGB(double hueX, double hueY, double brightness) {
    List rgb = [];

    // Calculate xyz values
    double x = hueX;
    double y = hueY;
    double z = 1.0 - x - y;
    double _y = brightness;
    double _x = (_y / y) * x;
    double _z = (_y / y) * z;

    // Convert to rgb
    double r = _x * 1.4628067 - _y * 0.1840623 - _z * 0.2743606;
    double g = -_x * 0.5217933 + _y * 1.4472381 + _z * 0.0677227;
    double b = (_x * 0.0349342 - _y * 0.0968930 + _z * 1.2884099);

    // Add to the list and return the list
    rgb.add(r);
    rgb.add(g);
    rgb.add(b);
    return rgb;
  }
}
