import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class AddLights extends StatefulWidget {
  @override
  _AddLightsState createState() => _AddLightsState();
}

class _AddLightsState extends State<AddLights> {
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

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Weather Light Sync',
      home: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('Add Lights', style: TextStyle(fontSize: 25)),
        ),
        child: SafeArea(
          child: Container(
            child: Text('Hey'),
          ),
        ),
      ),
    );
  }
}
