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

  Future<List> localBridges() async {
    List<dynamic> responseMap;
    LightInfo _lightInfo = LightInfo();
    LightState _lightState = LightState();
    LightService _lightService = LightService();
    List lights = [];

    _lightService.getLights().then((value) => {
          responseMap = jsonDecode(value.body),
          responseMap.forEach((value) => {
                // Lightstate obj
                _lightState.on = value["state"]["on"],
                _lightState.bri = value["state"]["bri"],
                _lightState.hue = value["state"]["hue"],
                _lightState.sat = value["state"]["sat"],
                _lightState.effect = value["state"]["effect"],

                // LightInfo obj
                _lightInfo.state = _lightState,
                _lightInfo.type = value["type"],
                _lightInfo.name = value["name"],
                _lightInfo.uniqueID = value["uniqueid"],
                _lightInfo.productName = value["productname"],

                // Add the light and its info to the light list
                lights.add(Light(value["id"], _lightInfo))
              }),
          setState(() {
            _lights = lights;
          }),
        });
    return Future<List>.value(lights);
  }

  @override
  Widget build(BuildContext context) {
    if (_lights.length > 0) {
      return Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Text('${_lights[0].id}'),
        ),
      );
    } else {
      return Center(
        child: Text('Loading Light List'),
      );
    }
  }
}
