import 'dart:convert';

import 'package:citizen_service/HttpCalls/HttpCall.dart';
import 'package:citizen_service/Screen/HomeScreen/HomeScreen.dart';
import 'package:citizen_service/Screen/LoginScreen/LoginScreen.dart';
import 'package:citizen_service/Utility/Color.dart';
import 'package:citizen_service/Utility/GenralButton.dart';
import 'package:citizen_service/Utility/Loading.dart';
import 'package:citizen_service/Utility/Style.dart';
import 'package:citizen_service/Utility/Utility.dart';
import 'package:flutter/material.dart';
import '../../Utility/screensize.dart';

class OtpScreen extends StatefulWidget {
  final String data;

  const OtpScreen({Key? key, required this.data}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String json = '';

  final pin2FocusNode = FocusNode();
  final pin1FocusNode = FocusNode();
  final pin3FocusNode = FocusNode();
  final pin4FocusNode = FocusNode();
  final pin5FocusNode = FocusNode();
  final pin6FocusNode = FocusNode();

  final con_1 = TextEditingController();
  final con_2 = TextEditingController();
  final con_3 = TextEditingController();
  final con_4 = TextEditingController();
  final con_5 = TextEditingController();
  var input;

  @override
  void initState() {
    super.initState();
    json = widget.data;
    input = jsonDecode(json);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("OTP Verification"),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.05),
                Text(
                  "OTP Verification",
                  style: headingStyle,
                ),
                Text("We sent your code to +1 898 860 ***"),
                buildTimer(),
                Form(
                  child: Column(
                    children: [
                      SizedBox(height: SizeConfig.screenHeight * 0.10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: getProportionateScreenWidth(40),
                            child: TextFormField(
                              autofocus: true,
                              focusNode: pin1FocusNode,
                              controller: con_1,
                              style: TextStyle(fontSize: 24),
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              maxLength: 1,
                              decoration: otpInputDecoration,
                              onChanged: (value) {
                                if (value.length == 1) {
                                  pin2FocusNode.requestFocus();
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            width: getProportionateScreenWidth(40),
                            child: TextFormField(
                              focusNode: pin2FocusNode,
                              controller: con_2,
                              style: TextStyle(fontSize: 24),
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              decoration: otpInputDecoration,
                              maxLength: 1,
                              onChanged: (value) {
                                if (value.length == 1) {
                                  pin3FocusNode.requestFocus();
                                } else if (value.length == 0) {
                                  pin1FocusNode.requestFocus();
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            width: getProportionateScreenWidth(40),
                            child: TextFormField(
                                focusNode: pin3FocusNode,
                                controller: con_3,
                                style: TextStyle(fontSize: 24),
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                decoration: otpInputDecoration,
                                maxLength: 1,
                                onChanged: (value) {
                                  if (value.length == 1) {
                                    pin4FocusNode.requestFocus();
                                  } else if (value.length == 0) {
                                    pin2FocusNode.requestFocus();
                                  }
                                }),
                          ),
                          SizedBox(
                            width: getProportionateScreenWidth(40),
                            child: TextFormField(
                                focusNode: pin4FocusNode,
                                controller: con_4,
                                maxLength: 1,
                                style: TextStyle(fontSize: 24),
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                decoration: otpInputDecoration,
                                onChanged: (value) {
                                  if (value.length == 1) {
                                    pin5FocusNode.requestFocus();
                                  } else if (value.length == 0) {
                                    pin3FocusNode.requestFocus();
                                  }
                                }),
                          ),
                          SizedBox(
                            width: getProportionateScreenWidth(40),
                            child: TextFormField(
                              focusNode: pin5FocusNode,
                              controller: con_5,
                              maxLength: 1,
                              style: TextStyle(fontSize: 24),
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              decoration: otpInputDecoration,
                              onChanged: (value) {
                                if (value.length == 1) {
                                  pin5FocusNode.unfocus();
                                } else if (value.length == 0) {
                                  pin4FocusNode.requestFocus();
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.15),
                      DefaultButton(
                        text: "Register",
                        press: () async {
                          String Otp = con_1.text +
                              con_2.text +
                              con_3.text +
                              con_4.text +
                              con_5.text;

                          if (Otp == "55555") {
                            registerCall();
                          } else {
                            showMessageToast("Invalid Otp");
                          }
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.1),
                GestureDetector(
                  onTap: () {
                    // OTP code resend
                  },
                  child: Text(
                    "Resend OTP Code",
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("This code will expired in "),
        TweenAnimationBuilder(
          tween: Tween(begin: 30.0, end: 0.0),
          duration: Duration(seconds: 30),
          builder: (_, dynamic value, child) => Text(
            "00:${value.toInt()}",
            style: TextStyle(color: Color(0xFFFF7643)),
          ),
        ),
      ],
    );
  }

  void registerCall() async {
    showDialogWithLoad(context);
    var map = (await httpFromDataPostMethod(
        '/csAjax/saveCitizenRegistrationData/61', jsonDecode(json)));
    if (map['Status'] == 1000) {
      if (map['Body'] != null) {
        var json = jsonDecode(map['Body']);
        if (json['message_description'] == "Citizen Registration Sucessfull.") {
          showMessageToast(json['message_description']);

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => LoginScreen(
                      pass: input['email_id'].toString(),
                      id: input['password'].toString())));
        } else {
          showMessageToast(json['message_description']);
        }
      }
    } else if (map['Status'] == 999) {
      showMessageToast("User is already exist");
    }
  }
}
