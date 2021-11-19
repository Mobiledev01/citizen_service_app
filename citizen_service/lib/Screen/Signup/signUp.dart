import 'package:citizen_service/Utility/themeData.dart';
import 'package:citizen_service/Utility/Style.dart';
import 'package:citizen_service/Utility/screensize.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'SignUpForm.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: new Theme(
            data: theme(),
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.topLeft,
                            child: IconButton (
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.close_outlined)
                            )
                        ),
                        SizedBox(height: SizeConfig.screenHeight * 0.02),
                        Text("Register New Citizen", style: headingStyle),
                        Text(
                          "Complete your details to continue \n with Bapuji Seva Kendra",
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: SizeConfig.screenHeight * 0.04),
                        SignUpForm(),
                        SizedBox(height: SizeConfig.screenHeight * 0.04),
                        SizedBox(height: getProportionateScreenHeight(8)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
