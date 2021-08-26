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
              largeTitle: Text('Lights'),
            ),
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 250,
                mainAxisSpacing: 5.0,
                crossAxisSpacing: 5.0,
                childAspectRatio: 1.0,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, int index) {
                  return Container(
                    alignment: Alignment.center,
                    color: CupertinoColors.darkBackgroundGray,
                    child: Text(_lights[index].lightInfo.name),
                  );
                },
                childCount: _lights.length,
              ),
            )
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
}
