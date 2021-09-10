import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/View/widgets/navbar.dart';
import 'package:mobile/View/decorations/decorations.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: primaryColor,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Colors.transparent,
        border: null,
        middle: Text(
          'Settings',
          style: TextStyle(fontSize: 25),
        ),
      ),
      child: Container(
        child: Navbar(),
      ),
    );
  }
}
