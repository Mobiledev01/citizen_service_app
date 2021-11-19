import 'dart:convert';
import 'package:citizen_service/Model/DropDownModel.dart';
import 'package:citizen_service/Model/MstAddApplicationModel.dart';
import 'package:citizen_service/Model/MstAppDocumentModel.dart';
import 'package:citizen_service/Model/NewWaterConnectionModel/NewWaterConnectionApplicantDetailsModel.dart';
import 'package:citizen_service/Model/NewWaterConnectionModel/NewWaterConnectionDocumentDetailsModel.dart';
import 'package:citizen_service/Model/NewWaterConnectionModel/NewWaterConnectionModel.dart';
import 'package:citizen_service/Model/NewWaterConnectionModel/NewWaterConnectionPropertyDetailsModel.dart';
import 'package:citizen_service/Model/NewWaterConnectionModel/NewWaterConnectionWaterConnectionModel.dart';
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
import 'package:citizen_service/GlobalsVariable/GlobalsVariable.dart' as globals;
import 'package:image_picker/image_picker.dart';

class WaterConnection extends StatefulWidget {
  final String title, categoryId, serviceId, applicationId, servieName;

  const WaterConnection(
      {Key? key,
      required this.title,
      required this.categoryId,required this.serviceId, required this.applicationId,required this.servieName})
      : super(key: key);

  @override
  _WaterConnectionState createState() => _WaterConnectionState();
}

class _WaterConnectionState extends State<WaterConnection> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.horizontal;
  bool draftApplication = false;

  final formKeyApplicantDetails = GlobalKey<FormState>();
  final formKeyPropertyDetails = GlobalKey<FormState>();
  final formKeyLicenseDetails = GlobalKey<FormState>();
  final formKeyDoc = GlobalKey<FormState>();
  final GlobalKey expansionTileKey1 = GlobalKey();
  final GlobalKey expansionTileKey2 = GlobalKey();
  final GlobalKey expansionTileKey3 = GlobalKey();
  final GlobalKey expansionTileKey4 = GlobalKey();

  final applicationNameT = TextEditingController();
  final familyIdT = TextEditingController();
  final parentNameT = TextEditingController();
  final mobileNumberT = TextEditingController();
  final address1T = TextEditingController();
  final address2T = TextEditingController();
  final pincodeT = TextEditingController();
  final familyMemberT = TextEditingController();
  final eastT = TextEditingController();
  final southT = TextEditingController();
  final westT = TextEditingController();
  final northT = TextEditingController();
  final documentDecT = TextEditingController();

  final applicationNameFocusNode = FocusNode();
  final familyIdFocusNode = FocusNode();
  final parentNameFocusNode = FocusNode();
  final mobileNumberFocusNode = FocusNode();
  final address1FocusNode = FocusNode();
  final address2FocusNode = FocusNode();
  final pincodeFocusNode = FocusNode();
  final familyMemberFocusNode = FocusNode();
  final propertyIdFocusNode = FocusNode();
  final eastFocusNode = FocusNode();
  final southFocusNode = FocusNode();
  final westFocusNode = FocusNode();
  final northFocusNode = FocusNode();
  final documentDecFocusNode = FocusNode();

  List<DropDownModal> waterTerrif = [];
  List<DropDownModal> purposeList = [];
  List<DropDownModal> properList = [];
  List<DropDownModal> docTypeList = [];
  List<MstAppDocumentModel> docList = [];

  String purposeSelect = '';
  String fileName = '';
  String filePath = '';
  String propertySelect = '';
  String waterTeriffSelect = '';
  String? docTypeSelect;
  String? selectedDistId;
  String? selectedTalukaId;
  String? selectedPanchayatId;
  String? selectedVillageId;
  String applicationId = '';
  bool isFileExits = true;
  NewWaterConnectionModel? Model;
  bool isPreviewApplication = false;
  bool isNetCon = false;

  String districtName = '';
  String talukaName = '';
  String panchayatName = '';
  String villageName = '';
  String purposeSelect_label = '';
  String waterTeriffSelectLabel = '';
  String docTypeSelect_label = '';

  @override
  void initState() {
    super.initState();

    getConnectivity();
    getDropdownData();

    properList.add(new DropDownModal(
        title: 'properList 1', titleKn: 'properList 1', id: '1'));
    properList.add(new DropDownModal(
        title: 'properList 2', titleKn: 'properList 2', id: '2'));
    properList.add(new DropDownModal(
        title: 'properList 3', titleKn: 'properList 3', id: '3'));

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
            backgroundColor:
                globals.isTrainingMode ? testModePrimaryColor : primaryColor,
            title: Text(new_water_con),
            actions: [
              // isNetCon
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
                    primary: globals.isTrainingMode ? testModePrimaryColor : primaryColor,
                  )),
                  child: Stepper(
                    type: stepperType,
                    physics: ScrollPhysics(),
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
                          saveLicenseDetails();
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
          )),
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
        content: waterConnectionDeatils(),
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
                    getTranslated(
                            context, 'WaterConnection', 'applicant_details')
                        .toUpperCase(),
                    style: whiteBoldText16,
                  ),
                ),
              ),
            ),
            EmptyWidget(),
            labelField(
              getTranslated(context, 'WaterConnection', 'applicant_name'),
            ),
            TextFormField(
              keyboardType: TextInputType.name,
              focusNode: applicationNameFocusNode,
              controller: applicationNameT,
              style: blackNormalText16,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                isDense: true,
                hintText:
                    getTranslated(context, 'WaterConnection', 'applicant_name'),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (name) {
                if (name.toString().isEmpty)
                  return 'Enter applicant name';
                else if (!simpleText(name!))
                  return 'Please Enter Only Text';
                else
                  return null;
              },
              onFieldSubmitted: (String value) {
                parentNameFocusNode.requestFocus();
              },
            ),
            EmptyWidget(),
            labelField(
              getTranslated(context, 'WaterConnection', 'parent_spouse_name'),
            ),
            TextFormField(
              controller: parentNameT,
              focusNode: parentNameFocusNode,
              keyboardType: TextInputType.name,
              style: blackNormalText16,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                isDense: true,
                hintText: getTranslated(
                    context, 'WaterConnection', 'parent_spouse_name'),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (spouseName) {
                if (spouseName.toString().isEmpty)
                  return 'Enter spouse name';
                else if (!textWithOutSpace(spouseName!))
                  return 'Please Enter Only Text With No Space';
                else
                  return null;
              },
              onFieldSubmitted: (String value) {
                mobileNumberFocusNode.requestFocus();
              },
            ),
            EmptyWidget(),
            labelField(
              getTranslated(context, 'WaterConnection', 'mobile_number'),
            ),
            TextFormField(
              controller: mobileNumberT,
              focusNode: mobileNumberFocusNode,
              keyboardType: TextInputType.phone,
              style: blackNormalText16,
              maxLength: 10,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                isDense: true,
                hintText:
                    getTranslated(context, 'WaterConnection', 'mobile_number'),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (mobileNo) {
                if (mobileNo.toString().isEmpty)
                  return 'Enter mobile number';
                else if (!mobile(mobileNo!))
                  return 'Please Enter Valid Mobile Number[Start With 6-9]';
                else
                  return null;
              },
              onFieldSubmitted: (String value) {
                familyIdFocusNode.requestFocus();
              },
            ),
            EmptyWidget(),
            labelField(
              getTranslated(context, 'WaterConnection', 'family_id'),
            ),
            TextFormField(
              controller: familyIdT,
              focusNode: familyIdFocusNode,
              keyboardType: TextInputType.number,
              style: blackNormalText16,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                isDense: true,
                hintText:
                    getTranslated(context, 'WaterConnection', 'family_id'),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (familyId) {
                if (familyId.toString().isEmpty)
                  return 'Enter valid family id ';
                else if (!onlyDigit(familyId!))
                  return 'Please Enter Only Number';
                else
                  return null;
              },
              onFieldSubmitted: (String value) {
                address1FocusNode.requestFocus();
              },
            ),
            EmptyWidget(),
            labelField(
              getTranslated(context, 'WaterConnection', 'address_line_1'),
            ),
            TextFormField(
              keyboardType: TextInputType.streetAddress,
              focusNode: address1FocusNode,
              minLines: 3,
              controller: address1T,
              maxLines: null,
              style: blackNormalText16,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                isDense: true,
                hintText:
                    getTranslated(context, 'WaterConnection', 'address_line_1'),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (address) {
                if (address.toString().isEmpty)
                  return 'Enter address line 1';
                else if (!textareaWithoutSpecialCharacter(address!))
                  return 'Please Enter Valid Text';
                else
                  return null;
              },
              onFieldSubmitted: (String value) {
                address2FocusNode.requestFocus();
              },
            ),
            EmptyWidget(),
            labelField(
              getTranslated(context, 'WaterConnection', 'address_line_2'),
            ),
            TextFormField(
              keyboardType: TextInputType.streetAddress,
              minLines: 3,
              focusNode: address2FocusNode,
              maxLines: null,
              controller: address2T,
              style: blackNormalText16,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                isDense: true,
                hintText:
                    getTranslated(context, 'WaterConnection', 'address_line_2'),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (address) {
                if (address.toString().isEmpty)
                  return 'Enter address line 2';
                else if (!textareaWithoutSpecialCharacter(address!))
                  return 'Please Enter Valid Text';
                else
                  return null;
              },
              onFieldSubmitted: (String value) {
                pincodeFocusNode.requestFocus();
              },
            ),
            EmptyWidget(),
            labelField(
              getTranslated(context, 'WaterConnection', 'pincode'),
            ),
            TextFormField(
              controller: pincodeT,
              maxLength: 6,
              focusNode: pincodeFocusNode,
              keyboardType: TextInputType.number,
              style: blackNormalText16,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                isDense: true,
                hintText: getTranslated(context, 'WaterConnection', 'pincode'),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (pincode) {
                if (pincode.toString().isEmpty)
                  return 'Enter pincode';
                else if (!isValidPincode(pincode!))
                  return 'Please Enter Valid Pincode';
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
            Card(color: globals.isTrainingMode ? testModePrimaryColor : primaryColor,
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
                    getTranslated(context, 'WaterConnection','property_village_details').toUpperCase(),
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
            labelField(
              getTranslated(context, 'WaterConnection', 'property_id'),
            ),
            DropDownWidget(
                lable: 'Select Property', // label for dropdown
                list: properList, // list for fill dropdown
                selValue: propertySelect, // selected value
                selectValue: (value) {
                  propertySelect = value;
                }),
          ],
        ),
      ),
    );
  }

  Widget waterConnectionDeatils() {
    return Form(
      key: formKeyLicenseDetails,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(color: globals.isTrainingMode ? testModePrimaryColor : primaryColor,
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
                    getTranslated(context, 'WaterConnection', 'water_conn_detail').toUpperCase(),
                    style: whiteBoldText16,
                  ),
                ),
              ),
            ),
            EmptyWidget(),
            labelField(
              getTranslated(context, 'WaterConnection', 'purpose_of_water_con'),
            ),
            DropDownWidget(
                lable: 'Select purpose',
                list: purposeList,
                selValue: purposeSelect,
                selectValue: (value) {
                  setState(() {
                    purposeSelect = value;
                  });
                }),
            EmptyWidget(),
            labelField(
              getTranslated(context, 'WaterConnection', 'no_of_family_mem'),
            ),
            TextFormField(
              controller: familyMemberT,
              keyboardType: TextInputType.phone,
              style: blackNormalText16,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                isDense: true,
                hintText: getTranslated(
                    context, 'WaterConnection', 'no_of_family_mem'),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (noOfFamilyMem) {
                if (noOfFamilyMem.toString().isEmpty)
                  return 'Enter Number of Family Member';
                else if (!onlyDigit(noOfFamilyMem!))

                  return 'Please Enter Only Number';
                else
                  return null;
              },
            ),
            EmptyWidget(),
            labelField(
              getTranslated(context, 'WaterConnection', 'water_teriff'),
            ),
            DropDownWidget(
                lable: water_teriff,
                list: waterTerrif,
                selValue: waterTeriffSelect,
                selectValue: (value) {
                  setState(() {
                    waterTeriffSelect = value;
                  });
                }),
            EmptyWidget(),
            Container(

              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey, // red as border color
                ),
              ),
              padding: EdgeInsets.fromLTRB(6, 10, 6, 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      getTranslated(context, 'WaterConnection', 'check_bandi'),
                      style: grayNormalText16,
                    ),
                  ),
                  EmptyWidget(),
                  labelField(
                    getTranslated(context, 'WaterConnection', 'east'),
                  ),
                  TextFormField(
                    controller: eastT,
                    focusNode: eastFocusNode,
                    keyboardType: TextInputType.phone,
                    style: blackNormalText16,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: blackColor)),
                      isDense: true,
                      hintText:
                          getTranslated(context, 'WaterConnection', 'east'),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (east) {
                      if (east.toString().isEmpty)
                        return 'Enter east value';
                      else if (!alphaNumeric(east!))
                        return 'Enter Only alphanumeric value';
                      else
                        return null;
                    },
                    onFieldSubmitted: (String value) {
                      southFocusNode.requestFocus();
                    },
                  ),
                  EmptyWidget(),
                  labelField(
                    getTranslated(context, 'WaterConnection', 'south'),
                  ),
                  TextFormField(
                    controller: southT,
                    focusNode: southFocusNode,
                    keyboardType: TextInputType.phone,
                    style: blackNormalText16,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: blackColor)),
                      isDense: true,
                      hintText:
                          getTranslated(context, 'WaterConnection', 'south'),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (south) {
                      if (south.toString().isEmpty)
                        return 'Enter south value';
                      else if (!alphaNumeric(south!))
                        return 'Enter Only alphanumeric value';
                      else
                        return null;
                    },
                    onFieldSubmitted: (String value) {
                      westFocusNode.requestFocus();
                    },
                  ),
                  EmptyWidget(),
                  labelField(
                    getTranslated(context, 'WaterConnection', 'west'),
                  ),
                  TextFormField(
                    controller: westT,
                    focusNode: westFocusNode,
                    keyboardType: TextInputType.phone,
                    style: blackNormalText16,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: blackColor)),
                      isDense: true,
                      hintText:
                          getTranslated(context, 'WaterConnection', 'west'),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (west) {
                      if (west.toString().isEmpty)
                        return 'Enter west value';
                      else if (!alphaNumeric(west!))
                        return 'Enter Only alphanumeric value';
                      else
                        return null;
                    },
                    onFieldSubmitted: (String value) {
                      northFocusNode.requestFocus();
                    },
                  ),
                  EmptyWidget(),
                  labelField(
                    getTranslated(context, 'WaterConnection', 'north'),
                  ),
                  TextFormField(
                    controller: northT,
                    focusNode: northFocusNode,
                    keyboardType: TextInputType.phone,
                    style: blackNormalText16,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: blackColor)),
                      isDense: true,
                      hintText:
                          getTranslated(context, 'WaterConnection', 'north'),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (north) {
                      if (north.toString().isEmpty)
                        return 'Enter north value';
                      else if (!alphaNumeric(north!))
                        return 'Enter Only alphanumeric value';
                      else
                        return null;
                    },
                  ),
                ],
              ),
            ),
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
                    getTranslated(context, 'WaterConnection',
                            'upload_document_details')
                        .toUpperCase(),
                    style: whiteBoldText16,
                  ),
                ),
              ),
            ),
            EmptyWidget(),
            labelField(
              getTranslated(context, 'WaterConnection', 'doc_ty'),
            ),
            DropDownWidget(
                lable: 'Select type',
                list: docTypeList,
                selValue: docTypeSelect,
                selectValue: (value) {
                  setState(() {
                    docTypeSelect = value;
                  });
                }),
            EmptyWidget(),
            labelField(
              getTranslated(context, 'WaterConnection', 'doc_dis'),
            ),
            TextFormField(
              controller: documentDecT,
              keyboardType: TextInputType.text,
              style: blackNormalText16,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                isDense: true,
                hintText: getTranslated(context, 'WaterConnection', 'doc_dis'),
              ),
              // autovalidateMode: AutovalidateMode.onUserInteraction,
              // validator: (value) {
              //   if (value.toString().isEmpty)
              //     return 'Enter Document Description';
              //   else if (!onlyTextWithSpace(value!))
              //     return 'Please Enter Only Text';
              //   else
              //     return null;
              // },
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
           /* !isFileExits
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
      NewWaterConnectionApplicantDetailsModel model =
          new NewWaterConnectionApplicantDetailsModel(
        '',
        applicationNameT.text,
        familyIdT.text,
        parentNameT.text,
        address1T.text,
        address2T.text,
        mobileNumberT.text,
        pincodeT.text,
        "",
        "",
        "",
        "",
        "",
        "",
        "Y",
      );
      Model = new NewWaterConnectionModel(
          applicantDetailsModel: model,
          propertyDetailsModel: Model?.propertyDetailsModel ?? null,
          waterConnectionModel: Model?.waterConnectionModel ?? null,
          waterConnDocumentModel: Model?.waterConnDocumentModel ?? null);

      MstAddApplicationModel mstAddApplicationModel =
          new MstAddApplicationModel(
              gENERATEDAPPLICATIONID: '',
              aPPLICATIONDATA: json.encode(Model),
              current_tab: _currentStep.toString(),
              crt_date: getCurrentDateUsingFormatter(dateFormate_dd_MM_yyyy),
              lst_upd_user: '',
              lst_upd_date: applicationId.isNotEmpty
                  ? getCurrentDateUsingFormatter(dateFormate_dd_MM_yyyy)
                  : '',
              aPPVERSION: await getAppVersion(),
              aPPLICATIONSYNCSTATUS: 'N',
              crt_user: '',
              cATEGORYID: widget.categoryId,
              aPPLICATIONAPPLYDATE:
                  getCurrentDateUsingFormatter(dateFormate_dd_MM_yyyy),
              sERVICEID: widget.serviceId,
              id: applicationId.isEmpty ? null : int.parse(applicationId),
              aPPLICATIONNAME: widget.title,
              service_name: widget.servieName,
              from_web: '',
              draft_id: '',
              aPPLICATIONSYNCDATE: '');

      var i;
      if (applicationId.isNotEmpty && applicationId != '0') {
        i = await DatabaseOperation.instance.updateMstAddApplicationModel(
            applicationId,
            jsonEncode(Model),
            getCurrentDateUsingFormatter(dateFormate_dd_MM_yyyy),
            _currentStep.toString());
      } else {
        i = await DatabaseOperation.instance
            .insertMstAddApplicationModel(mstAddApplicationModel);
      }

      if (i > 0) {
        setState(() {
          applicationId = applicationId.isEmpty ? i.toString() : applicationId;
        });
        showMessageToast('Applicant details draft');
      } else {
        showMessageToast('Something went wrong !');
      }
      if (_currentStep < getSteps().length) {
        setState(() => _currentStep += 1);
      }
    }
  }

  void savePropertyDetails() async {
    // var jsonData = {
    //   'selectedDistId': selectedDistId,
    //   'selectedTalukaId': selectedTalukaId,
    //   'selectedPanchayatId': selectedPanchayatId,
    //   'selectedVillageId': selectedVillageId,
    //   'propertySelect': propertySelect,
    //   'propertyIdT': propertyIdT,
    // };

    if (formKeyPropertyDetails.currentState!.validate()) {
      NewWaterConnectionPropertyDetailsModel model =
          new NewWaterConnectionPropertyDetailsModel(
              '',
              selectedDistId!,
              selectedTalukaId!,
              selectedPanchayatId!,
              selectedVillageId!,
              propertySelect,
              '',
              '',
              '',
              '',
              '',
              '',
              '');
      Model = new NewWaterConnectionModel(
          waterConnDocumentModel: Model?.waterConnDocumentModel ?? null,
          applicantDetailsModel: Model?.applicantDetailsModel ?? null,
          waterConnectionModel: Model?.waterConnectionModel ?? null,
          propertyDetailsModel: model);

      var i = await DatabaseOperation.instance.updateMstAddApplicationModel(
          applicationId,
          jsonEncode(Model),
          getCurrentDateUsingFormatter(dateFormate_dd_MM_yyyy),
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

  void saveLicenseDetails() async {
    // var jsonData = {
    //   'purposeSelect': purposeSelect,
    //   'waterTeriffSelect': waterTeriffSelect,
    //   'familyMemberT': familyMemberT.text,
    //   'eastT': eastT.text,
    //   'southT': southT.text,
    //   'westT': westT.text,
    //   'northT': northT.text,
    // };

    if (formKeyLicenseDetails.currentState!.validate()) {
      NewWaterConnectionWaterConnectionModel model =
          new NewWaterConnectionWaterConnectionModel(
              '',
              purposeSelect,
              waterTeriffSelect,
              familyMemberT.text,
              eastT.text,
              southT.text,
              westT.text,
              northT.text,
              '',
              '',
              '',
              '',
              '',
              '',
              '');
      Model = new NewWaterConnectionModel(
          waterConnDocumentModel: Model?.waterConnDocumentModel ?? null,
          applicantDetailsModel: Model?.applicantDetailsModel ?? null,
          waterConnectionModel: model,
          propertyDetailsModel: Model?.propertyDetailsModel ?? null);

      var i = await DatabaseOperation.instance.updateMstAddApplicationModel(
          applicationId,
          jsonEncode(Model),
          getCurrentDateUsingFormatter(dateFormate_dd_MM_yyyy),
          _currentStep.toString());
      if (i > 0) {
        showMessageToast('WaterConnection details draft');
        if (_currentStep < getSteps().length) {
          setState(() => _currentStep += 1);
        }
      } else {
        showMessageToast('Something went wrong !');
      }
    }
  }

  void saveDocumentDetails(String flag) async {
    //if (filePath.isNotEmpty) {
      NewWaterConnectionDocumentDetailsModel model =
          new NewWaterConnectionDocumentDetailsModel('', '', filePath,
              docTypeSelect!, documentDecT.text, '', '', '', '', '', '', '');
      Model = new NewWaterConnectionModel(
          waterConnDocumentModel: model,
          applicantDetailsModel: Model?.applicantDetailsModel ?? null,
          waterConnectionModel: Model?.waterConnectionModel ?? null,
          propertyDetailsModel: Model?.propertyDetailsModel ?? null);

      var i = await DatabaseOperation.instance.updateMstAddApplicationModel(
          applicationId,
          jsonEncode(Model),
          getCurrentDateUsingFormatter(dateFormate_dd_MM_yyyy),
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
    if (model != null && model.aPPLICATIONDATA.isNotEmpty) {
      var jsonData = jsonDecode(model.aPPLICATIONDATA);

      Model = new NewWaterConnectionModel(
        applicantDetailsModel: jsonData.containsKey('1') &&
                jsonData["1"] != null
            ? NewWaterConnectionApplicantDetailsModel.fromJson(jsonData["1"])
            : null,
        propertyDetailsModel: jsonData.containsKey('2') && jsonData["2"] != null
            ? NewWaterConnectionPropertyDetailsModel.fromJson(jsonData["2"])
            : null,
        waterConnectionModel: jsonData.containsKey('3') && jsonData["3"] != null
            ? NewWaterConnectionWaterConnectionModel.fromJson(jsonData["3"])
            : null,
        waterConnDocumentModel:
            jsonData.containsKey('4') && jsonData["4"] != null
                ? NewWaterConnectionDocumentDetailsModel.fromJson(jsonData["4"])
                : null,
      );

      if (Model!.applicantDetailsModel != null) {
        applicationNameT.text = Model!.applicantDetailsModel!.appl_name;
        familyIdT.text = Model!.applicantDetailsModel!.family_id;
        pincodeT.text = Model!.applicantDetailsModel!.pin_code;
        parentNameT.text = Model!.applicantDetailsModel!.parent_spouse_name;
        address1T.text = Model!.applicantDetailsModel!.add_line_1;
        address2T.text = Model!.applicantDetailsModel!.add_line_2;
        mobileNumberT.text = Model!.applicantDetailsModel!.mob_no;
      }
      if (Model!.propertyDetailsModel != null) {
        selectedDistId = Model!.propertyDetailsModel!.district_id;
        selectedTalukaId = Model!.propertyDetailsModel!.tp_id;
        selectedPanchayatId = Model!.propertyDetailsModel!.gp_id;
        selectedVillageId = Model!.propertyDetailsModel!.village_id;
        print(selectedTalukaId);
        print(Model!.propertyDetailsModel!.property_id);

        // propertySelect = Model!.propertyDetailsModel!.property_id != null ? Model!.propertyDetailsModel!.property_id : '';

        districtName = await DatabaseOperation.instance
            .getDistrictName(Model!.propertyDetailsModel!.district_id);
        talukaName = await DatabaseOperation.instance
            .getTalukaName(Model!.propertyDetailsModel!.tp_id);
        panchayatName = await DatabaseOperation.instance
            .getPanchayatName(Model!.propertyDetailsModel!.gp_id);
        villageName = await DatabaseOperation.instance
            .getVillageName(Model!.propertyDetailsModel!.village_id);
      }

      if (Model!.waterConnectionModel != null) {
        purposeSelect = Model!.waterConnectionModel!.ppsd_of_water_conn;
        waterTeriffSelect = Model!.waterConnectionModel!.water_teriff;
        familyMemberT.text = Model!.waterConnectionModel!.no_of_family_mem;
        eastT.text = Model!.waterConnectionModel!.east;
        southT.text = Model!.waterConnectionModel!.south;
        westT.text = Model!.waterConnectionModel!.west;
        northT.text = Model!.waterConnectionModel!.north;
      }
     /* if (Model!.waterConnDocumentModel != null) {
        filePath = Model!.waterConnDocumentModel!.doc_id;
        var fname = Model!.waterConnDocumentModel!.doc_id.split("/");
        fileName = fname[fname.length - 1];
        documentDecT.text = Model!.waterConnDocumentModel!.doc_description;
        docTypeSelect = Model!.waterConnDocumentModel!.doc_type_id;
        bool fileE = await new File(filePath).exists();
        if (!fileE) {
          isFileExits = false;
        }
      }*/

      if (_currentStep <= getSteps().length - 1) {
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

  Future<void> openInstruction() async {
    districtName =
        await DatabaseOperation.instance.getDistrictName(selectedDistId ?? '');
    talukaName =
        await DatabaseOperation.instance.getTalukaName(selectedTalukaId ?? '');
    panchayatName =
        await DatabaseOperation.instance.getPanchayatName(selectedPanchayatId ?? '');
    villageName =
        await DatabaseOperation.instance.getVillageName(selectedVillageId ?? '');

    purposeSelect_label = await DatabaseOperation.instance
        .getDropdownName("getMstPurNewWaterConn", purposeSelect);
    waterTeriffSelectLabel = await DatabaseOperation.instance
        .getDropdownName("getMstWaterTariffData", waterTeriffSelect);
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
                              getTranslated(context, 'WaterConnection', 'applicant_details'),
                              style: whiteBoldText16,
                              textAlign: TextAlign.start,
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
                                      getTranslated(context, 'WaterConnection', 'applicant_name'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      applicationNameT.text,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'WaterConnection', 'parent_spouse_name'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      parentNameT.text,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'WaterConnection', 'mobile_number'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      mobileNumberT.text,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'WaterConnection', 'family_id'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      familyIdT.text,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'WaterConnection', 'address_line_1'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      address1T.text,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'WaterConnection', 'address_line_2'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      address2T.text,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'WaterConnection', 'pincode'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      pincodeT.text,
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
                              getTranslated(context, 'WaterConnection',
                                  'property_village_details'),
                              style: whiteBoldText16,
                              textAlign: TextAlign.start,
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
                                      getTranslated(context, 'Building_License', 'district'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      districtName,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'Building_License', 'taluka'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      talukaName,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'Building_License', 'panchayat'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      panchayatName,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'Building_License', 'village'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      villageName,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'WaterConnection', 'property_id'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      propertySelect,
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
                              getTranslated(context, 'WaterConnection', 'water_conn_detail'),
                              style: whiteBoldText16,
                              textAlign: TextAlign.start,
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
                                      getTranslated(context, 'WaterConnection', 'purpose_of_water_con'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      purposeSelect_label,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'WaterConnection', 'no_of_family_mem'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      familyMemberT.text,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'WaterConnection', 'water_teriff'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      waterTeriffSelectLabel,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text( getTranslated(context, 'WaterConnection', 'east'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      eastT.text,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(getTranslated(context, 'WaterConnection', 'south'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      southT.text,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'WaterConnection', 'west'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      westT.text,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'WaterConnection', 'north'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      northT.text,
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
                              getTranslated(
                                  context, 'WaterConnection', 'upload_document_details'),
                              style: whiteBoldText16,
                              textAlign: TextAlign.start,
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

                                    Card(
                                      elevation: 5,
                                      child: Container(
                                        //height: docList.length>0 ? 150 :0,
                                        child: ListView.builder(
                                            physics: BouncingScrollPhysics(),
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
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

                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }),
                                      ),
                                    ),

                                    /* Text(
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
                                    ),*/
                                  ],
                                ),
                              ),
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
        // Navigator.pop(context);
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
          // Navigator.pop(context);
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

  void getDropdownData() async {
    waterTerrif = await DatabaseOperation.instance
        .getDropdown("getMstWaterTariffData", "2", "3");
    purposeList = await DatabaseOperation.instance
        .getDropdown("getMstPurNewWaterConn", "2", "3");
    docTypeList =
        await DatabaseOperation.instance.getDropdown("getMstDocData", "2", "3");
  }

  void insertDocument() async {
    if (docTypeSelect!.isEmpty) {
      showMessageToast('Please select document type');
    } else if (filePath.isEmpty || fileName.isEmpty) {
      showMessageToast('Please choose file !');
    } else if (applicationId.isEmpty || applicationId == '0') {
      showMessageToast('Application id not found !');
    } else {
      MstAppDocumentModel model = new MstAppDocumentModel(
          id: null,
          document_id: docTypeSelect!,
          document_type: await DatabaseOperation.instance
              .getDropdownNameUsingCategory(widget.categoryId, widget.serviceId,
                  "getMstDocData", docTypeSelect!),
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
