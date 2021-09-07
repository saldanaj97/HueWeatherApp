import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile/Controller/location.dart';
import 'package:mobile/View/light.dart';
import 'package:mobile/View/settings.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.lightbulb), label: 'Lights'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.settings), label: 'Settings'),
        ],
      ),
      tabBuilder: (context, index) {
        late final CupertinoTabView returnValue;
        switch (index) {
          case 0:
            returnValue = CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: LightsView(),
              );
            });
            break;
          case 1:
            returnValue = CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: SettingsView(),
              );
            });
            break;
        }
        return returnValue;
      },
    );
  }
}
