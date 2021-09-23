import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:mobile/Model/light.dart';
import 'package:mobile/Service/lightservice.dart';
import 'package:mobile/View/decorations/decorations.dart';
import 'package:mobile/View/skeleton_screens/lightSkeleton.dart';

class LightsView extends StatefulWidget {
  const LightsView({Key? key}) : super(key: key);
  @override
  _LightsViewState createState() => _LightsViewState();
}

class _LightsViewState extends State<LightsView> {
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
                  // Set the global list of lights equal to the list we just read in from the bridge
                  Light.listOfLights = lights;

                  // Now set the global ValueNotifier for each light widgets on/off switches
                  Light.listOfLights.forEach((light) {
                    light.lightState.poweredOn.value = light.lightState.on;
                  });
                }),
              }),
        });
  }

  @override
  Widget build(BuildContext context) {
    List _lights = Light.listOfLights;

    // Data is ready
    if (_lights.isNotEmpty) {
      return Container(
        child: Column(
          children: [
            SizedBox(
              height: 175,
              child: ListView.builder(
                itemCount: _lights.length,
                padding: EdgeInsets.all(0),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: lightItem(_lights[index]),
                  );
                },
              ),
            ),
          ],
        ),
      );
    } else {
      // Data is loading
      return LightsSkeletonLoading();
    }
  }

// Widget for each individual light container in the list
  Widget lightItem(var light) {
    LightService _lightService = LightService();
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 10),
      width: width / 1.15,
      child: Neumorphic(
        style: neumorphicBox,
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(15),
                alignment: Alignment.centerLeft,
                child: Text(
                  light.lightInfo.name,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: width * .035, color: Colors.white),
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                child: ValueListenableBuilder<bool>(
                  builder: (BuildContext context, bool value, Widget? child) {
                    // This builder will only get called when the light power
                    // is updated.
                    return CupertinoSwitch(
                      value: light.lightState.on,
                      activeColor: Color.fromRGBO(30, 30, 50, 1),
                      onChanged: (bool value) {
                        light.lightState.poweredOn.value = value;
                        light.lightState.on = value;
                        _lightService.setLights(light.id, value, light.lightState.bri);
                      },
                    );
                  },
                  valueListenable: light.lightState.poweredOn,
                  // The child parameter is most helpful if the child is
                  // expensive to build and does not depend on the value from
                  // the notifier.
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
