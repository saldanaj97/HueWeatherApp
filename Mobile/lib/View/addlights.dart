import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AddLights extends StatefulWidget {
  @override
  _AddLightsState createState() => _AddLightsState();
}

class _AddLightsState extends State<AddLights> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('View My Lights'),
        trailing: MaterialButton(
            child: Icon(
              CupertinoIcons.add,
              color: CupertinoColors.activeOrange,
            ),
            onPressed: () {}),
      ),
      child: SafeArea(
        child: Container(
          child: Text('Hey'),
        ),
      ),
    );
  }
}
