
import 'dart:async';

import 'package:citizen_service/Screen/CategoryScreen/CategoryScreen.dart';
import 'package:citizen_service/Screen/Dashboard/Dashboard.dart';
import 'package:citizen_service/Utility/Color.dart';
import 'package:citizen_service/Utility/Utility.dart';
import 'package:citizen_service/custom_drawer/drawer_user_controller.dart';
import 'package:citizen_service/custom_drawer/home_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  @override
  _NavigationHomeScreenState createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<HomeScreen> {
  Widget? screenView;
  DrawerIndex? drawerIndex;
  int backButton = 0;

  @override
  void initState() {
    drawerIndex = DrawerIndex.dashboard;
    screenView =  Dashboard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color:whiteColor,
      child: SafeArea(
        top: false,
        bottom: false,
        child: WillPopScope(
          onWillPop: () async {

            if (backButton == 0) {
              showMessageToast('Tap again to Exit App');
              setState(() {
                backButton = backButton + 1;
              });
              Timer(Duration(seconds: 3), () {setState(() {backButton = 0;});
              SystemNavigator.pop();
              });
              return false;
            } else {
              return true;
            }

          },
          child: Scaffold(
            backgroundColor: whiteColor,
            body: DrawerUserController(
              screenIndex: drawerIndex,
              drawerWidth: MediaQuery.of(context).size.width * 0.75,
              onDrawerCall: (DrawerIndex drawerIndexdata) {
                changeIndex(drawerIndexdata);
              },
              screenView: screenView,
              //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
            ),
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      if (drawerIndex == DrawerIndex.home) {
        setState(() {
          screenView = CategoryScreen();
        });
      } else if (drawerIndex == DrawerIndex.grievance) {
        showMessageToast('Coming Soon Grievance..');
      } else if (drawerIndex == DrawerIndex.taxpayment) {
        showMessageToast('Coming Soon Tax Payment..');
      } else if (drawerIndex == DrawerIndex.status) {
        showMessageToast('Coming Soon..');
      } else if (drawerIndex == DrawerIndex.dashboard) {
        setState(() {
          screenView = Dashboard();
        });
      }else {
        showMessageToast('Coming Soon..');
      }
    }
  }

}
