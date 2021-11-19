import 'dart:async';

import 'package:citizen_service/Model/LoginSessionModel/LoginSessionModel.dart';
import 'package:citizen_service/Screen/HomeScreen/HomeScreen.dart';
import 'package:citizen_service/Screen/LoginScreen/LoginScreen.dart';
import 'package:citizen_service/SqliteDatabase/Database.dart';
import 'package:flutter/material.dart';
import '../../Utility/Style.dart';
import '../../Utility/String.dart';
import 'package:citizen_service/GlobalsVariable/GlobalsVariable.dart'
as globals;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkSessionData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.green[600],
        appBar: null,
        body:Center(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(10),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 100,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    // Text(
                    //   appName,
                    //   style: style,
                    //   textAlign: TextAlign.center,
                    // ),
                    Image.asset(
                      'assets/logo.png',
                      height: 80,
                      width: 250,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      developBy,
                      style: blackBoldText18,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row (
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          'assets/ictinfracon.png',
                          height: 80,
                          width: 80,
                        ),
                        Image.asset(
                          'assets/rdpr.png',
                          height: 80,
                          width: 80,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Future<void> checkSessionData() async {
    LoginSessionModel? sessionModel = await DatabaseOperation.instance.getLoginSession();
    if (sessionModel != null && sessionModel.csLoginId != null) {
      globals.loginSessionModel = sessionModel;
      Timer(
          Duration(seconds: 4),
              () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomeScreen())));
      } else {
      Timer(
          Duration(seconds: 4),
              () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginScreen(id: '', pass: ''))));

    }
  }
}
