import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'dart:math';
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
        child: CustomScrollView(
          slivers: [
            CupertinoSliverNavigationBar(
              largeTitle: Text('Lights'),
            ),
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 450,
                mainAxisSpacing: 5.0,
                crossAxisSpacing: 5.0,
                childAspectRatio: 5,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, int index) {
                  return Container(
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        lightList(_lights, index),
                      ],
                    ),
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

  // Widget for each individual light container in the list
  Widget lightList(_lights, index) {
    List rgb = XYtoRGB(_lights[index].lightState.x, _lights[index].lightState.y, _lights[index].lightState.bri.toDouble() / 254);
    //print(rgb);
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 13, // TODO: Fix this height to be cleaner
        color: Color.fromRGBO(rgb[0].round() * 255, rgb[1].round() * 255, rgb[2].round() * 255, _lights[index].lightState.bri.toDouble() / 254),
        child: Row(
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _lights[index].lightInfo.name,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: CupertinoSwitch(
                    value: _lights[index].lightState.on,
                    onChanged: (bool value) {
                      setState(() {
                        _lights[index].lightState.on = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

// TODO: Implement a function to convert the hue XY array to RGB for the application to use
// Formulas for hue color conversion are from the link below:
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

    print(rgb);
    return rgb;
  }
}
