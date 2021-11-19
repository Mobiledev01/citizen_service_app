import 'dart:convert';

import 'package:citizen_service/HttpCalls/HttpCall.dart';
import 'package:citizen_service/Screen/OTPScreen/otp_screen.dart';
import 'package:citizen_service/Utility/Color.dart';
import 'package:citizen_service/Utility/GetBackground.dart';
import 'package:citizen_service/Utility/String.dart';
import 'package:citizen_service/Utility/Utility.dart';
import 'package:citizen_service/Utility/Validation.dart';
import 'package:flutter/material.dart';
// import 'package:translator/translator.dart';

class SingUpScreen extends StatefulWidget {
  const SingUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SingUpScreen> {
  final firstNameE = TextEditingController();
  final middleNameE = TextEditingController();
  final lastNameE = TextEditingController();
  final firstNameKn = TextEditingController();
  final middleNameKn = TextEditingController();
  final lastNameKn = TextEditingController();
  final email_ = TextEditingController();
  final mobileNumber_ = TextEditingController();
  final password_ = TextEditingController();
  final conPassword_ = TextEditingController();

  final firstNameEFocusNode = FocusNode();
  final middleNameEFocusNode = FocusNode();
  final lastNameEFocusNode = FocusNode();
  final firstNameKnFocusNode = FocusNode();
  final lastNameKnFocusNode = FocusNode();
  final middleNameKnFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final mobileNumberFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final conPasswordFocusNode = FocusNode();

  final formKeyApplicantDetails = GlobalKey<FormState>();

  // final translator = GoogleTranslator();

  bool _obscureTextPassword = true;
  bool _obscureTextConfirmPassword = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // focusNodeFirstNameKn.addListener(_onOnFocusNodeEvent);
  }

  // _onOnFocusNodeEvent() async {
  //   if (focusNodeFirstNameKn.hasFocus &&
  //       regFirstNameKnController.text.isNotEmpty) {
  //     var translation = await translator
  //         .translate(regFirstNameKnController.text.trim(), from: 'kn', to: 'en');
  //     print(translation.text);
  //     regFirstNameKnController.text = translation.text;
  //     regFirstNameKnController.selection = TextSelection.fromPosition(
  //         TextPosition(offset: regFirstNameKnController.text.length));
  //   }
  //
  //   if (!focusNodeFirstNameKn.hasFocus &&
  //       regFirstNameKnController.text.isNotEmpty) {
  //     var translation = await translator
  //         .translate(regFirstNameKnController.text.trim(), from: 'en', to: 'kn');
  //     print(translation.text);
  //     regFirstNameKnController.text = translation.text;
  //   }
  // }

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
                stops: [
              0.1,
              0.3,
              0.5,
              0.7,
              0.9
            ],
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
                  color: secondcolor,
                  child: Padding(padding: EdgeInsets.all(140)),
                  shape: CircleBorder(
                      side: BorderSide(color: thirdcolor, width: 15.0)),
                ),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Container(
                  margin: EdgeInsets.fromLTRB(5.0, 50.0, 5.0, 20.0),
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                    child: Form(
                      key: formKeyApplicantDetails,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Center(
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Text(
                                    register.toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: primaryColor,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  )),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              border: Border.all(
                                  color: primaryColor, // Set border color
                                  width: 1.0),
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 10,
                                    spreadRadius: 4,
                                    color: Colors.grey.withOpacity(0.5),
                                    offset: Offset(1, 3))
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: TextFormField(
                                focusNode: firstNameEFocusNode,
                                controller: firstNameE,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                onFieldSubmitted: (String value) {
                                  middleNameEFocusNode.requestFocus();
                                },
                                validator: (name) {
                                  if (name.toString().isEmpty)
                                    return 'Enter applicant name';
                                  else if (!simpleText(name!))
                                    return 'Please Enter Only Text';
                                  else
                                    return null;
                                },
                                keyboardType: TextInputType.text,
                                style: const TextStyle(
                                    fontFamily: 'WorkSansSemiBold',
                                    fontSize: 16.0,
                                    color: blackColor),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  icon: Icon(Icons.person,
                                      color: blackColor, size: 22.0),
                                  hintText: first_name,
                                  hintStyle: TextStyle(
                                      fontFamily: 'WorkSansSemiBold',
                                      fontSize: 17.0),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              border: Border.all(
                                  color: primaryColor, // Set border color
                                  width: 1.0),
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [

                                BoxShadow(
                                    blurRadius: 10,
                                    spreadRadius: 4,
                                    color: Colors.grey.withOpacity(0.5),
                                    offset: Offset(1, 3))
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: TextFormField(
                                focusNode: middleNameEFocusNode,
                                controller: middleNameE,
                                keyboardType: TextInputType.text,
                                autovalidateMode:AutovalidateMode.onUserInteraction,
                                onFieldSubmitted: (String value) {
                                  lastNameEFocusNode.requestFocus();
                                },
                                validator: (name) {
                                  if (name.toString().isEmpty)
                                    return 'Enter applicant name';
                                  else if (!simpleText(name!))
                                    return 'Please Enter Only Text';
                                  else
                                    return null;
                                },
                                style: const TextStyle(
                                    fontFamily: 'WorkSansSemiBold',
                                    fontSize: 16.0,
                                    color: blackColor),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  icon: Icon(
                                    Icons.person,
                                    color: blackColor,
                                    size: 22.0,
                                  ),
                                  hintText: middle_name,
                                  hintStyle: TextStyle(
                                      fontFamily: 'WorkSansSemiBold',
                                      fontSize: 17.0),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              border: Border.all(
                                  color: primaryColor, // Set border color
                                  width: 1.0),
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 10,
                                    spreadRadius: 4,
                                    color: Colors.grey.withOpacity(0.5),
                                    offset: Offset(1, 3))
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: TextFormField(
                                focusNode: lastNameEFocusNode,
                                controller: lastNameE,
                                keyboardType: TextInputType.text,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                onFieldSubmitted: (String value) {
                                  firstNameKnFocusNode.requestFocus();
                                },
                                validator: (name) {
                                  if (name.toString().isEmpty)
                                    return 'Enter applicant name';
                                  else if (!simpleText(name!))
                                    return 'Please Enter Only Text';
                                  else
                                    return null;
                                },
                                style: const TextStyle(
                                    fontFamily: 'WorkSansSemiBold',
                                    fontSize: 16.0,
                                    color: blackColor),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  icon: Icon(
                                    Icons.person,
                                    color: blackColor,
                                    size: 22.0,
                                  ),
                                  hintText: last_name,
                                  hintStyle: TextStyle(
                                      fontFamily: 'WorkSansSemiBold',
                                      fontSize: 17.0),
                                ),
                              ),
                            ),
                          ),
                          // Container(
                          //   margin: EdgeInsets.all(5.0),
                          //   decoration: BoxDecoration(
                          //     color: Colors.grey[100],
                          //     border: Border.all(
                          //         color: primaryColor, // Set border color
                          //         width: 1.0),
                          //     borderRadius: BorderRadius.circular(5),
                          //     boxShadow: [
                          //       BoxShadow(
                          //           blurRadius: 10,
                          //           spreadRadius: 4,
                          //           color: Colors.grey.withOpacity(0.5),
                          //           offset: Offset(1, 3))
                          //     ],
                          //   ),
                          //   child: Padding(
                          //     padding: const EdgeInsets.all(5.0),
                          //     child: TextFormField(
                          //       focusNode: firstNameKnFocusNode,
                          //       controller: firstNameKn,
                          //       onFieldSubmitted: (String value) {
                          //         lastNameKnFocusNode.requestFocus();
                          //       },
                          //       autovalidateMode:
                          //           AutovalidateMode.onUserInteraction,
                          //       keyboardType: TextInputType.text,
                          //       style: const TextStyle(
                          //           fontFamily: 'WorkSansSemiBold',
                          //           fontSize: 16.0,
                          //           color: blackColor),
                          //       decoration: InputDecoration(
                          //         border: InputBorder.none,
                          //         icon: Icon(
                          //           Icons.person,
                          //           color: blackColor,
                          //           size: 22.0,
                          //         ),
                          //         hintText: first_name_kn,
                          //         hintStyle: TextStyle(
                          //             fontFamily: 'WorkSansSemiBold',
                          //             fontSize: 17.0),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // Container(
                          //   margin: EdgeInsets.all(5.0),
                          //   decoration: BoxDecoration(
                          //     color: Colors.grey[100],
                          //     border: Border.all(
                          //         color: primaryColor, // Set border color
                          //         width: 1.0),
                          //     borderRadius: BorderRadius.circular(5),
                          //     boxShadow: [
                          //       BoxShadow(
                          //           blurRadius: 10,
                          //           spreadRadius: 4,
                          //           color: Colors.grey.withOpacity(0.5),
                          //           offset: Offset(1, 3))
                          //     ],
                          //   ),
                          //   child: Padding(
                          //     padding: const EdgeInsets.all(5.0),
                          //     child: TextFormField(
                          //       focusNode: lastNameKnFocusNode,
                          //       controller: lastNameKn,
                          //       autovalidateMode:
                          //           AutovalidateMode.onUserInteraction,
                          //       onFieldSubmitted: (String value) {
                          //         middleNameKnFocusNode.requestFocus();
                          //       },
                          //       keyboardType: TextInputType.text,
                          //       style: const TextStyle(
                          //           fontFamily: 'WorkSansSemiBold',
                          //           fontSize: 16.0,
                          //           color: blackColor),
                          //       decoration: InputDecoration(
                          //         border: InputBorder.none,
                          //         icon: Icon(
                          //           Icons.person,
                          //           color: blackColor,
                          //           size: 22.0,
                          //         ),
                          //         hintText: middle_name_kn,
                          //         hintStyle: TextStyle(
                          //             fontFamily: 'WorkSansSemiBold',
                          //             fontSize: 17.0),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // Container(
                          //   margin: EdgeInsets.all(5.0),
                          //   decoration: BoxDecoration(
                          //     color: Colors.grey[100],
                          //     border: Border.all(
                          //         color: primaryColor, // Set border color
                          //         width: 1.0),
                          //     borderRadius: BorderRadius.circular(5),
                          //     boxShadow: [
                          //       BoxShadow(
                          //           blurRadius: 10,
                          //           spreadRadius: 4,
                          //           color: Colors.grey.withOpacity(0.5),
                          //           offset: Offset(1, 3))
                          //     ],
                          //   ),
                          //   child: Padding(
                          //     padding: const EdgeInsets.all(5.0),
                          //     child: TextFormField(
                          //       focusNode: middleNameKnFocusNode,
                          //       controller: middleNameKn,
                          //       autovalidateMode:
                          //           AutovalidateMode.onUserInteraction,
                          //       onFieldSubmitted: (String value) {
                          //         emailFocusNode.requestFocus();
                          //       },
                          //
                          //       keyboardType: TextInputType.text,
                          //       style: const TextStyle(
                          //           fontFamily: 'WorkSansSemiBold',
                          //           fontSize: 16.0,
                          //           color: blackColor),
                          //       decoration: InputDecoration(
                          //         border: InputBorder.none,
                          //         icon: Icon(
                          //           Icons.person,
                          //           color: blackColor,
                          //           size: 22.0,
                          //         ),
                          //         hintText: last_name_kn,
                          //         hintStyle: TextStyle(
                          //             fontFamily: 'WorkSansSemiBold',
                          //             fontSize: 17.0),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          Container(
                            margin: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              border: Border.all(
                                  color: primaryColor, // Set border color
                                  width: 1.0),
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 10,
                                    spreadRadius: 4,
                                    color: Colors.grey.withOpacity(0.5),
                                    offset: Offset(1, 3))
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: TextFormField(
                                focusNode: emailFocusNode,
                                controller: email_,
                                onFieldSubmitted: (String value) {
                                  mobileNumberFocusNode.requestFocus();
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (email) {
                                  if (email.toString().isEmpty)
                                    return 'Enter email ID';
                                  else if (!validEmail(email!))
                                    return 'Enter valid email ID';
                                  else
                                    return null;
                                },
                                keyboardType: TextInputType.emailAddress,
                                style: const TextStyle(
                                    fontFamily: 'WorkSansSemiBold',
                                    fontSize: 16.0,
                                    color: blackColor),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  icon: Icon(
                                    Icons.email,
                                    color: blackColor,
                                    size: 22.0,
                                  ),
                                  hintText: 'Email Address',
                                  hintStyle: TextStyle(
                                      fontFamily: 'WorkSansSemiBold',
                                      fontSize: 17.0),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              border: Border.all(
                                  color: primaryColor, // Set border color
                                  width: 1.0),
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 10,
                                    spreadRadius: 4,
                                    color: Colors.grey.withOpacity(0.5),
                                    offset: Offset(1, 3))
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: TextFormField(
                                focusNode: mobileNumberFocusNode,
                                controller: mobileNumber_,
                                maxLength: 10,
                                onFieldSubmitted: (String value) {
                                  passwordFocusNode.requestFocus();
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (mobileNo) {
                                  if (mobileNo.toString().isEmpty)
                                    return 'Enter mobile number';
                                  else if (!mobile(mobileNo!))
                                    return 'Please Enter Valid Mobile Number';
                                  else
                                    return null;
                                },
                                keyboardType: TextInputType.phone,
                                style: const TextStyle(
                                    fontFamily: 'WorkSansSemiBold',
                                    fontSize: 16.0,
                                    color: blackColor),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  icon: Icon(
                                    Icons.phone_android_outlined,
                                    color: blackColor,
                                    size: 22.0,
                                  ),
                                  hintText: 'Mobile Number',
                                  hintStyle: TextStyle(
                                      fontFamily: 'WorkSansSemiBold',
                                      fontSize: 17.0),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              border: Border.all(
                                  color: primaryColor, // Set border color
                                  width: 1.0),
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 10,
                                    spreadRadius: 4,
                                    color: Colors.grey.withOpacity(0.5),
                                    offset: Offset(1, 3))
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: TextFormField(
                                focusNode: passwordFocusNode,
                                controller: password_,
                                onFieldSubmitted: (String value) {
                                  conPasswordFocusNode.requestFocus();
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (pass) {
                                  if (pass.toString().isEmpty)
                                    return 'Enter Password';
                                  else if (!password(pass!))
                                    return 'Please Enter Valid Password';
                                  else
                                    return null;
                                },
                                obscureText: _obscureTextPassword,
                                style: const TextStyle(
                                    fontFamily: 'WorkSansSemiBold',
                                    fontSize: 16.0,
                                    color: blackColor),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  icon: const Icon(
                                    Icons.lock,
                                    size: 22.0,
                                    color: blackColor,
                                  ),
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
                                      size: 20.0,
                                      color: blackColor,
                                    ),
                                  ),
                                ),
                                textInputAction: TextInputAction.go,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              border: Border.all(
                                  color: primaryColor, // Set border color
                                  width: 1.0),
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 10,
                                    spreadRadius: 4,
                                    color: Colors.grey.withOpacity(0.5),
                                    offset: Offset(1, 3))
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: TextFormField(
                                focusNode: conPasswordFocusNode,
                                controller: conPassword_,
                                obscureText: _obscureTextConfirmPassword,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (pass) {
                                  if (pass.toString().isEmpty)
                                    return 'Enter Password';
                                  else if (password_.text != pass)
                                    return 'Password Must Be Same';
                                  else
                                    return null;
                                },
                                style: const TextStyle(
                                    fontFamily: 'WorkSansSemiBold',
                                    fontSize: 16.0,
                                    color: blackColor),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  icon: const Icon(
                                    Icons.lock,
                                    size: 22.0,
                                    color: blackColor,
                                  ),
                                  hintText: 'Confirm Password',
                                  hintStyle: const TextStyle(
                                      fontFamily: 'WorkSansSemiBold',
                                      fontSize: 17.0),
                                  suffixIcon: GestureDetector(
                                    onTap: _toggleLoginConfirm,
                                    child: Icon(
                                      _obscureTextConfirmPassword
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      size: 20.0,
                                      color: blackColor,
                                    ),
                                  ),
                                ),
                                textInputAction: TextInputAction.go,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Container(
                              padding: const EdgeInsets.all(7.0),
                              decoration: ShapeDecoration(
                                  shadows: <BoxShadow>[
                                    BoxShadow(
                                        blurRadius: 10,
                                        spreadRadius: 5,
                                        color: Colors.grey.withOpacity(0.5),
                                        offset: Offset(1, 3))
                                  ],
                                  shape: StadiumBorder(),
                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        primaryColor,
                                        secondcolor,
                                        primaryColor
                                      ])),
                              child: MaterialButton(
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                shape: StadiumBorder(),
                                child: Text(
                                  'Verify',
                                  style: TextStyle(
                                      color: whiteColor, fontSize: 20),
                                ),
                                onPressed: () {
                                  registerCall();
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(5.0),
                            child: GestureDetector(
                              child: Text(
                                'Already Register ?',
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      /*body: Center(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Center(
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            'Register New Citizen'.toUpperCase(),
                            style: TextStyle(
                                fontSize: 20,
                                color: blackColor,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          )),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                        focusNode: focusNodeFullName,
                        controller: loginEmailController,
                        keyboardType: TextInputType.text,
                        style: const TextStyle(
                            fontFamily: 'WorkSansSemiBold',
                            fontSize: 16.0,
                            color: Colors.black),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.person,
                            color: Colors.black,
                            size: 22.0,
                          ),
                          hintText: 'Full Name',
                          hintStyle: TextStyle(
                              fontFamily: 'WorkSansSemiBold', fontSize: 17.0),
                        ),
                        onSubmitted: (_) {
                          focusNodeEmail.requestFocus();
                        },
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                        focusNode: focusNodeEmail,
                        controller: loginEmailController,
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(
                            fontFamily: 'WorkSansSemiBold',
                            fontSize: 16.0,
                            color: Colors.black),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.email,
                            color: Colors.black,
                            size: 22.0,
                          ),
                          hintText: 'Email Address',
                          hintStyle: TextStyle(
                              fontFamily: 'WorkSansSemiBold', fontSize: 17.0),
                        ),
                        onSubmitted: (_) {
                          focusNodeMobileNumber.requestFocus();
                        },
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                        focusNode: focusNodeMobileNumber,
                        controller: loginEmailController,
                        keyboardType: TextInputType.phone,
                        style: const TextStyle(
                            fontFamily: 'WorkSansSemiBold',
                            fontSize: 16.0,
                            color: Colors.black),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.phone_android_outlined,
                            color: Colors.black,
                            size: 22.0,
                          ),
                          hintText: 'Mobile Number',
                          hintStyle: TextStyle(
                              fontFamily: 'WorkSansSemiBold', fontSize: 17.0),
                        ),
                        onSubmitted: (_) {
                          focusNodePassword.requestFocus();
                        },
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                        focusNode: focusNodePassword,
                        controller: loginPasswordController,
                        obscureText: _obscureTextPassword,
                        style: const TextStyle(
                            fontFamily: 'WorkSansSemiBold',
                            fontSize: 16.0,
                            color: Colors.black),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: const Icon(
                            Icons.lock,
                            size: 22.0,
                            color: Colors.black,
                          ),
                          hintText: 'Password',
                          hintStyle: const TextStyle(
                              fontFamily: 'WorkSansSemiBold', fontSize: 17.0),
                          suffixIcon: GestureDetector(
                            onTap: _toggleLogin,
                            child: Icon(
                              _obscureTextPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              size: 20.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        onSubmitted: (_) {
                          // _toggleSignInButton();
                        },
                        textInputAction: TextInputAction.go,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                        focusNode: focusNodeConfirmPassword,
                        controller: loginPasswordController,
                        obscureText: _obscureTextConfirmPassword,
                        style: const TextStyle(
                            fontFamily: 'WorkSansSemiBold',
                            fontSize: 16.0,
                            color: Colors.black),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: const Icon(
                            Icons.lock,
                            size: 22.0,
                            color: Colors.black,
                          ),
                          hintText: 'Confirm Password',
                          hintStyle: const TextStyle(
                              fontFamily: 'WorkSansSemiBold', fontSize: 17.0),
                          suffixIcon: GestureDetector(
                            onTap: _toggleLoginConfrim,
                            child: Icon(
                              _obscureTextConfirmPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              size: 20.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        onSubmitted: (_) {
                          // _toggleSignInButton();
                        },
                        textInputAction: TextInputAction.go,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: ElevatedButton(
                      style: raisedButtonStyle,
                      onPressed: () {
                        // getLoginSession(context);
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(color: whiteColor, fontSize: 23),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: GestureDetector(
                      child: Text(
                        'Already Register ?',
                        style: TextStyle(
                          color: blackColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),*/
    );
  }

  // @override
  // void dispose() {
  //   focusNodeEmail.dispose();
  //   focusNodeFirstName.dispose();
  //   focusNodeMiddleName.dispose();
  //   focusNodeLastName.dispose();
  //   focusNodeFirstNameKn.dispose();
  //   focusNodeMiddleNameKn.dispose();
  //   focusNodeLastNameKn.dispose();
  //   focusNodeMobileNumber.dispose();
  //   focusNodePassword.dispose();
  //   focusNodeConfirmPassword.dispose();
  //   super.dispose();
  // }

  void _toggleLogin() {
    setState(() {
      _obscureTextPassword = !_obscureTextPassword;
    });
  }

  void _toggleLoginConfirm() {
    setState(() {
      _obscureTextConfirmPassword = !_obscureTextConfirmPassword;
    });
  }

  void registerCall() async {
    if (formKeyApplicantDetails.currentState!.validate()) {

      var data = {
        "first_name_eng": firstNameE.text,
        "middle_name_eng": middleNameE.text,
        "last_name_eng": lastNameE.text,
        "email_id": email_.text,
        "mobile_no": mobileNumber_.text,
        "password": password_.text,
        "state_id": "cd",
      };

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => OtpScreen( data: jsonEncode(data),)));
    }
  }
}
