import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class SyncLights extends StatefulWidget {
  @override
  _SyncLightsState createState() => _SyncLightsState();
}

class _SyncLightsState extends State<SyncLights> {
  @override
  void initState() {
    super.initState();
  }

  void getLocalBridges() async {
    var url = Uri.parse('http://localhost:3000/bridges');
    var response = await http.get(url);
    setState(() {
      print(response.body);
    });
  }

  void syncLights() async {
    var url = Uri.parse('http://localhost:3000/sync');
    var response = await http.get(url);
    setState(() {
      print('Syncing lights. ');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Light Sync',
      home: Scaffold(
        appBar: AppBar(title: const Text('Weather Light Sync')),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  getLocalBridges();
                },
                child: Text("Get Bridges on Local Network"),
              ),
              ElevatedButton(
                onPressed: () {
                  syncLights();
                },
                child: Text("Sync Lights"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
