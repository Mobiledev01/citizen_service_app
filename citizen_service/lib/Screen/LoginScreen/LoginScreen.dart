import 'dart:convert';

import 'package:citizen_service/HttpCalls/HttpCall.dart';
import 'package:citizen_service/Model/LoginSessionModel/LoginSessionModel.dart';
import 'package:citizen_service/Screen/HomeScreen/HomeScreen.dart';
import 'package:citizen_service/Screen/LoginScreen/ForgotPassword/ForgotPassword.dart';
import 'package:citizen_service/Screen/OTPScreen/OtpLogin.dart';
import 'package:citizen_service/Screen/Signup/signUp.dart';
import 'package:citizen_service/SqliteDatabase/Database.dart';
import 'package:citizen_service/Utility/Color.dart';
import 'package:citizen_service/Utility/GenralButton.dart';
import 'package:citizen_service/Utility/GetBackground.dart';
import 'package:citizen_service/Utility/String.dart';
import 'package:citizen_service/Utility/Style.dart';
import 'package:citizen_service/Utility/Utility.dart';
import 'package:citizen_service/Utility/Validation.dart';
import 'package:citizen_service/Utility/screensize.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class LoginScreen extends StatefulWidget {
final String id , pass ;

 LoginScreen({required this.id ,required this.pass}) ;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginScreen> {
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  TextEditingController loginMobileController = TextEditingController();

  final FocusNode focusNodeEmail = FocusNode();
  final FocusNode focusNodePassword = FocusNode();
  final FocusNode focusNodeMobile = FocusNode();

  bool _obscureTextPassword = true;
  int _obscureEdittext = 0;
  String Id = '', Pass = '';
  bool _validate = false;

  @override
  void initState() {
    super.initState();

      loginEmailController.text =  widget.id.isEmpty ? '' : widget.pass;
      loginMobileController.text = widget.pass.isEmpty ? '6352909757' : widget.id;
      loginPasswordController.text = widget.pass.isEmpty ? '' : widget.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //backgroundColor: primaryColor,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.1, 0.3, 0.5, 0.7, 0.9],
                colors: [
                whiteColor,
                graysub,
                whiteColor,
                graysub,
                whiteColor
            ])),
        child: Stack(
          children: <Widget>[
            ClipPath(
              clipper: GetBackground(),
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.1, 0.3, 0.7],
                        colors: [primaryColor, secondcolor, thirdcolor])),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Transform.translate(
                offset: Offset(0.0, 210.0),
                child: Material(
                  color: primaryColor,
                  child: Padding(padding: EdgeInsets.all(140)),
                  shape: CircleBorder(
                      side: BorderSide(color: secondcolor, width: 15.0)),
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 30.0),
                      // decoration: BoxDecoration(
                      //   image: DecorationImage(
                      //     image: AssetImage('assets/dialog.png'),
                      //     fit: BoxFit.fill,
                      //   ),
                      // ),
                      child: Card(
                        elevation: 10.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  30.0, 30.0, 30.0, 20.0),
                              child: Center(
                                child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Text(
                                      login.toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 23,
                                          color: blackColor,
                                          fontFamily: 'MS Serif',
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.left,
                                    )),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: TextField(
                                  focusNode: focusNodeMobile,
                                  controller: loginMobileController,
                                  keyboardType: TextInputType.phone,
                                  maxLength: 10,
                                  style: const TextStyle(
                                      fontFamily: 'WorkSansSemiBold',
                                      fontSize: 16.0,
                                      color: blackColor),
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.phone_android_outlined,
                                      color: primaryColor,
                                      size: 22.0,
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: blackColor)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: primaryColor)),
                                    hintText: 'Registered Mobile Number',
                                    errorText: _validate ? 'Please Enter Valid Mobile Number[Start With 6-9]' : null,
                                    hintStyle: TextStyle(
                                        fontFamily: 'WorkSansSemiBold',
                                        fontSize: 17.0,
                                        color: blackColor),
                                  ),
                                  onChanged: (content) {
                                    if(content.isNotEmpty){
                                      loginEmailController.text = '';
                                      loginPasswordController.text = '';
                                    }
                                    if (!mobile(content)){
                                      setState(() {
                                        _validate = true;
                                      });
                                    }else{
                                      setState(() {
                                        _validate = false;
                                      });
                                    }
                                  },
                                  onSubmitted: (_) {
                                    focusNodePassword.requestFocus();
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text('-------------- OR --------------',style: formLabel,),
                            SizedBox(height: 10,),
                            Container(
                              margin: EdgeInsets.fromLTRB(20.0, 0, 20.0, 5.0),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: TextField(
                                  focusNode: focusNodeEmail,
                                  controller: loginEmailController,
                                  keyboardType: TextInputType.emailAddress,
                                  style: const TextStyle(
                                      fontFamily: 'WorkSansSemiBold',
                                      fontSize: 16.0,
                                      color: blackColor),
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: primaryColor,
                                      size: 22.0,
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: blackColor)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: primaryColor)),
                                    hintText: 'User Name',
                                    hintStyle: TextStyle(
                                        fontFamily: 'WorkSansSemiBold',
                                        fontSize: 17.0,
                                        color: blackColor),
                                  ),
                                  onChanged: (content) {
                                    if(content.isNotEmpty){
                                      loginMobileController.text = '';
                                    }
                                  },
                                  onSubmitted: (_) {
                                    focusNodePassword.requestFocus();
                                  },
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: TextField(
                                  focusNode: focusNodePassword,
                                  controller: loginPasswordController,
                                  obscureText: _obscureTextPassword,
                                  style: const TextStyle(
                                    fontFamily: 'WorkSansSemiBold',
                                    fontSize: 16.0,
                                    color: blackColor,
                                  ),
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: primaryColor,
                                      size: 22.0,
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: blackColor)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: primaryColor)),
                                    hintText: 'Password',
                                    hintStyle: const TextStyle(
                                        fontFamily: 'WorkSansSemiBold',
                                        fontSize: 17.0),
                                    suffixIcon: GestureDetector(
                                      onTap: _toggleLogin,
                                      child: Icon(
                                        _obscureTextPassword
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        size: 22.0,
                                        color: blackColor,
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    _toggleEdittext(1);
                                  },
                                  onSubmitted: (_) {
                                    //_toggleSignInButton();
                                  },
                                  textInputAction: TextInputAction.go,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(20.0),
                              child: GestureDetector(
                                child: Text(
                                  'Forgot Password ?',
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassword()));
                                },
                              ),
                            ),
                            MaterialButton(
                              elevation: 10,
                              color: primaryColor,
                              textColor: Colors.white,
                              child: Icon(
                                Icons.arrow_forward,
                                size: 25,
                              ),
                              padding: EdgeInsets.all(15),
                              shape: CircleBorder(),
                              onPressed: () {
                                getLoginSession(context);
                              },
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text('Don' 't have an Account ? ',
                                      style: TextStyle(
                                        color: blackColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.center),
                                  GestureDetector(
                                    child: Text(' User Registration',
                                        style: TextStyle(
                                          color: primaryColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          decoration: TextDecoration.underline,
                                        ),
                                        textAlign: TextAlign.right),
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
                                    },
                                  ),
                                ],
                              ),
                            ),
                           /* Padding(
                              padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 20.0),
                              child: GestureDetector(
                                child: Text('* Switch to Demo Mode *',
                                    style: TextStyle(
                                      color: blackColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      decoration: TextDecoration.underline,
                                    ),
                                    textAlign: TextAlign.right),
                                onTap: () {
                                  globals.isTrainingMode = true;
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomeScreen()));
                                },
                              ),
                            ),*/
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    focusNodeEmail.dispose();
    focusNodePassword.dispose();
    super.dispose();
  }

  void _toggleLogin() {
    setState(() {
      _obscureTextPassword = !_obscureTextPassword;
    });
  }

  void _toggleEdittext(int index) {
    setState(() {
      _obscureEdittext = index;
    });
  }

  Future<void> getLoginSession(BuildContext context) async {

    if(loginMobileController.text.isEmpty && loginEmailController.text.isEmpty && loginPasswordController.text.isEmpty){
      showErrorToast('Please attempt any one login option');
    } else if(loginEmailController.text.isNotEmpty &&  loginPasswordController.text.isEmpty){
      showErrorToast('Please Enter Password');
    } else if(loginEmailController.text.isEmpty &&  loginPasswordController.text.isNotEmpty){
      showErrorToast('Please Enter UserName');
    }
    // if (loginEmailController.text.isEmpty) {
    //   showErrorToast('Please Enter UserName');
    // } else if (loginPasswordController.text.isEmpty) {
    //   showErrorToast('Please Enter Password');
    // }
    else {

      var data = {
        'mobile_no':loginMobileController.text,
        'email_id':loginEmailController.text,
        'password':loginPasswordController.text
      };

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => OtpLogin(data: jsonEncode(data),)));

    }
  }
}
