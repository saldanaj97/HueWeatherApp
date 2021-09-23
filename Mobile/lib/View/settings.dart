import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:mobile/View/widgets/navbar.dart';
import 'package:mobile/View/decorations/decorations.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    List tabActive = [
      [1, false],
      [2, false],
      [3, true]
    ];
    // For this list the 1st index is for hue settings, 2nd is for LIFX (coming soon), 3rd for location
    List settingsItems = [
      ['Hue Bridge Selection', 'All Lights'], // Hue Settings
      ['Location Permissions'] // Location settings
    ];

    return CupertinoPageScaffold(
      backgroundColor: primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(
              left: 30,
              top: 45,
            ),
            child: Text(
              'Settings',
              style: title,
            ),
          ),
          Container(
            height: height * .68,
            width: width * 1,
            child: ListView.builder(
              itemCount: settingsItems.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.only(left: 25, right: 25, bottom: 25),
                  child: Neumorphic(
                    style: neumorphicBox,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: settingsListGrouping(settingsItems, index, context),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: Navbar(tabActive),
          )
        ],
      ),
    );
  }

  List<Widget> settingsListGrouping(List settingsItems, int settingToChange, BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    List<Widget> grouping = [];
    String settingCategory = '';
    int settingCategoryCounter = 0; // This counter will track where in the list we are

    if (settingToChange == 0) {
      settingCategory = 'hue';
    } else {
      settingCategory = 'location';
    }

    // Add each container to the grouping list
    settingsItems[settingToChange].forEach(
      (setting) {
        // Generate the route for the correct settings page
        var route = '/settings/${settingCategory}/${settingCategoryCounter}';

        // Increment the counter manually to advance in the list
        settingCategoryCounter += 1;

        // Add each settings list item to the grouping list
        grouping.add(
          Container(
            width: width / 1.15,
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    setting,
                    style: TextStyle(fontSize: width * .04, color: Colors.white),
                  ),
                ),
                Container(
                  child: CupertinoButton(
                    child: Icon(
                      CupertinoIcons.right_chevron,
                      color: Colors.white,
                      size: height * .025,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, route);
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
    return grouping;
  }
}
