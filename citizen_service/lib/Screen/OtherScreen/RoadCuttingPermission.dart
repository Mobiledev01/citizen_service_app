import 'dart:convert';
import 'dart:io';

import 'package:citizen_service/Model/DropDownModel.dart';
import 'package:citizen_service/Model/MstAddApplicationModel.dart';
import 'package:citizen_service/Model/MstAppDocumentModel.dart';
import 'package:citizen_service/Model/RoadCuttingPermissionModel/RoadCuttingApplicantDetailsModel.dart';
import 'package:citizen_service/Model/RoadCuttingPermissionModel/RoadCuttingDocumentDetailsModel.dart';
import 'package:citizen_service/Model/RoadCuttingPermissionModel/RoadCuttingModel.dart';
import 'package:citizen_service/Model/RoadCuttingPermissionModel/RoadCuttingPropertyDetailsModel.dart';
import 'package:citizen_service/Model/RoadCuttingPermissionModel/RoadCuttingWorkModel.dart';
import 'package:citizen_service/SqliteDatabase/Database.dart';
import 'package:citizen_service/Utility/Color.dart';
import 'package:citizen_service/Utility/DropDownWidget.dart';
import 'package:citizen_service/Utility/EmptyWidget.dart';
import 'package:citizen_service/Utility/GetVillageWidget.dart';
import 'package:citizen_service/Utility/String.dart';
import 'package:citizen_service/Utility/Style.dart';
import 'package:citizen_service/Utility/UploadDocumentWidget.dart';
import 'package:citizen_service/Utility/Utility.dart';
import 'package:citizen_service/Utility/Validation.dart';
import 'package:citizen_service/Utility/ViewImage.dart';
import 'package:connectivity/connectivity.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:citizen_service/GlobalsVariable/GlobalsVariable.dart'
    as globals;

class RoadCuttingPermission extends StatefulWidget {
  final String categoryId, serviceId, title, applicationId, servieName;

  const RoadCuttingPermission(
      {Key? key,
      required this.title,
      required this.categoryId,
      required this.serviceId,
      required this.applicationId,
      required this.servieName})
      : super(key: key);

  @override
  _RoadCuttingPermission createState() => _RoadCuttingPermission();
}

class _RoadCuttingPermission extends State<RoadCuttingPermission> {
  final FocusNode focusNodeMobileNo = FocusNode();
  StepperType stepperType = StepperType.horizontal;
  int _currentStep = 0;

  bool draftApplication = true;

  bool _radioValue = false;
  int val = -1, require_value = -1;

  final formKeyApplicantDetails = GlobalKey<FormState>();
  final formKeyPropertyDetails = GlobalKey<FormState>();
  final formKeyWorkDetails = GlobalKey<FormState>();
  final formKeyDoc = GlobalKey<FormState>();

  final GlobalKey expansionTileKey1 = GlobalKey();
  final GlobalKey expansionTileKey2 = GlobalKey();
  final GlobalKey expansionTileKey3 = GlobalKey();
  final GlobalKey expansionTileKey4 = GlobalKey();

  late List<bool> isChecked = [false, false, false];
  List<DropDownModal> docTypeList = [];
  List<MstAppDocumentModel> docList = [];

  final nameT = TextEditingController();
  final addressT = TextEditingController();
  final mobileNoT = TextEditingController();
  final emailIdT = TextEditingController();
  final roadCutPurT = TextEditingController();
  final significantT = TextEditingController();
  final roadLengthT = TextEditingController();
  final roadLocT = TextEditingController();
  final workDaysT = TextEditingController();
  final documentDecT = TextEditingController();

  final nameFocusNode = FocusNode();
  final addressFocusNode = FocusNode();
  final mobileNoFocusNode = FocusNode();
  final emailIdFocusNode = FocusNode();
  final roadCutPurFocusNode = FocusNode();
  final significantFocusNode = FocusNode();
  final roadLengthFocusNode = FocusNode();
  final roadLocFocusNode = FocusNode();
  final workDaysFocusNode = FocusNode();
  final documentDecFocusNode = FocusNode();

  String selectedDistId = '';
  String selectedTalukaId = '';
  String selectedPanchayatId = '';
  String selectedVillageId = '';
  String applicationId = '';
  String selected_require = '';
  String selected_conntype = '';
  String fileName = '';
  String filePath = '';
  String require_selected_label = '';
  String connType_selected_label = '';
  String docTypeSelect = '';

  String districtName = '';
  String talukaName = '';
  String panchayatName = '';
  String villageName = '';
  String docTypeSelect_label = '';

  bool isFileExits = true;
  bool isNetCon = false;
  bool isPreviewApplication = false;
  RoadCuttingModel? licenseModel;

  @override
  void initState() {
    super.initState();
    getConnectivity();
    getDropdownData();
    if (widget.applicationId.isNotEmpty && widget.applicationId != '0') {
      setState(() {
        applicationId = widget.applicationId;
      });
      fetchApplicationData(applicationId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        //trigger leaving and use own data
        if (widget.applicationId.isNotEmpty && widget.applicationId != '0') {
         Navigator.pop(context);
       } else {
         Navigator.of(context)
           ..pop()
           ..pop();
       }

        //we need to return a future
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(road_cutting_title),
          backgroundColor:
              globals.isTrainingMode ? testModePrimaryColor : primaryColor,
          actions: [
            //isNetCon
              //     ? IconButton(
              //   icon: Icon(
              //     Icons.wifi_outlined,
              //     color: greenColor,
              //     size: 20,
              //   ),
              //   onPressed: () {},
              // )
              //     : IconButton(
              //   icon: Icon(
              //     Icons.wifi_off_outlined,
              //     color: redColor,
              //     size: 20,
              //   ),
              //   onPressed: () {},
              // ),
            isPreviewApplication
                ? IconButton(
              icon: Icon(
                Icons.preview,
                color: whiteColor,
                size: 25,
              ),
              onPressed: () {
                openInstruction();
              },
            )
                : SizedBox(),
          ],
        ),
        body: Container(
          child: Column(
            children: [
              Expanded(
                  child: Theme(
                data: ThemeData(
                    colorScheme: ColorScheme.light(
                  primary: globals.isTrainingMode
                      ? testModePrimaryColor
                      : primaryColor,
                )),
                child: Stepper(
                  type: stepperType,
                  physics: BouncingScrollPhysics(),
                  steps: getSteps(),
                  currentStep: _currentStep,
                  onStepTapped: (int step) {
                    setState(() {
                      _currentStep = step;
                    });
                  },
                  onStepCancel: () {
                    if (_currentStep > 0) {
                      setState(() => _currentStep -= 1);
                    }
                  },
                  onStepContinue: () {
                    if (_currentStep <= getSteps().length - 1) {
                      if (!globals.isTrainingMode && _currentStep == 0) {
                        saveApplicantDetails();
                      } else if (!globals.isTrainingMode && _currentStep == 1) {
                        savePropertyDetails();
                      } else if (!globals.isTrainingMode && _currentStep == 2) {
                        saveWorkDetails();
                      } else if (!globals.isTrainingMode && _currentStep == 3) {
                        finalSaveApplication();
                      } else {
                        if (_currentStep < getSteps().length - 1) {
                          setState(() => _currentStep += 1);
                        } else {
                          showMessageToast(
                              'Application Draft Successfully Training Mode');
                          Navigator.pop(context);
                        }
                      }
                    }
                  },
                  controlsBuilder: (context, {onStepCancel, onStepContinue}) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        _currentStep == 0
                            ? SizedBox()
                            : ElevatedButton(
                                onPressed: onStepCancel,
                                style: previousButtonBlueStyle,
                                child: Text(previous, style: whiteNormalText14)),
                        SizedBox(
                          width: 10,
                        ),
                        getSteps().length - 1 == _currentStep
                            ? ElevatedButton(
                                onPressed: onStepContinue,
                                style: submitButtonBlueStyle,
                                child: Text(draft_or_save, style: whiteNormalText14))
                            : ElevatedButton(
                                onPressed: onStepContinue,
                                style: submitButtonBlueStyle,
                                child: Text(save_next, style: whiteNormalText14)),
                      ],
                    );
                  },
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }

  List<Step> getSteps() {
    return [
      Step(
          title: new Text('', style: formTitle),
          isActive: _currentStep >= 0,
          state: _currentStep == 0 ? StepState.editing : StepState.complete,
          content: applicantDetailsWidget()),
      Step(
        title: new Text('', style: formTitle),
        content: propertyDetailsWidget(),
        isActive: _currentStep >= 1,
        state: _currentStep == 1
            ? StepState.editing
            : _currentStep < 1
                ? StepState.disabled
                : StepState.complete,
      ),
      Step(
        title: new Text('', style: formTitle),
        content: workDetailsWidget(),
        isActive: _currentStep >= 2,
        state: _currentStep == 2
            ? StepState.editing
            : _currentStep < 2
                ? StepState.disabled
                : StepState.complete,
      ),
      Step(
        title: new Text('', style: formTitle),
        content: uploadDocumentWidget(),
        isActive: _currentStep >= 3,
        state: _currentStep == 3
            ? StepState.editing
            : _currentStep < 3
                ? StepState.disabled
                : StepState.complete,
      ),
    ];
  }

  Widget applicantDetailsWidget() {
    return Form(
      key: formKeyApplicantDetails,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color:
                  globals.isTrainingMode ? testModePrimaryColor : primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30))),
              elevation: 0,
              child: Padding(
                padding: EdgeInsets.all(7.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    getTranslated(context, 'RoadCuttingPermission',
                            'applicant_details')
                        .toUpperCase(),
                    style: whiteBoldText16,
                  ),
                ),
              ),
            ),
            EmptyWidget(),
            labelField(
              getTranslated(context, 'RoadCuttingPermission', 'applicant_name'),
            ),
            TextFormField(
              controller: nameT,
              focusNode: nameFocusNode,
              keyboardType: TextInputType.name,
              style: blackNormalText16,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                hintText: getTranslated(
                    context, 'RoadCuttingPermission', 'applicant_name'),
                isDense: true,
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (name) {
                if (name.toString().isEmpty)
                  return 'Enter applicant name';
                else if (!onlyTextWithSpace(name!))
                  return 'Please Enter Only Text with Space';
                else
                  return null;
              },
              onFieldSubmitted: (String value) {
                addressFocusNode.requestFocus();
              },
            ),
            EmptyWidget(),
            labelField(
              getTranslated(context, 'RoadCuttingPermission', 'address'),
            ),
            TextFormField(
              controller: addressT,
              focusNode: addressFocusNode,
              keyboardType: TextInputType.streetAddress,
              minLines: 3,
              maxLines: null,
              style: blackNormalText16,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                hintText:
                    getTranslated(context, 'RoadCuttingPermission', 'address'),
                isDense: true,
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (address) {
                if (address.toString().isEmpty)
                  return 'Enter Address';
                else if (!textareaWithoutSpecialCharacter(address!))
                  return 'Please Enter Valid Text';
                else
                  return null;
              },
              onFieldSubmitted: (String value) {
                mobileNoFocusNode.requestFocus();
              },
            ),
            EmptyWidget(),
            labelField(
              getTranslated(context, 'RoadCuttingPermission', 'mobile_number'),
            ),
            TextFormField(
              controller: mobileNoT,
              focusNode: mobileNoFocusNode,
              keyboardType: TextInputType.phone,
              maxLength: 10,
              style: blackNormalText16,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                hintText: getTranslated(
                    context, 'RoadCuttingPermission', 'mobile_number'),
                isDense: true,
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (mobileNo) {
                if (mobileNo.toString().isEmpty)
                  return 'Enter mobile number';
                else if (!mobile(mobileNo!))
                  return 'Please Enter Valid Mobile Number[Start With 6-9] ';
                else
                  return null;
              },
              onFieldSubmitted: (String value) {
                emailIdFocusNode.requestFocus();
              },
            ),
            EmptyWidget(),
            Text(
              getTranslated(context, 'RoadCuttingPermission', 'email_id'),
              style: formLabelStyle,
            ),
            TextFormField(
              controller: emailIdT,
              focusNode: emailIdFocusNode,
              keyboardType: TextInputType.emailAddress,
              style: blackNormalText16,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                hintText:
                    getTranslated(context, 'RoadCuttingPermission', 'email_id'),
                isDense: true,
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (emailId) {
                if (emailId.toString().isEmpty)
                  return 'Enter email Id';
                else if (!validEmail(emailId!))
                  return 'Please Enter Valid Email Id';
                else
                  return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget propertyDetailsWidget() {
    return Form(
      key: formKeyPropertyDetails,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color:
                  globals.isTrainingMode ? testModePrimaryColor : primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30))),
              elevation: 0,
              child: Padding(
                padding: EdgeInsets.all(7.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    getTranslated(context, 'RoadCuttingPermission',
                            'property_village_details')
                        .toUpperCase(),
                    style: whiteBoldText16,
                  ),
                ),
              ),
            ),
            EmptyWidget(),
            GetVillageWidget(
                selectedDistId: selectedDistId,
                selectedTalukaId: selectedTalukaId,
                selectedPanchayatId: selectedPanchayatId,
                selectedVillageId: selectedVillageId,
                selectValue: (district, taluka, panchayat, village) {
                  setState(() {
                    selectedDistId = district;
                    selectedTalukaId = taluka;
                    selectedPanchayatId = panchayat;
                    selectedVillageId = village;
                  });
                }),
            EmptyWidget(),
            Text(
              getTranslated(context, 'RoadCuttingPermission', 'require'),
              style: formLabelStyle,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ListTile(
                  title: Text("Individual", style: blackNormalText16),
                  dense: true,
                  leading: Radio(
                    value: 1,
                    groupValue: require_value,
                    onChanged: (int? value) {
                      setState(() {
                        require_value = value!;
                        selected_require = require_value.toString();
                      });
                    },
                    activeColor: secondcolor,
                  ),
                ),
                ListTile(
                  title: Text("Business", style: blackNormalText16),
                  dense: true,
                  leading: Radio(
                    value: 2,
                    groupValue: require_value,
                    onChanged: (int? value) {
                      setState(() {
                        require_value = value!;
                        selected_require = require_value.toString();
                      });
                    },
                    activeColor: secondcolor,
                  ),
                ),
                ListTile(
                  title: Text(
                    "Govt.PSU",
                    style: blackNormalText16,
                  ),
                  dense: true,
                  leading: Radio(
                    value: 3,
                    groupValue: require_value,
                    onChanged: (int? value) {
                      setState(() {
                        require_value = value!;
                        selected_require = require_value.toString();
                      });
                    },
                    activeColor: secondcolor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget workDetailsWidget() {
    return Form(
      key: formKeyWorkDetails,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color:
                  globals.isTrainingMode ? testModePrimaryColor : primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30))),
              elevation: 0,
              child: Padding(
                padding: EdgeInsets.all(7.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    getTranslated(
                            context, 'RoadCuttingPermission', 'work_details')
                        .toUpperCase(),
                    style: whiteBoldText16,
                  ),
                ),
              ),
            ),
            EmptyWidget(),
            Text(
              getTranslated(
                  context, 'RoadCuttingPermission', 'connection_type'),
              style: formLabelStyle,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(
                    "WaterLine",
                    style: blackNormalText16,
                  ),
                  dense: true,
                  leading: Radio(
                    value: 1,
                    groupValue: val,
                    onChanged: (int? value) {
                      setState(() {
                        val = value!;
                        selected_conntype = val.toString();
                      });
                    },
                    activeColor: secondcolor,
                  ),
                ),
                ListTile(
                  title: Text(
                    "Electrical",
                    style: blackNormalText16,
                  ),
                  dense: true,
                  leading: Radio(
                    value: 2,
                    groupValue: val,
                    onChanged: (int? value) {
                      setState(() {
                        val = value!;
                        selected_conntype = val.toString();
                      });
                    },
                    activeColor: secondcolor,
                  ),
                ),
                ListTile(
                  title: Text(
                    "Sanitary",
                    style: blackNormalText16,
                  ),
                  dense: true,
                  leading: Radio(
                    value: 3,
                    groupValue: val,
                    onChanged: (int? value) {
                      setState(() {
                        val = value!;
                        selected_conntype = val.toString();
                      });
                    },
                    activeColor: secondcolor,
                  ),
                ),
              ],
            ),
            EmptyWidget(),
            labelField(
              getTranslated(
                  context, 'RoadCuttingPermission', 'purpose_road_cutting'),
            ),
            TextFormField(
              controller: roadCutPurT,
              focusNode: roadCutPurFocusNode,
              keyboardType: TextInputType.text,
              style: blackNormalText16,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                hintText: getTranslated(
                    context, 'RoadCuttingPermission', 'purpose_road_cutting'),
                isDense: true,
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (roadCutting) {
                if (roadCutting.toString().isEmpty)
                  return 'Enter Road Cutting Purpose';
                else if (!onlyTextWithSpace(roadCutting!))
                  return 'Please Enter Only Text With Space';
                else
                  return null;
              },
              onFieldSubmitted: (String value) {
                significantFocusNode.requestFocus();
              },
            ),
            EmptyWidget(),
            labelField(
              getTranslated(context, 'RoadCuttingPermission', 'significant'),
            ),
            TextFormField(
              controller: significantT,
              focusNode: significantFocusNode,
              keyboardType: TextInputType.text,
              style: blackNormalText16,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                hintText: getTranslated(
                    context, 'RoadCuttingPermission', 'significant'),
                isDense: true,
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (significant) {
                if (significant.toString().isEmpty)
                  return 'Enter Significant Landmark';
                else if (!textWithOutSpace(significant!))
                  return 'Please Enter Only Text With No Space';
                else
                  return null;
              },
              onFieldSubmitted: (String value) {
                roadLengthFocusNode.requestFocus();
              },
            ),
            EmptyWidget(),
            labelField(
              getTranslated(context, 'RoadCuttingPermission', 'road_length'),

            ),
            TextFormField(
              controller: roadLengthT,
              focusNode: roadLengthFocusNode,
              keyboardType: TextInputType.number,
              style: blackNormalText16,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                hintText: getTranslated(
                    context, 'RoadCuttingPermission', 'road_length'),
                isDense: true,
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (roadLength) {
                if (roadLength.toString().isEmpty)
                  return 'Enter valid road Length ';
                else if (!onlyDigit(roadLength!))
                  return 'Please Enter Only Number';
                else
                  return null;
              },
              onFieldSubmitted: (String value) {
                roadLocFocusNode.requestFocus();
              },
            ),
            EmptyWidget(),
            labelField(
              getTranslated(context, 'RoadCuttingPermission', 'road_location'),

            ),
            TextFormField(
              controller: roadLocT,
              focusNode: roadLocFocusNode,
              keyboardType: TextInputType.text,
              style: blackNormalText16,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                hintText: getTranslated(
                    context, 'RoadCuttingPermission', 'road_location'),
                isDense: true,
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (roadLoc) {
                if (roadLoc.toString().isEmpty)
                  return 'Enter Road Location';
                else if (!onlyTextWithSpace(roadLoc!))
                  return 'Please Enter Only Text With Space';
                else
                  return null;
              },
              onFieldSubmitted: (String value) {
                workDaysFocusNode.requestFocus();
              },
            ),
            EmptyWidget(),
            labelField(
              getTranslated(context, 'RoadCuttingPermission', 'work_days'),
            ),
            TextFormField(
              controller: workDaysT,
              focusNode: workDaysFocusNode,
              keyboardType: TextInputType.number,
              style: blackNormalText16,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                hintText: getTranslated(
                    context, 'RoadCuttingPermission', 'work_days'),
                isDense: true,
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (workDays) {
                if (workDays.toString().isEmpty)
                  return 'Enter Work Days ';
                else if (!onlyDigit(workDays!))
                  return 'Please Enter Only Number';
                else
                  return null;
              },
            ),
            EmptyWidget(),
          ],
        ),
      ),
    );
  }

  Widget uploadDocumentWidget() {
    // docList.length>0
    //     ? isPreviewApplication = true
    //     : isPreviewApplication = false;
    return Form(
      key: formKeyDoc,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color:
                  globals.isTrainingMode ? testModePrimaryColor : primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30))),
              elevation: 0,
              child: Padding(
                padding: EdgeInsets.all(7.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    getTranslated(context, 'RoadCuttingPermission',
                            'upload_document_details')
                        .toUpperCase(),
                    style: whiteBoldText16,
                  ),
                ),
              ),
            ),
            EmptyWidget(),
            labelField(
              getTranslated(context, 'RoadCuttingPermission', 'doc_ty'),
            ),
            DropDownWidget(
                lable: 'Select Document Type',
                list: docTypeList,
                selValue: docTypeSelect,
                selectValue: (value) {
                  print(value);
                  setState(() {
                    docTypeSelect = value;
                  });
                }),
            EmptyWidget(),
            Text(
              getTranslated(context, 'RoadCuttingPermission', 'doc_dis'),
              style: formLabelStyle,
            ),
            TextFormField(
              controller: documentDecT,
              keyboardType: TextInputType.text,
              style: blackNormalText16,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                hintText:
                    getTranslated(context, 'RoadCuttingPermission', 'doc_dis'),
                isDense: true,
              ),
              onFieldSubmitted: (String value) {
                documentDecFocusNode.requestFocus();
              },
            ),
            UploadDocumentWidget(
                flag: 'P', // flag for type of document image or pdf (I,P,A)
                lable: fileName.isNotEmpty
                    ? fileName
                    : fineName + ' ( .jpg .png .jpeg )', // file name
                selectValue: (value, flag) {
                  // if flag return C it means XFile coming after capture image other wise it return  PlatformFile
                  if (flag == 'C') {
                    XFile file = value;
                    print(file.path + ',' + file.name);
                    setState(() {
                      fileName = file.name;
                      filePath = file.path;
                    });
                  } else {
                    PlatformFile file = value;
                    print(file.path! + ',' + file.name);
                    setState(() {
                      fileName = file.name;
                      filePath = file.path!;
                    });
                  }
                }),
            EmptyWidget(),
            /*!isFileExits
                ? Align(
                    alignment: Alignment.center,
                    child: Text(
                      'File not found !',
                      style: TextStyle(color: redColor, fontSize: 15),
                    ),
                  )
                : SizedBox(),*/
            EmptyWidget(),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                  onPressed: () {
                    insertDocument();
                  },
                  style: squareButtonBlueStyle,
                  child: Text('Add Document', style: whiteNormalText14)),
            ),
            EmptyWidget(),
            Card(
              elevation: 5,
              child: Container(
                //height: docList.length>0 ? 150 :0,
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  primary: true,
                  itemCount: docList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(child: Text(docList[index].document_type)),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ViewImage(
                                                filepath: docList[index]
                                                    .document_path,
                                                filename: docList[index]
                                                    .document_name)));
                                  },
                                  child: Icon(Icons.remove_red_eye),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    deleteDocument(
                                        docList[index].id.toString());
                                  },
                                  child: Icon(Icons.delete_forever),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            ),
            // isPreviewApplication
            //     ? Align(
            //         alignment: Alignment.center,
            //         child: ElevatedButton(
            //             onPressed: () {
            //               getAllDocument(applicationId);
            //               openInstruction();
            //             },
            //             style: previewButtonBlueStyle,
            //             child: Text(preview_application,
            //                 style: whiteNormalText14)))
            //     : SizedBox(),
            EmptyWidget(),
          ],
        ),
      ),
    );
  }

  void saveApplicantDetails() async {
    if (formKeyApplicantDetails.currentState!.validate()) {
      RoadCuttingApplicantDetailsModel applicantDetailsModel =
          new RoadCuttingApplicantDetailsModel(
              dft_dtl_road_cut_appl: '',
              appl_name: nameT.text,
              address: addressT.text,
              mob_no: mobileNoT.text,
              email_id: emailIdT.text,
              crt_date: '',
              crt_user: '',
              crt_ip: '',
              lst_upd_ip: '',
              lst_upd_date: '',
              lst_upd_user: '',
              status: 'Y');

      licenseModel = new RoadCuttingModel(
          applicantDetailsModel: applicantDetailsModel,
          propertyDetailsModel:
              licenseModel == null ? null : licenseModel!.propertyDetailsModel,
          roadCuttingWorkModel:
              licenseModel == null ? null : licenseModel!.roadCuttingWorkModel,
          roadCuttingDocumentDetailsModel: licenseModel == null
              ? null
              : licenseModel!.roadCuttingDocumentDetailsModel);

      MstAddApplicationModel mstAddApplicationModel =
          new MstAddApplicationModel(
              id: applicationId.isEmpty ? null : int.parse(applicationId),
              cATEGORYID: widget.categoryId,
              sERVICEID: widget.serviceId,
              aPPLICATIONNAME: widget.title,
              service_name: widget.servieName,
              gENERATEDAPPLICATIONID: '',
              aPPLICATIONAPPLYDATE: getCurrentDateUsingFormatter('dd/MM/yyyy'),
              aPPLICATIONDATA: jsonEncode(licenseModel),
              aPPLICATIONSYNCSTATUS: 'N',
              aPPLICATIONSYNCDATE: '',
              crt_user: '',
              crt_date: getCurrentDateUsingFormatter('dd/MM/yyyy'),
              lst_upd_user: '',
              lst_upd_date: applicationId.isNotEmpty
                  ? getCurrentDateUsingFormatter('dd/MM/yyyy')
                  : '',
              current_tab: _currentStep.toString(),
              from_web: '',
              draft_id: '',
              aPPVERSION: await getAppVersion());

      var i;

      if (applicationId.isNotEmpty && applicationId != '0') {
        i = await DatabaseOperation.instance.updateMstAddApplicationModel(
            applicationId,
            jsonEncode(licenseModel),
            getCurrentDateUsingFormatter('DD/MM/YYYY'),
            _currentStep.toString());
      } else {
        i = await DatabaseOperation.instance
            .insertMstAddApplicationModel(mstAddApplicationModel);
      }

      if (i > 0) {
        setState(() {
          applicationId = i.toString();
        });
        showMessageToast('Applicant details draft');
        if (_currentStep < getSteps().length) {
          setState(() => _currentStep += 1);
        }
      } else {
        showMessageToast('Something went wrong !');
      }
    }
  }

  Future<void> savePropertyDetails() async {
    if (formKeyPropertyDetails.currentState!.validate()) {
      if (require_value == -1) {
        showMessageToast('Please Select Required Category');
      } else {
        RoadCuttingPropertyDetailsModel licensePropertyDetailsModel =
            new RoadCuttingPropertyDetailsModel(
                dft_dtl_road_cut_prop_id: '',
                district_id: selectedDistId,
                tp_id: selectedTalukaId,
                gp_id: selectedPanchayatId,
                village_id: selectedVillageId,
                req_for: selected_require,
                crt_date: '',
                crt_user: '',
                crt_ip: '',
                lst_upd_ip: '',
                lst_upd_date: '',
                lst_upd_user: '',
                status: "Y");

        licenseModel = new RoadCuttingModel(
            applicantDetailsModel: licenseModel!.applicantDetailsModel,
            propertyDetailsModel: licensePropertyDetailsModel,
            roadCuttingWorkModel: licenseModel!.roadCuttingWorkModel,
            roadCuttingDocumentDetailsModel:
                licenseModel!.roadCuttingDocumentDetailsModel);

        var i = await DatabaseOperation.instance.updateMstAddApplicationModel(
            applicationId,
            jsonEncode(licenseModel),
            getCurrentDateUsingFormatter('DD/MM/YYYY'),
            _currentStep.toString());

        if (i > 0) {
          showMessageToast('Property/Village details draft');
          if (_currentStep < getSteps().length) {
            setState(() => _currentStep += 1);
          }
        } else {
          showMessageToast('Something went wrong !');
        }
      }
    }
  }

  Future<void> saveWorkDetails() async {
    if (formKeyWorkDetails.currentState!.validate()) {
      if (val == -1) {
        showMessageToast('Please Select Connection Type');
      } else {
        RoadCuttingWorkModel workdetailsModel = new RoadCuttingWorkModel(
            dft_dtl_road_cut_work_id: '',
            conn_type: val.toString(),
            pur_of_road_cutting: roadCutPurT.text,
            signif_landmark: significantT.text,
            approx_length_road_cutt: roadLengthT.text,
            loc_of_road: roadLocT.text,
            days_req_to_impl_work: workDaysT.text,
            crt_date: '',
            crt_user: '',
            crt_ip: '',
            lst_upd_ip: '',
            lst_upd_date: '',
            lst_upd_user: '',
            status: 'Y');

        licenseModel = new RoadCuttingModel(
            applicantDetailsModel: licenseModel!.applicantDetailsModel,
            propertyDetailsModel: licenseModel!.propertyDetailsModel,
            roadCuttingWorkModel: workdetailsModel,
            roadCuttingDocumentDetailsModel:
                licenseModel!.roadCuttingDocumentDetailsModel);

        var i = await DatabaseOperation.instance.updateMstAddApplicationModel(
            applicationId,
            jsonEncode(licenseModel),
            getCurrentDateUsingFormatter('DD/MM/YYYY'),
            _currentStep.toString());

        if (i > 0) {
          showMessageToast('Work details draft');
          if (_currentStep < getSteps().length) {
            setState(() => _currentStep += 1);
          }
        } else {
          showMessageToast('Something went wrong !');
        }
      }
    }
  }

  void saveDocumentDetails(String flag) async {
   // if (filePath.isNotEmpty) {
      RoadCuttingDocumentDetailsModel documentDetailsModel =
          new RoadCuttingDocumentDetailsModel(
              dft_dtl_road_cut_upload_id: '',
              doc_id: filePath,
              doc_desc: documentDecT.text,
              doc_name: '',
              doc_thumbnail_image: '',
              doc_type: docTypeSelect,
              folder_name: '',
              is_used: '',
              sub_folder_name: '',
              crt_date: '',
              crt_user: '',
              crt_ip: '',
              lst_upd_ip: '',
              lst_upd_date: '',
              lst_upd_user: '',
              status: 'Y');

      licenseModel = new RoadCuttingModel(
          applicantDetailsModel: licenseModel!.applicantDetailsModel,
          propertyDetailsModel: licenseModel!.propertyDetailsModel,
          roadCuttingWorkModel: licenseModel!.roadCuttingWorkModel,
          roadCuttingDocumentDetailsModel: documentDetailsModel);

      var i = await DatabaseOperation.instance.updateMstAddApplicationModel(
          applicationId,
          jsonEncode(licenseModel),
          getCurrentDateUsingFormatter('DD/MM/YYYY'),
          _currentStep.toString());
      if (i > 0) {
        if (flag == 'save') {
          var j = await DatabaseOperation.instance
              .updateFinalApplicationStatus(applicationId);
          await DatabaseOperation.instance
              .updateSyncMessageStatus(applicationId, '');
          if (j > 0) {
            showMessageToast('Application Submit Successfully');
          }
        } else {
          showMessageToast('Document details draft');
        }

        Navigator.pop(context);
      } else {
        showMessageToast('Something went wrong !');
      }
   // }
  }

  void fetchApplicationData(String applicationId) async {
    MstAddApplicationModel? model =
        await DatabaseOperation.instance.getApplicationUsingID(applicationId);

    /// print('update data:'+ model.toString());
    if (model != null && model.aPPLICATIONDATA.isNotEmpty) {
      var jsonData = jsonDecode(model.aPPLICATIONDATA);

      licenseModel = new RoadCuttingModel(
          applicantDetailsModel:
              jsonData.containsKey('1') && jsonData["1"] != null
                  ? RoadCuttingApplicantDetailsModel.fromJson(jsonData["1"])
                  : null,
          propertyDetailsModel:
              jsonData.containsKey('2') && jsonData["2"] != null
                  ? RoadCuttingPropertyDetailsModel.fromJson(jsonData["2"])
                  : null,
          roadCuttingWorkModel:
              jsonData.containsKey('3') && jsonData["3"] != null
                  ? RoadCuttingWorkModel.fromJson(jsonData["3"])
                  : null,
          roadCuttingDocumentDetailsModel:
              jsonData.containsKey('4') && jsonData["4"] != null
                  ? RoadCuttingDocumentDetailsModel.fromJson(jsonData["4"])
                  : null);

      if (licenseModel!.applicantDetailsModel != null) {
        nameT.text = licenseModel!.applicantDetailsModel!.appl_name;
        emailIdT.text = licenseModel!.applicantDetailsModel!.email_id;
        addressT.text = licenseModel!.applicantDetailsModel!.address;
        mobileNoT.text = licenseModel!.applicantDetailsModel!.mob_no;
      }

      if (licenseModel!.propertyDetailsModel != null) {
        selectedDistId = licenseModel!.propertyDetailsModel!.district_id;
        selectedTalukaId = licenseModel!.propertyDetailsModel!.tp_id;
        selectedPanchayatId = licenseModel!.propertyDetailsModel!.gp_id;
        selectedVillageId = licenseModel!.propertyDetailsModel!.village_id;
        require_value = int.parse(licenseModel!.propertyDetailsModel!.req_for);

        districtName =
            await DatabaseOperation.instance.getDistrictName(selectedDistId);
        talukaName =
            await DatabaseOperation.instance.getTalukaName(selectedTalukaId);
        panchayatName = await DatabaseOperation.instance
            .getPanchayatName(selectedPanchayatId);
        villageName =
            await DatabaseOperation.instance.getVillageName(selectedVillageId);
      }

      if (licenseModel!.roadCuttingWorkModel != null) {
        val = int.parse(licenseModel!.roadCuttingWorkModel!.conn_type);
        roadLocT.text = licenseModel!.roadCuttingWorkModel!.loc_of_road;
        roadLengthT.text =
            licenseModel!.roadCuttingWorkModel!.approx_length_road_cutt;
        significantT.text = licenseModel!.roadCuttingWorkModel!.signif_landmark;
        roadCutPurT.text =
            licenseModel!.roadCuttingWorkModel!.pur_of_road_cutting;
        workDaysT.text =
            licenseModel!.roadCuttingWorkModel!.days_req_to_impl_work;
      }

      /*if (licenseModel!.roadCuttingDocumentDetailsModel != null) {
        filePath = licenseModel!.roadCuttingDocumentDetailsModel!.doc_id;
        var fname =
            licenseModel!.roadCuttingDocumentDetailsModel!.doc_id.split("/");
        fileName = fname[fname.length - 1];

        bool fileE = await new File(filePath).exists();
        if (!fileE) {
          isFileExits = false;
        }
        docTypeSelect = licenseModel!.roadCuttingDocumentDetailsModel!.doc_type;
        documentDecT.text =
            licenseModel!.roadCuttingDocumentDetailsModel!.doc_desc;
      }*/

      if (_currentStep < getSteps().length - 1) {
        if (int.parse(model.current_tab) == getSteps().length - 1) {
          _currentStep = getSteps().length - 1;

        } else {
          _currentStep = int.parse(model.current_tab) + 1;
        }
      }

      if (_currentStep == 3) {
        isFileExits = false;
        getAllDocument(applicationId);
      }
      isPreviewApplication = true;
      setState(() {});
    }
  }

  void getConnectivity() {
    Connectivity().checkConnectivity().then((value) => {
          if (value == ConnectivityResult.mobile ||
              value == ConnectivityResult.wifi)
            {setState(() => isNetCon = true)}
          else
            {setState(() => isNetCon = false)}
        });

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      switch (result) {
        case ConnectivityResult.mobile:
          setState(() => isNetCon = true);
          break;
        case ConnectivityResult.wifi:
          setState(() => isNetCon = true);
          break;
        case ConnectivityResult.none:
        default:
          setState(() => isNetCon = false);
      }
    });
  }

  Future<void> openInstruction() async {
    List<DropDownModal> user;
    var construction;
    if (require_value == 1) {
      require_selected_label = 'Self';
    } else if (require_value == 2) {
      require_selected_label = 'Rented';
    } else if (require_value == 3) {
      require_selected_label = 'Government';
    }

    if (val == 1) {
      connType_selected_label = 'WaterLine';
    } else if (val == 2) {
      connType_selected_label = 'Electrical';
    } else if (val == 3) {
      connType_selected_label = 'Sanitary';
    }

    districtName =
        await DatabaseOperation.instance.getDistrictName(selectedDistId);
    talukaName =
        await DatabaseOperation.instance.getTalukaName(selectedTalukaId);
    panchayatName =
        await DatabaseOperation.instance.getPanchayatName(selectedPanchayatId);
    villageName =
        await DatabaseOperation.instance.getVillageName(selectedVillageId);
    docTypeSelect_label = await DatabaseOperation.instance
        .getDropdownName("getMstDocData", docTypeSelect);

    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => true,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            insetPadding: EdgeInsets.all(20),
            backgroundColor: whiteColor,
            elevation: 5,
            actions: [
              Align(
                  alignment: Alignment.topRight,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: cancelButtonBlueStyle,
                      child: Text(ok, style: whiteNormalText14))),
            ],
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  //height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            preview_application,
                            style: blackBoldText16,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Card(
                          color: primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: ExpansionTile(
                            // collapsedBackgroundColor: primaryColor,
                            // backgroundColor: primaryColor,
                            key: expansionTileKey1,

                            collapsedIconColor: whiteColor,
                            title: Text(
                              getTranslated(context, 'RoadCuttingPermission',
                                  'applicant_details'),
                              style: whiteBoldText16,
                              textAlign: TextAlign.center,
                            ),
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: previewBoxDecoration,
                                padding: previewContainerPadding,
                                //padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      getTranslated(context, 'RoadCuttingPermission', 'applicant_name'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      nameT.text,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'RoadCuttingPermission', 'address'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      addressT.text,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'RoadCuttingPermission', 'mobile_number'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      mobileNoT.text,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'RoadCuttingPermission', 'email_id'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      emailIdT.text,
                                      style: grayBoldText16,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            onExpansionChanged: (bool value) {
                              if (value) {
                                _scrollToSelectedContent(
                                    expansionTileKey: expansionTileKey1);
                              }
                            },
                          ),
                        ),
                        EmptyWidget(),
                        Card(
                          color: primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: ExpansionTile(
                            //collapsedBackgroundColor: primaryColor,
                            // backgroundColor: primaryColor,
                            key: expansionTileKey2,

                            collapsedIconColor: whiteColor,
                            title: Text(
                              getTranslated(context, 'RoadCuttingPermission',
                                  'property_village_details'),
                              style: whiteBoldText16,
                              textAlign: TextAlign.center,
                            ),
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: previewBoxDecoration,
                                padding: previewContainerPadding,
                                //padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      getTranslated(context, 'Building_License',
                                          'district'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      districtName,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'Building_License',
                                          'taluka'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      talukaName,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'Building_License',
                                          'panchayat'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      panchayatName,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'Building_License',
                                          'village'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      villageName,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'RoadCuttingPermission', 'require'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      require_selected_label,
                                      style: grayBoldText16,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            onExpansionChanged: (bool value) {
                              if (value) {
                                _scrollToSelectedContent(
                                    expansionTileKey: expansionTileKey2);
                              }
                            },
                          ),
                        ),
                        EmptyWidget(),
                        Card(
                          color: primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: ExpansionTile(
                            // collapsedBackgroundColor: primaryColor,
                            // backgroundColor: primaryColor,
                            key: expansionTileKey3,

                            collapsedIconColor: whiteColor,
                            title: Text(
                              getTranslated(
                                  context, 'RoadCuttingPermission', 'work_details'),
                              style: whiteBoldText16,
                              textAlign: TextAlign.center,
                            ),
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: previewBoxDecoration,
                                padding: previewContainerPadding,
                                //padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      getTranslated(
                                          context, 'RoadCuttingPermission', 'connection_type'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      connType_selected_label,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(
                                          context, 'RoadCuttingPermission', 'purpose_road_cutting'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      roadCutPurT.text,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'RoadCuttingPermission', 'significant'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      significantT.text,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'RoadCuttingPermission', 'road_length'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      roadLengthT.text+" KM",
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'RoadCuttingPermission', 'road_location'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      roadLocT.text,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      work_days,
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      workDaysT.text,
                                      style: grayBoldText16,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            onExpansionChanged: (bool value) {
                              if (value) {
                                _scrollToSelectedContent(
                                    expansionTileKey: expansionTileKey3);
                              }
                            },
                          ),
                        ),
                        EmptyWidget(),
                        Card(
                          color: primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: ExpansionTile(
                            key: expansionTileKey4,
                            collapsedIconColor: whiteColor,
                            title: Text(
                              getTranslated(context, 'RoadCuttingPermission',
                                  'upload_document_details'),
                              style: whiteBoldText16,
                              textAlign: TextAlign.center,
                            ),
                            children: [
                              Container(
                                  width: double.infinity,
                                  decoration: previewBoxDecoration,
                                  padding: previewContainerPadding,
                                  //padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[

                                      Card(
                                        elevation: 5,
                                        child: Container(
                                          //height: docList.length>0 ? 150 :0,
                                          child: ListView.builder(
                                              physics: BouncingScrollPhysics(),
                                              shrinkWrap: true,
                                              primary: true,
                                              itemCount: docList.length,
                                              itemBuilder: (BuildContext context, int index) {
                                                return Container(
                                                  child: Padding(
                                                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Flexible(child: Text(docList[index].document_type)),
                                                        Row(
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) => ViewImage(
                                                                            filepath: docList[index]
                                                                                .document_path,
                                                                            filename: docList[index]
                                                                                .document_name)));
                                                              },
                                                              child: Icon(Icons.remove_red_eye),
                                                            ),
                                                            // SizedBox(
                                                            //   width: 10,
                                                            // ),
                                                            // GestureDetector(
                                                            //   onTap: () {
                                                            //     deleteDocument(
                                                            //         docList[index].id.toString());
                                                            //   },
                                                            //   child: Icon(Icons.delete_forever),
                                                            // )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }),
                                        ),
                                      ),

                                    /*  Text(
                                        doc_ty,
                                        style: graypreviewText13,
                                      ),
                                      Text(
                                        docTypeSelect_label,
                                        style: grayBoldText16,
                                      ),
                                      Divider(thickness: 1),
                                      Text(
                                        doc_dis,
                                        style: graypreviewText13,
                                      ),
                                      Text(
                                        documentDecT.text,
                                        style: grayBoldText16,
                                      ),
                                      Divider(thickness: 1),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(5, 5, 5, 5),
                                          child: TextButton.icon(
                                            style: TextButton.styleFrom(
                                              backgroundColor: primaryColor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(40.0),
                                              ),
                                            ),
                                            onPressed: () {
                                              if (filePath.isNotEmpty) {
                                                Navigator.of(context).pop();
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ViewImage(
                                                                filepath:
                                                                    filePath,
                                                                filename:
                                                                    fileName)));
                                              } else {
                                                showMessageToast(
                                                    'No Image to display');
                                              }
                                            },
                                            icon: Icon(
                                              fileName.contains('pdf')
                                                  ? Icons.picture_as_pdf
                                                  : Icons.image,
                                              size: 35,
                                              color: whiteColor,
                                            ),
                                            label: Text(fileName,
                                                style: whiteBoldText14,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                        ),
                                      ),*/
                                    ],
                                  )),
                            ],
                            onExpansionChanged: (bool value) {
                              if (value) {
                                _scrollToSelectedContent(
                                    expansionTileKey: expansionTileKey4);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _scrollToSelectedContent({required GlobalKey expansionTileKey}) {
    final keyContext = expansionTileKey.currentContext;
    if (keyContext != null) {
      Future.delayed(Duration(milliseconds: 200)).then((value) {
        Scrollable.ensureVisible(keyContext,
            duration: Duration(milliseconds: 200));
      });
    }
  }

  void finalSaveApplication() {
    // set up the button
    Widget okButton = TextButton(
      child: Text('Draft Application'),
      onPressed: () {
        saveDocumentDetails('draft');
        if (widget.applicationId.isNotEmpty && widget.applicationId != '0') {
         Navigator.pop(context);
       } else {
         Navigator.of(context)
           ..pop()
           ..pop();
       }
        //Navigator.pop(context);
      },
    );

    Widget okButton2 = TextButton(
      child: Text('Save Application'),
      onPressed: () async {
        if(docList.isEmpty){
          Navigator.pop(context);
          showMessageToast('Please upload document');
        }else{
          saveDocumentDetails('save');
          if (widget.applicationId.isNotEmpty && widget.applicationId != '0') {
            Navigator.pop(context);
          } else {
            Navigator.of(context)
              ..pop()
              ..pop();
          }
          //Navigator.pop(context);
        }
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Draft/Save"),
      content: Container(
        height: 100,
        child: Column(
          children: [
            Text("Are you want to draft or save application ?"),
            Divider(
              thickness: 1,
            ),
            Text(
              "* After save application you can't update application",
              style: TextStyle(color: redColor),
            ),
          ],
        ),
      ),
      actions: [
        okButton,
        okButton2,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void getDropdownData() async {
    //  purposeList = await DatabaseOperation.instance.getDropdown("getMstPurposeData");

    docTypeList = await DatabaseOperation.instance
        .getDropdown("getMstDocData", "5", "16");
  }

  void insertDocument() async {
    if (docTypeSelect.isEmpty) {
      showMessageToast('Please select document type');
    } else if (filePath.isEmpty || fileName.isEmpty) {
      showMessageToast('Please choose file !');
    } else if (applicationId.isEmpty || applicationId == '0') {
      showMessageToast('Application id not found !');
    } else {
      MstAppDocumentModel model = new MstAppDocumentModel(
          id: null,
          document_id: docTypeSelect,
          document_type: await DatabaseOperation.instance.getDropdownNameUsingCategory(widget.categoryId, '16',
                  "getMstDocData", docTypeSelect),
          document_description: documentDecT.text,
          document_name: fileName,
          document_path: filePath,
          app_trn_id: applicationId,
          sync_status: "N");

      int i = await DatabaseOperation.instance.insertDocument(model);

      if (i > 0) {
        showMessageToast('Document inserted successfully');
        formKeyDoc.currentState!.reset();
        docTypeSelect = '';
        documentDecT.text = '';
        filePath = '';
        fileName = '';
        setState(() {});
        getAllDocument(applicationId);
      } else {
        showMessageToast('Not able to insert document');
      }
    }
  }

  void getAllDocument(String id) async {
    docList = await DatabaseOperation.instance.getAllDocument(id);

    setState(() {});
  }

  void deleteDocument(String id) {
    // set up the button
    Widget okButton = TextButton(
      child: Text('Delete'),
      onPressed: () async {
        print(id);
        int i = await DatabaseOperation.instance.deleteDocument(id);
        if (i > 0) {
          Navigator.pop(context);
          getAllDocument(applicationId);
        }
      },
    );

    Widget okButton2 = TextButton(
      child: Text('No'),
      onPressed: () async {
        Navigator.pop(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Delete Document"),
      content: Text("Are you want to delete document ?"),
      actions: [
        okButton,
        okButton2,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
