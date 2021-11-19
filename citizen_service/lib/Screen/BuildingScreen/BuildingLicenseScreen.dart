import 'dart:convert';
import 'package:citizen_service/Model/BuildingLicenseModel/BuildingLicenseApplicantDetailsModel.dart';
import 'package:citizen_service/Model/BuildingLicenseModel/BuildingLicenseBuildingDetailsModel.dart';
import 'package:citizen_service/Model/BuildingLicenseModel/BuildingLicenseDocumentDetailsModel.dart';
import 'package:citizen_service/Model/BuildingLicenseModel/BuildingLicenseModel.dart';
import 'package:citizen_service/Model/BuildingLicenseModel/BuildingLicensePropertyDetailsModel.dart';
import 'package:citizen_service/Model/DropDownModel.dart';
import 'package:citizen_service/Model/MstAddApplicationModel.dart';
import 'package:citizen_service/Model/MstAppDocumentModel.dart';
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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:citizen_service/GlobalsVariable/GlobalsVariable.dart' as globals;

class BuildingLicenseScreen extends StatefulWidget {
  final String categoryId, serviceId, title, applicationId, servieName;

  const BuildingLicenseScreen(
      {Key? key, required this.title, required this.categoryId, required this.serviceId, required this.applicationId, required this.servieName})
      : super(key: key);

  @override
  _BusinessScreenState createState() => _BusinessScreenState();
}

class _BusinessScreenState extends State<BuildingLicenseScreen> with TickerProviderStateMixin{

  int _currentStep = 0;
  StepperType stepperType = StepperType.horizontal;

  final formKeyApplicantDetails = GlobalKey<FormState>();
  final formKeyPropertyDetails = GlobalKey<FormState>();
  final formKeyLicenseDetails = GlobalKey<FormState>();
  final formKeyDocDetails = GlobalKey<FormState>();

  final GlobalKey expansionTileKey1 = GlobalKey();
  final GlobalKey expansionTileKey2 = GlobalKey();
  final GlobalKey expansionTileKey3 = GlobalKey();
  final GlobalKey expansionTileKey4 = GlobalKey();

  String directionSelect = '';
  String constrTypeSelect = '';
  String constructionSelect = '';
  String fileName = '';
  String filePath = '';
  String propertyTypeListSelect = '';
  String purposeSelect = '';
  String purposeSelectlabel = '';
  String selected_buildingconType = '';
  String directionSelectLabel = '';
  String docTypeSelect_label = '';
  String buildingConstructionSelect = '';
  String docTypeSelect = '';
  String selectedDistId = '';
  String selectedTalukaId = '';
  String selectedPanchayatId = '';
  String selectedVillageId = '';
  String propertyIdSelect = '';
  String applicationId = '';

  String districtName = '';
  String talukaName = '';
  String panchayatName = '';
  String villageName = '';

  final applicationNameT = TextEditingController();
  final familyIdT = TextEditingController();
  final parentNameT = TextEditingController();
  final mobileNumberT = TextEditingController();
  final address1T = TextEditingController();
  final address2T = TextEditingController();
  final pincodeT = TextEditingController();
  final searchPropertyIdT = TextEditingController();
  final estimationBuildingT = TextEditingController();
  final plinthT = TextEditingController();
  final totalAreaT = TextEditingController();
  final builtUpT = TextEditingController();
  final eastWestT = TextEditingController();
  final northSouthT = TextEditingController();
  final eastT = TextEditingController();
  final southT = TextEditingController();
  final westT = TextEditingController();
  final northT = TextEditingController();
  final noOfRoomsT = TextEditingController();
  final noOfFloorsT = TextEditingController();
  final professionalEngineerT = TextEditingController();
  final supervisingEngineerT = TextEditingController();
  final documentDecT = TextEditingController();

  final applicantNameFocusNode = FocusNode();
  final familyIdFocusNode = FocusNode();
  final parentNameFocusNode = FocusNode();
  final mobileNumberFocusNode = FocusNode();
  final address1FocusNode = FocusNode();
  final address2FocusNode = FocusNode();
  final pincodeFocusNode = FocusNode();
  final searchPropertyIdFocusNode = FocusNode();
  final estimationBuildingFocusNode = FocusNode();
  final plinthFocusNode = FocusNode();
  final totalAreaFocusNode = FocusNode();
  final builtUpFocusNode = FocusNode();
  final eastWestFocusNode = FocusNode();
  final northSouthFocusNode = FocusNode();
  final eastFocusNode = FocusNode();
  final southFocusNode = FocusNode();
  final westFocusNode = FocusNode();
  final northFocusNode = FocusNode();
  final noOfRoomsFocusNode = FocusNode();
  final noOfFloorsFocusNode = FocusNode();
  final professionalEngineerFocusNode = FocusNode();
  final supervisingEngineerFocusNode = FocusNode();
  final documentDecFocusNode = FocusNode();

  List<DropDownModal> purposeList = [];

  List<DropDownModal> properTypeList = [
    DropDownModal(id: '1', title: 'Dist1', titleKn: '1'),
    DropDownModal(id: '2', title: 'Dist2', titleKn: '2'),
    DropDownModal(id: '3', title: 'Dist3', titleKn: '3'),
    DropDownModal(id: '4', title: 'Dist4', titleKn: '4'),
    DropDownModal(id: '5', title: 'Dist5', titleKn: '5')
  ];

  List<DropDownModal> buildingConstructionList = [];

  List<DropDownModal> docTypeList = [];
  List<MstAppDocumentModel> docList = [];

  late List<bool> isChecked = [false, false, false];

  List<DropDownModal> property_id_list = [
    DropDownModal(id: '1', title: 'Dist1', titleKn: '1'),
    DropDownModal(id: '2', title: 'Dist2', titleKn: '2'),
    DropDownModal(id: '3', title: 'Dist3', titleKn: '3'),
    DropDownModal(id: '4', title: 'Dist4', titleKn: '4'),
    DropDownModal(id: '5', title: 'Dist5', titleKn: '5')
  ];

  List<DropDownModal> directionList = [];

  var toilet_f_radio, solar_f_radio, rain_f_radio, constructionType;

  bool isFileExits = true;
  bool isNetCon = false;
  bool isPreviewApplication = false;
  BuildingLicenseModel? licenseModel;

  @override
  void initState() {
    // TODO: implement initState
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
            title: Text(widget.servieName),
            backgroundColor:
            globals.isTrainingMode ? testModePrimaryColor : primaryColor,
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
                                  child:
                                  Text(previous, style: whiteNormalText14)),
                              SizedBox(
                                width: 10,
                              ),
                              getSteps().length - 1 == _currentStep
                                  ? ElevatedButton(
                                  onPressed: onStepContinue,
                                  style: submitButtonBlueStyle,
                                  child: Text(draft_or_save,
                                      style: whiteNormalText14))
                                  : ElevatedButton(
                                  onPressed: onStepContinue,
                                  style: submitButtonBlueStyle,
                                  child:
                                  Text(save_next, style: whiteNormalText14)),
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
        content: buildingDetailsWidget(),
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
                    applicant_details.toUpperCase(),
                    style: whiteBoldText16,
                  ),
                ),
              ),
            ),
            EmptyWidget(),
            Text(
              getTranslated(context, 'Building_License', 'applicant_name'),
              style: formLabelStyle,
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: applicationNameT,
              focusNode: applicantNameFocusNode,
              style: blackNormalText16,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                isDense: true,
                hintText: applicant_name,
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
            Text(
              getTranslated(
                  context, 'Building_License', 'parent_spouse_name'),
              style: formLabelStyle,
            ),
            TextFormField(
              controller: parentNameT,
              focusNode: parentNameFocusNode,
              keyboardType: TextInputType.text,
              style: blackNormalText16,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                isDense: true,
                hintText: parent_spouse_name,
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
            Text(
              getTranslated(context, 'Building_License', 'mobile_number'),
              style: formLabelStyle,
            ),
            TextFormField(
              controller: mobileNumberT,
              focusNode: mobileNumberFocusNode,
              maxLength: 10,
              keyboardType: TextInputType.phone,
              style: blackNormalText16,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                isDense: true,
                hintText: mobile_number,
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
            Text(
              getTranslated(context, 'Building_License', 'family_id'),
              style: formLabelStyle,
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
                hintText: family_id,
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
            Text(
              getTranslated(context, 'Building_License', 'address_line_1'),
              style: formLabelStyle,
            ),
            TextFormField(
              keyboardType: TextInputType.streetAddress,
              minLines: 3,
              controller: address1T,
              focusNode: address1FocusNode,
              maxLines: null,
              style: blackNormalText16,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                isDense: true,
                hintText: address_line_1,
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
            Text(
              getTranslated(context, 'Building_License', 'address_line_2'),
              style: formLabelStyle,
            ),
            TextFormField(
              keyboardType: TextInputType.streetAddress,
              minLines: 3,
              controller: address2T,
              focusNode: address2FocusNode,
              maxLines: null,
              style: blackNormalText16,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                isDense: true,
                hintText: address_line_2,
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
            Text(
              getTranslated(context, 'Building_License', 'pincode'),
              style: formLabelStyle,
            ),
            TextFormField(
              controller: pincodeT,
              focusNode: pincodeFocusNode,
              keyboardType: TextInputType.number,
              style: blackNormalText16,
              maxLength: 6,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                isDense: true,
                hintText: pincode,
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
                    property_village_details.toUpperCase(),
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
            // Text(
            //   getTranslated(
            //       context, 'Building_License', 'search_property_id_drop'),
            //   style: formLabelStyle,
            // ),
            // TextFormField(
            //   keyboardType: TextInputType.name,
            //   style: blackNormalText16,
            //   controller: searchPropertyIdT,
            //   decoration: InputDecoration(
            //     enabledBorder: UnderlineInputBorder(
            //         borderSide: BorderSide(color: blackColor)),
            //     isDense: true,
            //     hintText: search_property_id_drop,
            //   ),
            //   onFieldSubmitted: (String value) {
            //     searchPropertyIdFocusNode.requestFocus();
            //   },
            // ),
            EmptyWidget(),
            Text(
              getTranslated(context, 'Building_License', 'property_id'),
              style: formLabelStyle,
            ),
            DropDownWidget(
                lable: 'Select Property Id',
                // label for dropdown
                list: property_id_list, // list for fill dropdown
                selValue: propertyIdSelect, // selected value
                selectValue: (value) {
                  // function return value after dropdown selection changed
                  setState(() {
                    propertyIdSelect = value;
                  });
                }),
          ],
        ),
      ),
    );
  }

  Widget buildingDetailsWidget() {

    return Form(
      key: formKeyLicenseDetails,
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
                    building_details_lbl.toUpperCase(),
                    style: whiteBoldText16,
                  ),
                ),
              ),
            ),
            Text(
              getTranslated(
                  context, 'Building_License', 'building_construction'),
              style: formLabelStyle,
            ),
            EmptyWidget(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Radio(
                  value: 11,
                  groupValue: constructionType,
                  onChanged: (index0) {
                    setState(() {
                      constructionType = index0;
                      print(constructionType);
                    });
                  },
                  activeColor: Colors.green,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                  child: Text(Addition_, style: blackNormalText14),
                ),
                Radio(
                  value: 12,
                  groupValue: constructionType,
                  onChanged: (index10) {
                    setState(() {
                      constructionType = index10;
                      print(constructionType);
                    });
                  },
                  activeColor: Colors.green,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                  child: Text(Alteration_, style: blackNormalText14),
                ),
                Radio(
                  value: 13,
                  groupValue: constructionType,
                  onChanged: (index00) {
                    setState(() {
                      constructionType = index00;
                      print(constructionType);
                    });
                  },
                  activeColor: Colors.green,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                  child: Text(New_, style: blackNormalText14),
                ),
              ],
            ),
            EmptyWidget(),
            Text(
              getTranslated(context, 'Building_License', 'purpose'),
              style: formLabelStyle,
            ),
            DropDownWidget(
                lable: 'Select  Purpose',
                list: purposeList,
                selValue: purposeSelect,
                selectValue: (value) {
                  setState(() {
                    purposeSelect = value;
                  });
                }),
            EmptyWidget(),
            Text(
              getTranslated(context, 'Building_License', 'property_type'),
              style: formLabelStyle,
            ),
            DropDownWidget(
                lable: 'Select Property Type ',
                list: properTypeList,
                selValue: propertyTypeListSelect,
                selectValue: (value) {
                  setState(() {
                    propertyTypeListSelect = value;
                  });
                }),
            EmptyWidget(),
            Text(
              getTranslated(
                  context, 'Building_License', 'estimation_of_building'),
              style: formLabelStyle,
            ),
            TextFormField(
              controller: estimationBuildingT,
              keyboardType: TextInputType.phone,
              style: blackNormalText16,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                isDense: true,
                hintText: estimationof_building,
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value.toString().isEmpty)
                  return 'Enter building area';
                else if (!onlyNumberWithPoint(value!))
                  return 'Please Enter Only Number';
                else
                  return null;
              },
            ),
            EmptyWidget(),
            Text(
              getTranslated(
                  context, 'Building_License', 'building_construction'),
              style: formLabelStyle,
            ),
            DropDownWidget(
                lable: 'Select Building Construction ',
                list: buildingConstructionList,
                selValue: buildingConstructionSelect,
                selectValue: (value) {
                  setState(() {
                    buildingConstructionSelect = value;
                  });
                }),
            EmptyWidget(),
            Text(
              getTranslated(context, 'Building_License', 'proposed_plinth'),
              style: formLabelStyle,
            ),
            TextFormField(
              controller: plinthT,
              keyboardType: TextInputType.phone,
              style: blackNormalText16,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                isDense: true,
                hintText: proposed_plinth,
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value.toString().isEmpty)
                  return 'Enter plinth area';
                else if (!onlyNumberWithPoint(value!))
                  return 'Please Enter Only Number';
                else
                  return null;
              },
            ),
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
                      area_measurements,
                      style: grayNormalText16,
                    ),
                  ),
                  EmptyWidget(),
                  Text(
                    getTranslated(context, 'Building_License', 'total_area'),
                    style: formLabelStyle,
                  ),
                  TextFormField(
                    controller: totalAreaT,
                    focusNode: totalAreaFocusNode,
                    keyboardType: TextInputType.phone,
                    style: blackNormalText16,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: blackColor)),
                      isDense: true,
                      hintText: total_area,
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (totalArea) {
                      if (totalArea.toString().isEmpty)
                        return 'Enter total area';
                      else if (!onlyNumberWithPoint(totalArea!))
                        return 'Please Enter Only Number';
                      else
                        return null;
                    },
                    onFieldSubmitted: (String value) {
                      builtUpFocusNode.requestFocus();
                    },
                  ),
                  EmptyWidget(),
                  Text(
                    getTranslated(
                        context, 'Building_License', 'built_up_area'),
                    style: formLabelStyle,
                  ),
                  TextFormField(
                    controller: builtUpT,
                    focusNode: builtUpFocusNode,
                    keyboardType: TextInputType.phone,
                    style: blackNormalText16,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: blackColor)),
                      isDense: true,
                      hintText: built_up_area,
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (builtUpArea) {
                      if (builtUpArea.toString().isEmpty)
                        return 'Enter built up area';
                      else if (!onlyNumberWithPoint(builtUpArea!))
                        return 'Please Enter Only Number';
                      else
                        return null;
                    },
                    onFieldSubmitted: (String value) {
                      eastWestFocusNode.requestFocus();
                    },
                  ),
                  EmptyWidget(),
                  Text(
                    getTranslated(context, 'Building_License', 'east_west'),
                    style: formLabelStyle,
                  ),
                  TextFormField(
                    controller: eastWestT,
                    focusNode: eastWestFocusNode,
                    keyboardType: TextInputType.phone,
                    style: blackNormalText16,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: blackColor)),
                      isDense: true,
                      hintText: east_west,
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (eastWest) {
                      if (eastWest.toString().isEmpty)
                        return 'Enter east - west area';
                      else if (!simpleText(eastWest!))
                        return 'Please Enter Only Text With No Space';
                      else
                        return null;
                    },
                    onFieldSubmitted: (String value) {
                      northSouthFocusNode.requestFocus();
                    },
                  ),
                  EmptyWidget(),
                  Text(
                    getTranslated(context, 'Building_License', 'north_south'),
                    style: formLabelStyle,
                  ),
                  TextFormField(
                    controller: northSouthT,
                    focusNode: northSouthFocusNode,
                    keyboardType: TextInputType.phone,
                    style: blackNormalText16,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: blackColor)),
                      isDense: true,
                      hintText: north_south,
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (northSouth) {
                      if (northSouth.toString().isEmpty)
                        return 'Enter north - south area';
                      else if (!simpleText(northSouth!))
                        return 'Please Enter Only Text With No Space';
                      else
                        return null;
                    },
                    onFieldSubmitted: (String value) {
                      eastFocusNode.requestFocus();
                    },
                  )
                ],
              ),
            ),
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
                      check_bandi,
                      style: grayNormalText16,
                    ),
                  ),
                  EmptyWidget(),
                  Text(
                    getTranslated(context, 'Building_License', 'east'),
                    style: formLabelStyle,
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
                      hintText: east,
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (east) {
                      if (east.toString().isEmpty)
                        return 'Enter east area';
                      else if (!simpleText(east!))
                        return 'Please Enter Only Text With No Space';
                      else
                        return null;
                    },
                    onFieldSubmitted: (String value) {
                      southFocusNode.requestFocus();
                    },
                  ),
                  EmptyWidget(),
                  Text(
                    getTranslated(context, 'Building_License', 'south'),
                    style: formLabelStyle,
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
                      hintText: south,
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (south) {
                      if (south.toString().isEmpty)
                        return 'Enter south area';
                      else if (!simpleText(south!))
                        return 'Please Enter Only Text With No Space';
                      else
                        return null;
                    },
                    onFieldSubmitted: (String value) {
                      westFocusNode.requestFocus();
                    },
                  ),
                  EmptyWidget(),
                  Text(
                    getTranslated(context, 'Building_License', 'west'),
                    style: formLabelStyle,
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
                      hintText: west,
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (west) {
                      if (west.toString().isEmpty)
                        return 'Enter west area';
                      else if (!simpleText(west!))
                        return 'Please Enter Only Text With No Space';
                      else
                        return null;
                    },
                    onFieldSubmitted: (String value) {
                      northFocusNode.requestFocus();
                    },
                  ),
                  EmptyWidget(),
                  Text(
                    getTranslated(context, 'Building_License', 'north'),
                    style: formLabelStyle,
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
                      hintText: north,
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (north) {
                      if (north.toString().isEmpty)
                        return 'Enter north area';
                      else if (!simpleText(north!))
                        return 'Please Enter Only Text With No Space';
                      else
                        return null;
                    },
                  ),
                  EmptyWidget(),
                  Text(
                    getTranslated(
                        context, 'Building_License', 'direction_main_door'),
                    style: formLabelStyle,
                  ),
                  DropDownWidget(
                      lable: 'Select direction ',
                      list: directionList,
                      selValue: directionSelect,
                      selectValue: (value) {
                        setState(() {
                          directionSelect = value;
                        });
                      }),
                  EmptyWidget(),
                  Text(
                    getTranslated(context, 'Building_License', 'no_of_rooms'),
                    style: formLabelStyle,
                  ),
                  TextFormField(
                    controller: noOfRoomsT,
                    focusNode: noOfRoomsFocusNode,
                    keyboardType: TextInputType.text,
                    style: blackNormalText16,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: blackColor)),
                      isDense: true,
                      hintText: no_of_rooms,
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (noOfRooms) {
                      if (noOfRooms.toString().isEmpty)
                        return 'Enter no of rooms area';
                      else if (!onlyDigit(noOfRooms!))
                        return 'Please Enter Only Number';
                      else
                        return null;
                    },
                    onFieldSubmitted: (String value) {
                      noOfFloorsFocusNode.requestFocus();
                    },
                  ),
                  EmptyWidget(),
                  Text(
                    getTranslated(
                        context, 'Building_License', 'no_of_floors'),
                    style: formLabelStyle,
                  ),
                  TextFormField(
                    controller: noOfFloorsT,
                    focusNode: noOfFloorsFocusNode,
                    keyboardType: TextInputType.text,
                    style: blackNormalText16,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: blackColor)),
                      isDense: true,
                      hintText: no_of_floors,
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (noOfFloors) {
                      if (noOfFloors.toString().isEmpty)
                        return 'Enter no of floors area';
                      else if (!onlyDigit(noOfFloors!))
                        return 'Please Enter Only Number';
                      else
                        return null;
                    },
                  ),
                  EmptyWidget(),
                  /*Text(
                    getTranslated(
                        context, 'Building_License', 'toilet_facility'),
                    textAlign: TextAlign.start,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Radio(
                        value: yes,
                        groupValue: toilet_f_radio,
                        onChanged: (index) {
                          setState(() {
                            toilet_f_radio = index;
                            print(toilet_f_radio);
                          });
                        },
                        activeColor: Colors.green,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                        child: Text(yes, style: blackNormalText14),
                      ),
                      Radio(
                        value: no,
                        groupValue: toilet_f_radio,
                        onChanged: (index1) {
                          setState(() {
                            toilet_f_radio = index1;
                            print(toilet_f_radio);
                          });
                        },
                        activeColor: Colors.green,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                        child: Text(no, style: blackNormalText14),
                      ),
                    ],
                  ),
                  EmptyWidget(),
                  Text(
                    getTranslated(context, 'Building_License', 'solar'),
                    textAlign: TextAlign.start,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Radio(
                        value: 1,
                        groupValue: solar_f_radio,
                        onChanged: (index3) {
                          setState(() {
                            solar_f_radio = index3;
                          });
                        },
                        activeColor: Colors.green,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                        child: Text(yes, style: blackNormalText14),
                      ),
                      Radio(
                        value: 2,
                        groupValue: solar_f_radio,
                        onChanged: (index4) {
                          setState(() {
                            solar_f_radio = index4;
                          });
                          print(solar_f_radio);
                        },
                        activeColor: Colors.green,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                        child: Text(no, style: blackNormalText14),
                      ),
                    ],
                  ),
                  EmptyWidget(),
                  Text(
                    getTranslated(context, 'Building_License', 'rain'),
                    textAlign: TextAlign.start,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Radio(
                        value: 3,
                        groupValue: rain_f_radio,
                        onChanged: (index5) {
                          setState(() {
                            rain_f_radio = index5;
                          });
                          print(rain_f_radio);
                        },
                        activeColor: Colors.green,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                        child: Text(yes, style: blackNormalText14),
                      ),
                      Radio(
                        value: 4,
                        groupValue: rain_f_radio,
                        onChanged: (index6) {
                          setState(() {
                            rain_f_radio = index6;
                          });
                          print(rain_f_radio);
                        },
                        activeColor: Colors.green,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                        child: Text(no, style: blackNormalText14),
                      ),
                    ],
                  ),
                  EmptyWidget(),
                  Text(
                    getTranslated(context, 'Building_License', 'professional'),
                    style: formLabelStyle,
                  ),
                  TextFormField(
                    controller: professionalEngineerT,
                    focusNode: professionalEngineerFocusNode,
                    keyboardType: TextInputType.phone,
                    style: blackNormalText16,
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: blackColor)),
                        isDense: true,
                        hintText: professional,
                        hintMaxLines: 3),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (professional) {
                      if (professional.toString().isEmpty)
                        return 'Enter name of ProfessionalEngineer';
                      else if (!onlyTextWithSpace(professional!))
                        return 'Please Enter Only Text';
                      else
                        return null;
                    },
                    onFieldSubmitted: (String value) {
                      supervisingEngineerFocusNode.requestFocus();
                    },
                  ),
                  EmptyWidget(),
                  Text(
                    getTranslated(context, 'Building_License',
                        'supervising_professional'),
                    style: formLabelStyle,
                  ),
                  TextFormField(
                    controller: supervisingEngineerT,
                    focusNode: supervisingEngineerFocusNode,
                    keyboardType: TextInputType.phone,
                    style: blackNormalText16,
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: blackColor)),
                        isDense: true,
                        hintText: supervising_professional,
                        hintMaxLines: 3),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (supervisingProfessional) {
                      if (supervisingProfessional.toString().isEmpty)
                        return 'Enter name of Supervising Engineer';
                      else if (!onlyTextWithSpace(supervisingProfessional!))
                        return 'Please Enter Only Text';
                      else
                        return null;
                    },
                  ),*/
                ],
              ),
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
      key: formKeyDocDetails,
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
                    upload_document_details.toUpperCase(),
                    style: whiteBoldText16,
                  ),
                ),
              ),
            ),
            EmptyWidget(),
            Text(
              getTranslated(context, 'Building_License', 'doc_ty'),
              textAlign: TextAlign.start,
              style: formLabelStyle,
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
              getTranslated(context, 'Building_License', 'doc_dis'),
              style: formLabelStyle,
            ),
            TextFormField(
              controller: documentDecT,
              keyboardType: TextInputType.text,
              style: blackNormalText16,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                isDense: true,
                hintText: doc_dis,
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
                // //height: docList.length>0 ? 150 :0,
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
            EmptyWidget(),
          ],
        ),
      ),
    );
  }

  void saveApplicantDetails() async {
    if (formKeyApplicantDetails.currentState!.validate()) {
      BuildingLicenseApplicantDetailsModel applicantDetailsModel =
      new BuildingLicenseApplicantDetailsModel(
          dft_bldg_lic_appl_dtl_id: '',
          appl_name: applicationNameT.text,
          family_id: familyIdT.text,
          parent_spouse_name: parentNameT.text,
          add_line_1: address1T.text,
          add_line_2: address2T.text,
          mobile_no: mobileNumberT.text,
          pin_code: pincodeT.text,
          crt_date: '',
          crt_user: '',
          crt_ip: '',
          lst_upd_ip: '',
          lst_upd_date: '',
          lst_upd_user: '',
          status: 'Y');

      licenseModel = new BuildingLicenseModel(
          applicantDetailsModel: applicantDetailsModel,
          propertyDetailsModel:
          licenseModel == null ? null : licenseModel!.propertyDetailsModel,
          buildingDetailsModel:
          licenseModel == null ? null : licenseModel!.buildingDetailsModel,
          buildingDocumentModel: licenseModel == null
              ? null
              : licenseModel!.buildingDocumentModel);

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
          applicationId = applicationId.isEmpty ? i.toString() : applicationId;
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

  void savePropertyDetails() async {
    if (formKeyPropertyDetails.currentState!.validate()) {
      BuildingLicensePropertyDetailsModel licensePropertyDetailsModel =
      new BuildingLicensePropertyDetailsModel(
          dft_bldg_lic_prop_dtl_id: '',
          district_id: selectedDistId,
          tp_id: selectedTalukaId,
          gp_id: selectedPanchayatId,
          village_id: selectedVillageId,
          property_id: propertyIdSelect,
          crt_date: '',
          crt_user: '',
          crt_ip: '',
          lst_upd_ip: '',
          lst_upd_date: '',
          lst_upd_user: '',
          status: "Y");

      licenseModel = new BuildingLicenseModel(
          applicantDetailsModel: licenseModel!.applicantDetailsModel,
          propertyDetailsModel: licensePropertyDetailsModel,
          buildingDetailsModel: licenseModel!.buildingDetailsModel,
          buildingDocumentModel: licenseModel!.buildingDocumentModel);

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

  void saveLicenseDetails() async {
    if (formKeyLicenseDetails.currentState!.validate()) {
      if (constructionType == null) {
        showMessageToast('Please Select Construction Type');
      }
      /*else if (toilet_f_radio == null) {
        showMessageToast('Please Select Toilet Facility');
      } else if (solar_f_radio == null) {
        showMessageToast('Please Select Solar Facility');
      } else if (rain_f_radio == null) {
        showMessageToast('Please Select Rain Water Harvesting Facility');
      }*/
      else {
        BuildingLicenseBuildingDetailsModel buildingDetailsModel =
        new BuildingLicenseBuildingDetailsModel(
            dft_bldg_lic_bldg_dtl: '',
            constr_type: constructionType == 11
                ? Addition_
                : constructionType == 12
                ? Alteration_
                : New_,
            purpose_id: purposeSelect,
            prop_type_id: propertyTypeListSelect,
            est_of_bldg: estimationBuildingT.text,
            ppsd_plinth_area: plinthT.text,
            type_of_bldg_constr_id: buildingConstructionSelect,
            total_area: totalAreaT.text,
            built_area: builtUpT.text,
            east_west: eastWestT.text,
            north_south: northSouthT.text,
            east: eastT.text,
            south: southT.text,
            west: westT.text,
            north: northT.text,
            drctn_of_door_id: directionSelect,
            no_of_room_ppsd: noOfRoomsT.text,
            no_of_floors_ppsd: noOfFloorsT.text,
            crt_date: '',
            crt_user: '',
            crt_ip: '',
            lst_upd_ip: '',
            lst_upd_date: '',
            lst_upd_user: '',
            status: 'Y');

        licenseModel = new BuildingLicenseModel(
            applicantDetailsModel: licenseModel!.applicantDetailsModel,
            propertyDetailsModel: licenseModel!.propertyDetailsModel,
            buildingDetailsModel: buildingDetailsModel,
            buildingDocumentModel: licenseModel!.buildingDocumentModel);

        var i = await DatabaseOperation.instance.updateMstAddApplicationModel(
            applicationId,
            jsonEncode(licenseModel),
            getCurrentDateUsingFormatter('DD/MM/YYYY'),
            _currentStep.toString());

        if (i > 0) {
          showMessageToast('Building details draft');
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
    // if (filePath.isNotEmpty && formKeyDocDetails.currentState!.validate()) {
    BuildingLicenseDocumentDetailsModel documentDetailsModel = new BuildingLicenseDocumentDetailsModel("", "", filePath,
        docTypeSelect, documentDecT.text, "", "", "", "", "", "", "Y");

    licenseModel = new BuildingLicenseModel(
        applicantDetailsModel: licenseModel!.applicantDetailsModel,
        propertyDetailsModel: licenseModel!.propertyDetailsModel,
        buildingDetailsModel: licenseModel!.buildingDetailsModel,
        buildingDocumentModel: documentDetailsModel);

    var i = await DatabaseOperation.instance.updateMstAddApplicationModel(
        applicationId,
        jsonEncode(licenseModel),
        getCurrentDateUsingFormatter('DD/MM/YYYY'),
        _currentStep.toString());

    if (i > 0) {
      if (flag == 'save') {
        var j = await DatabaseOperation.instance.updateFinalApplicationStatus(applicationId);
        await DatabaseOperation.instance.updateSyncMessageStatus(applicationId, '');
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

      licenseModel = new BuildingLicenseModel(
          applicantDetailsModel:
          jsonData.containsKey('1') && jsonData["1"] != null ? BuildingLicenseApplicantDetailsModel.fromJson(jsonData["1"]) : null,
          propertyDetailsModel:
          jsonData.containsKey('2') && jsonData["2"] != null ? BuildingLicensePropertyDetailsModel.fromJson(jsonData["2"]) : null,
          buildingDetailsModel:
          jsonData.containsKey('3') && jsonData["3"] != null ? BuildingLicenseBuildingDetailsModel.fromJson(jsonData["3"]) : null,
          buildingDocumentModel:
          jsonData.containsKey('4') && jsonData["4"] != null ? BuildingLicenseDocumentDetailsModel.fromJson(jsonData["4"]) : null);

      if (licenseModel!.applicantDetailsModel != null) {
        applicationNameT.text = licenseModel!.applicantDetailsModel!.appl_name;
        familyIdT.text = licenseModel!.applicantDetailsModel!.family_id;
        parentNameT.text = licenseModel!.applicantDetailsModel!.parent_spouse_name;
        address1T.text = licenseModel!.applicantDetailsModel!.add_line_1;
        address2T.text = licenseModel!.applicantDetailsModel!.add_line_2;
        mobileNumberT.text = licenseModel!.applicantDetailsModel!.mobile_no;
        pincodeT.text = licenseModel!.applicantDetailsModel!.pin_code;
      }

      if (licenseModel!.propertyDetailsModel != null) {
        selectedDistId = licenseModel!.propertyDetailsModel!.district_id;
        selectedTalukaId = licenseModel!.propertyDetailsModel!.tp_id;
        selectedPanchayatId = licenseModel!.propertyDetailsModel!.gp_id;
        selectedVillageId = licenseModel!.propertyDetailsModel!.village_id;
        propertyIdSelect = licenseModel!.propertyDetailsModel!.property_id;

        districtName = await DatabaseOperation.instance.getDistrictName(licenseModel!.propertyDetailsModel!.district_id);
        talukaName = await DatabaseOperation.instance.getTalukaName(licenseModel!.propertyDetailsModel!.tp_id);
        panchayatName = await DatabaseOperation.instance.getPanchayatName(licenseModel!.propertyDetailsModel!.gp_id);
        villageName = await DatabaseOperation.instance.getVillageName(licenseModel!.propertyDetailsModel!.property_id);
      }

      if (licenseModel!.buildingDetailsModel != null) {
        purposeSelect = licenseModel!.buildingDetailsModel!.purpose_id;
        constructionType = licenseModel!.buildingDetailsModel!.constr_type == Addition_ ? 11 : licenseModel!.buildingDetailsModel!.constr_type == New_ ? 12 : 13;
        propertyTypeListSelect = licenseModel!.buildingDetailsModel!.prop_type_id;
        estimationBuildingT.text = licenseModel!.buildingDetailsModel!.est_of_bldg;
        plinthT.text = licenseModel!.buildingDetailsModel!.ppsd_plinth_area;
        buildingConstructionSelect = licenseModel!.buildingDetailsModel!.type_of_bldg_constr_id;
        totalAreaT.text = licenseModel!.buildingDetailsModel!.total_area;
        builtUpT.text = licenseModel!.buildingDetailsModel!.built_area;
        eastWestT.text = licenseModel!.buildingDetailsModel!.east_west;
        northSouthT.text = licenseModel!.buildingDetailsModel!.north_south;
        eastT.text = licenseModel!.buildingDetailsModel!.east;
        southT.text = licenseModel!.buildingDetailsModel!.south;
        westT.text = licenseModel!.buildingDetailsModel!.west;
        northT.text = licenseModel!.buildingDetailsModel!.north;
        directionSelect = licenseModel!.buildingDetailsModel!.drctn_of_door_id;
        noOfRoomsT.text = licenseModel!.buildingDetailsModel!.no_of_room_ppsd;
        noOfFloorsT.text = licenseModel!.buildingDetailsModel!.no_of_floors_ppsd;
      }

      /*if (licenseModel!.buildingDocumentModel != null) {
        filePath = licenseModel!.buildingDocumentModel!.doc_id;
        var fname = licenseModel!.buildingDocumentModel!.doc_id.split("/");
        fileName = fname[fname.length - 1];
        documentDecT.text = licenseModel!.buildingDocumentModel!.doc_desc;
        docTypeSelect = licenseModel!.buildingDocumentModel!.doc_type;
        bool fileE = await new File(filePath).exists();
        if (!fileE) {
          isFileExits = false;
        }
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
      /*if(int.parse(model.current_tab)==getSteps().length - 1){

      }*/
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
    districtName = await DatabaseOperation.instance.getDistrictName(selectedDistId);
    talukaName = await DatabaseOperation.instance.getTalukaName(selectedTalukaId);
    panchayatName = await DatabaseOperation.instance.getPanchayatName(selectedPanchayatId);
    villageName = await DatabaseOperation.instance.getVillageName(selectedVillageId);
    purposeSelectlabel = await DatabaseOperation.instance.getDropdownName("getMstPurposeData", purposeSelect);
    selected_buildingconType = await DatabaseOperation.instance.getDropdownName("getMstBuildingConstructionData", buildingConstructionSelect);
    directionSelectLabel = await DatabaseOperation.instance.getDropdownName("getMstDirectionDoorConstData", directionSelect);
    docTypeSelect_label = await DatabaseOperation.instance.getDropdownName("getMstDocData", docTypeSelect);

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
                              getTranslated(
                                  context, 'Building_License', 'applicant_details'),
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
                                      getTranslated(context, 'Building_License', 'applicant_name'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      applicationNameT.text,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'Building_License', 'parent_spouse_name'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      parentNameT.text,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'Building_License', 'mobile_number'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      mobileNumberT.text,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'Building_License', 'family_id'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      familyIdT.text,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'Building_License', 'address_line_1'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      address1T.text,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'Building_License', 'address_line_2'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      address2T.text,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'Building_License', 'pincode'),
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
                              getTranslated(context, 'Building_License',
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
                                  context, 'Building_License', 'license_details'),
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
                                      getTranslated(context, 'Building_License', 'purpose'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      purposeSelectlabel,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(
                                          context, 'Building_License', 'building_construction'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      constructionType == 11
                                          ? Addition_
                                          : constructionType == 12
                                          ? Alteration_
                                          : constructionType == 13
                                          ? New_:'',
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'Building_License', 'property_type'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      propertyTypeListSelect,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(
                                          context, 'Building_License', 'estimation_of_building'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      estimationBuildingT.text+" Lakhs",
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(
                                          context, 'Building_License', 'building_construction'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      selected_buildingconType,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'Building_License', 'proposed_plinth'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      plinthT.text+" Sq mt",
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'Building_License', 'total_area'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      totalAreaT.text+" Sq mt",
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'Building_License', 'built_up_area'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      builtUpT.text+" Sq mt",
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'Building_License', 'east_west'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      eastWestT.text+" Meters",
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'Building_License', 'north_south'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      northSouthT.text+" Meters",
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'Building_License', 'east'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      eastT.text,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'Building_License', 'south'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      southT.text,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'Building_License', 'west'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      westT.text,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'Building_License', 'north'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      northT.text,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(
                                          context, 'Building_License', 'direction_main_door'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      directionSelectLabel,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'Building_License', 'no_of_rooms'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      noOfRoomsT.text,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'Building_License', 'no_of_floors'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      noOfFloorsT.text,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    /*Divider(thickness: 1),
                                    Text(
                                      professional,
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      professionalEngineerT.text,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      supervising_professional,
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      supervisingEngineerT.text,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),*/
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
                              getTranslated(context, 'Building_License',
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

  void getDropdownData() async {
    purposeList = await DatabaseOperation.instance
        .getDropdown("getMstPurposeData", "2", "2");
    buildingConstructionList = await DatabaseOperation.instance
        .getDropdown("getMstBuildingConstructionData", "2", "2");
    directionList = await DatabaseOperation.instance
        .getDropdown("getMstDirectionDoorConstData", "2", "2");
    docTypeList =
    await DatabaseOperation.instance.getDropdown("getMstDocData", "2", "2");
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
          document_type: await DatabaseOperation.instance
              .getDropdownNameUsingCategory(widget.categoryId, widget.serviceId,
              "getMstDocData", docTypeSelect),
          document_description: documentDecT.text,
          document_name: fileName,
          document_path: filePath,
          app_trn_id: applicationId,
          sync_status: "N");

      int i = await DatabaseOperation.instance.insertDocument(model);

      if (i > 0) {
        showMessageToast('Document inserted successfully');
        formKeyDocDetails.currentState!.reset();
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
