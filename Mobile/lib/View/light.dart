import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:mobile/Model/light.dart';
import 'package:mobile/Service/lightservice.dart';
import 'package:mobile/View/weather.dart';

class LightsView extends StatefulWidget {
  const LightsView({Key? key}) : super(key: key);
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
        child: SizedBox(
          height: 500,
          child: new ListView.builder(
            itemCount: _lights.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: lightList(_lights, index),
              );
            },
          ),
        ),
      );
    } else {
      // Data is loading
      return Center(
        child: CupertinoActivityIndicator(),
      );
    }
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

// Widget for each individual light container in the list
  Widget lightList(_lights, index) {
    LightService _lightService = LightService();
    List rgb = XYtoRGB(_lights[index].lightState.x, _lights[index].lightState.y, _lights[index].lightState.bri.toDouble() / 254);

    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
          width: MediaQuery.of(context).size.width / 1.15,
          decoration: BoxDecoration(
            color: Color.fromRGBO(44, 45, 64, 1),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(6.0),
            gradient: LinearGradient(begin: Alignment(1, 3), end: Alignment(.3, 0), colors: [
              Color.fromRGBO(26, 27, 38, 1).withOpacity(.3),
              Color.fromRGBO(35, 35, 50, 1).withOpacity(0.2),
            ]),
            boxShadow: [
              BoxShadow(color: Color.fromRGBO(35, 36, 51, 1), spreadRadius: 0.0, blurRadius: 10, offset: Offset(3.0, 3.0)),
              BoxShadow(color: Color.fromRGBO(26, 27, 38, 1), spreadRadius: 0.0, blurRadius: 10 / 2.0, offset: Offset(3.0, 3.0)),
              BoxShadow(color: Color.fromRGBO(50, 50, 70, 1), spreadRadius: 2.0, blurRadius: 5, offset: Offset(-3.0, -3.0)),
              BoxShadow(color: Color.fromRGBO(50, 50, 70, 1), spreadRadius: 2.0, blurRadius: 5 / 2, offset: Offset(-3.0, -3.0)),
            ],
          ),
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
                    activeColor: Color.fromRGBO(30, 30, 50, 1),
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
}
