import 'dart:convert';
import 'dart:io';

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
import 'package:citizen_service/Utility/EmptyWidget.dart';
import 'package:citizen_service/Utility/String.dart';
import 'package:citizen_service/Utility/Style.dart';
import 'package:citizen_service/Utility/Utility.dart';
import 'package:citizen_service/Utility/ViewImage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:citizen_service/GlobalsVariable/GlobalsVariable.dart'
    as globals;

class ViewBuildingLicense extends StatefulWidget {
  final String categoryId, serviceId, title, applicationId;

  const ViewBuildingLicense(
      {Key? key,
      required this.title,
      required this.categoryId,
      required this.serviceId,
      required this.applicationId})
      : super(key: key);

  @override
  _ViewBuildingLicenseState createState() => _ViewBuildingLicenseState();
}

class _ViewBuildingLicenseState extends State<ViewBuildingLicense> {
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
  String constructionSelect = '';
  String fileName = '';
  String filePath = '';
  String propertyTypeListSelect = '';
  String purposeSelect = '';
  String buildingRoofeTypeSelect = '';
  String buildingConstructionSelect = '';
  String docTypeSelect = '';
  String selectedDistId = '';
  String selectedTalukaId = '';
  String selectedPanchayatId = '';
  String selectedVillageId = '';
  String propertyIdSelect = '';
  String applicationId = '';
  String selected_buildingconType = '';

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

  String constructionType = '';
  List<MstAppDocumentModel> docList = [];

  @override
  void initState() {
    super.initState();
    if (widget.applicationId.isNotEmpty && widget.applicationId != '0') {
      fetchApplicationData(widget.applicationId);

    }
  }

  List<DropDownModal> purposeList = [
    DropDownModal(id: '1', title: 'Dist1', titleKn: '1'),
    DropDownModal(id: '2', title: 'Dist2', titleKn: '2'),
    DropDownModal(id: '3', title: 'Dist3', titleKn: '3'),
    DropDownModal(id: '4', title: 'Dist4', titleKn: '4'),
    DropDownModal(id: '5', title: 'Dist5', titleKn: '5')
  ];

  List<DropDownModal> properTypeList = [
    DropDownModal(id: '1', title: 'Dist1', titleKn: '1'),
    DropDownModal(id: '2', title: 'Dist2', titleKn: '2'),
    DropDownModal(id: '3', title: 'Dist3', titleKn: '3'),
    DropDownModal(id: '4', title: 'Dist4', titleKn: '4'),
    DropDownModal(id: '5', title: 'Dist5', titleKn: '5')
  ];

  List<DropDownModal> buildingRoofeTypeList = [
    DropDownModal(id: '1', title: 'Dist1', titleKn: '1'),
    DropDownModal(id: '2', title: 'Dist2', titleKn: '2'),
    DropDownModal(id: '3', title: 'Dist3', titleKn: '3'),
    DropDownModal(id: '4', title: 'Dist4', titleKn: '4'),
    DropDownModal(id: '5', title: 'Dist5', titleKn: '5')
  ];

  List<DropDownModal> buildingConstructionList = [
    DropDownModal(id: '1', title: 'Dist1', titleKn: '1'),
    DropDownModal(id: '2', title: 'Dist2', titleKn: '2'),
    DropDownModal(id: '3', title: 'Dist3', titleKn: '3'),
    DropDownModal(id: '4', title: 'Dist4', titleKn: '4'),
    DropDownModal(id: '5', title: 'Dist5', titleKn: '5')
  ];

  List<DropDownModal> docTypeList = [
    DropDownModal(id: '1', title: 'Dist1', titleKn: '1'),
    DropDownModal(id: '2', title: 'Dist2', titleKn: '2'),
    DropDownModal(id: '3', title: 'Dist3', titleKn: '3'),
    DropDownModal(id: '4', title: 'Dist4', titleKn: '4'),
    DropDownModal(id: '5', title: 'Dist5', titleKn: '5')
  ];

  late List<bool> isChecked = [false, false, false];

  List<DropDownModal> property_id_list = [
    DropDownModal(id: '1', title: 'Dist1', titleKn: '1'),
    DropDownModal(id: '2', title: 'Dist2', titleKn: '2'),
    DropDownModal(id: '3', title: 'Dist3', titleKn: '3'),
    DropDownModal(id: '4', title: 'Dist4', titleKn: '4'),
    DropDownModal(id: '5', title: 'Dist5', titleKn: '5')
  ];

  List<DropDownModal> directionList = [];

  var toilet_f_radio, solar_f_radio, rain_f_radio;
  bool isFileExits = true;
  bool isNetCon = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor:
              globals.isTrainingMode ? testModePrimaryColor : primaryColor,
          title: Text(building_license),
        ),
        body: Container(
          child: Column(
            children: [
              Expanded(
                  child: Theme(
                data: ThemeData(
                    colorScheme: ColorScheme.light(
                  primary: primaryColor,
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
                        if (_currentStep < getSteps().length) {
                          setState(() => _currentStep += 1);
                        }
                      } else if (!globals.isTrainingMode && _currentStep == 1) {
                        if (_currentStep < getSteps().length) {
                          setState(() => _currentStep += 1);
                        }
                      } else if (!globals.isTrainingMode && _currentStep == 2) {
                        if (_currentStep < getSteps().length) {
                          setState(() => _currentStep += 1);
                        }
                      } else if (!globals.isTrainingMode && _currentStep == 3) {
                        if (_currentStep < getSteps().length) {
                          setState(() => _currentStep += 1);
                        }
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
                            ? SizedBox()
                            : ElevatedButton(
                                onPressed: onStepContinue,
                                style: submitButtonBlueStyle,
                                child:
                                    Text(next_view, style: whiteNormalText14)),
                      ],
                    );
                  },
                ),
              )),
            ],
          ),
        ));
  }

  List<Step> getSteps() {
    return [
      Step(
          title: new Text('', style: formTitle),
          isActive: _currentStep >= 0,
     //     state: _currentStep == 0 ? StepState.editing : StepState.complete,
          content: applicantDetailsWidget()),
      Step(
        title: new Text('', style: formTitle),
        content: propertyDetailsWidget(),
        isActive: _currentStep >= 1,
        // state: _currentStep == 1
        //     ? StepState.editing
        //     : _currentStep < 1
        //         ? StepState.disabled
        //         : StepState.complete,
      ),
      Step(
        title: new Text('', style: formTitle),
        content: buildingDetailsWidget(),
        isActive: _currentStep >= 2,
        // state: _currentStep == 2
        //     ? StepState.editing
        //     : _currentStep < 2
        //         ? StepState.disabled
        //         : StepState.complete,
      ),
      Step(
        title: new Text('', style: formTitle),
        content: uploadDocumentWidget(),
        isActive: _currentStep >= 3,
        // state: _currentStep == 3
        //     ? StepState.editing
        //     : _currentStep < 3
        //         ? StepState.disabled
        //         : StepState.complete,
      ),
    ];
  }

  Widget applicantDetailsWidget() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Card(
            color: primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30))),
            elevation: 3.0,
            child: Padding(
              padding: EdgeInsets.all(7.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  getTranslated(
                      context, 'Building_License', 'applicant_details').toUpperCase(),
                  style: whiteBoldText16,
                ),
              ),
            ),
          ),
          EmptyWidget(),
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
    );
  }

  Widget propertyDetailsWidget() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Card(
            color: primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30))),
            elevation: 3.0,
            child: Padding(
              padding: EdgeInsets.all(7.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  getTranslated(context, 'Building_License',
                      'property_village_details').toUpperCase(),
                  style: whiteBoldText16,
                ),
              ),
            ),
          ),
          EmptyWidget(),
          Text(
            getTranslated(context, 'Building_License',
                'district'),
            style: graypreviewText13,
          ),
          Text(
            selectedDistId,
            style: grayBoldText16,
          ),
          Divider(thickness: 1),
          Text(
            getTranslated(context, 'Building_License',
                'taluka'),
            style: graypreviewText13,
          ),
          Text(
            selectedTalukaId,
            style: grayBoldText16,
          ),
          Divider(thickness: 1),
          Text(
            getTranslated(context, 'Building_License',
                'panchayat'),
            style: graypreviewText13,
          ),
          Text(
            selectedPanchayatId,
            style: grayBoldText16,
          ),
          Divider(thickness: 1),
          Text(
            getTranslated(context, 'Building_License',
                'village'),
            style: graypreviewText13,
          ),
          Text(
            selectedVillageId,
            style: grayBoldText16,
          ),
        ],
      ),
    );
  }

  Widget buildingDetailsWidget() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Card(
            color: primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30))),
            elevation: 3.0,
            child: Padding(
              padding: EdgeInsets.all(7.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  getTranslated(
                      context, 'Building_License', 'license_details').toUpperCase(),
                  style: whiteBoldText16,
                ),
              ),
            ),
          ),
          EmptyWidget(),
          Text(
            getTranslated(context, 'Building_License', 'purpose'),
            style: graypreviewText13,
          ),
          Text(
            purposeSelect,
            style: grayBoldText16,
          ),
          Divider(thickness: 1),
          Text(
            getTranslated(
                context, 'Building_License', 'building_construction'),
            style: graypreviewText13,
          ),
          Text(
            constructionType,
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
            plinthT.text +" Sq mt",
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
            directionSelect,
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
         /* Text(
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
    );
  }

  Widget uploadDocumentWidget() {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Card(
          color: primaryColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30))),
          elevation: 3.0,
          child: Padding(
            padding: EdgeInsets.all(7.0),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                getTranslated(context, 'Building_License',
                    'upload_document_details').toUpperCase(),
                style: whiteBoldText16,
              ),
            ),
          ),
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

                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ),

      ],
    ));
  }

  void fetchApplicationData(String applicationId) async {
    MstAddApplicationModel? model =
        await DatabaseOperation.instance.getApplicationUsingID(applicationId);

    if (model != null && model.aPPLICATIONDATA.isNotEmpty) {
      var jsonData = jsonDecode(model.aPPLICATIONDATA);

      BuildingLicenseModel licenseModel = new BuildingLicenseModel(
          applicantDetailsModel:
              jsonData.containsKey('1') && jsonData["1"] != null
                  ? BuildingLicenseApplicantDetailsModel.fromJson(jsonData["1"])
                  : null,
          propertyDetailsModel:
              jsonData.containsKey('2') && jsonData["2"] != null
                  ? BuildingLicensePropertyDetailsModel.fromJson(jsonData["2"])
                  : null,
          buildingDetailsModel:
              jsonData.containsKey('3') && jsonData["3"] != null
                  ? BuildingLicenseBuildingDetailsModel.fromJson(jsonData["3"])
                  : null,
          buildingDocumentModel:
              jsonData.containsKey('4') && jsonData["4"] != null
                  ? BuildingLicenseDocumentDetailsModel.fromJson(jsonData["4"])
                  : null);

      if (licenseModel.applicantDetailsModel != null) {
        applicationNameT.text = licenseModel.applicantDetailsModel!.appl_name;
        familyIdT.text = licenseModel.applicantDetailsModel!.family_id;
        parentNameT.text =
            licenseModel.applicantDetailsModel!.parent_spouse_name;
        address1T.text = licenseModel.applicantDetailsModel!.add_line_1;
        address2T.text = licenseModel.applicantDetailsModel!.add_line_2;
        mobileNumberT.text = licenseModel.applicantDetailsModel!.mobile_no;
        pincodeT.text = licenseModel.applicantDetailsModel!.pin_code;
      }

      if (licenseModel.propertyDetailsModel != null) {
        selectedDistId = await DatabaseOperation.instance.getDistrictName(licenseModel.propertyDetailsModel!.district_id);
        selectedTalukaId = await DatabaseOperation.instance.getTalukaName(licenseModel.propertyDetailsModel!.tp_id);
        selectedPanchayatId = await DatabaseOperation.instance.getPanchayatName(licenseModel.propertyDetailsModel!.gp_id);
        selectedVillageId = await DatabaseOperation.instance.getVillageName(licenseModel.propertyDetailsModel!.village_id);
        propertyIdSelect = licenseModel.propertyDetailsModel!.property_id;


      }

      if (licenseModel.buildingDetailsModel != null) {

        purposeSelect = await DatabaseOperation.instance.getDropdownName("getMstPurposeData", licenseModel.buildingDetailsModel!.purpose_id);

        propertyTypeListSelect =
            licenseModel.buildingDetailsModel!.prop_type_id;
        estimationBuildingT.text =
            licenseModel.buildingDetailsModel!.est_of_bldg;
        plinthT.text = licenseModel.buildingDetailsModel!.ppsd_plinth_area;
        buildingConstructionSelect =
            licenseModel.buildingDetailsModel!.type_of_bldg_constr_id;
        constructionType = licenseModel.buildingDetailsModel!.constr_type;
        selected_buildingconType=await DatabaseOperation.instance.getDropdownName("getMstBuildingConstructionData", licenseModel.buildingDetailsModel!.type_of_bldg_constr_id);
        totalAreaT.text = licenseModel.buildingDetailsModel!.total_area;
        builtUpT.text = licenseModel.buildingDetailsModel!.built_area;
        eastWestT.text = licenseModel.buildingDetailsModel!.east_west;
        northSouthT.text = licenseModel.buildingDetailsModel!.north_south;
        eastT.text = licenseModel.buildingDetailsModel!.east;
        southT.text = licenseModel.buildingDetailsModel!.south;
        westT.text = licenseModel.buildingDetailsModel!.west;
        northT.text = licenseModel.buildingDetailsModel!.north;
        directionSelect = await DatabaseOperation.instance.getDropdownName("getMstDirectionDoorConstData",licenseModel.buildingDetailsModel!.drctn_of_door_id);
        noOfRoomsT.text = licenseModel.buildingDetailsModel!.no_of_room_ppsd;
        noOfFloorsT.text = licenseModel.buildingDetailsModel!.no_of_floors_ppsd;
      }

     /* if (licenseModel.buildingDocumentModel != null) {
        filePath = licenseModel.buildingDocumentModel!.doc_id;
        var fname = licenseModel.buildingDocumentModel!.doc_id.split("/");
        fileName = fname[fname.length - 1];
        docTypeSelect = await DatabaseOperation.instance.getDropdownName("getMstDocData", licenseModel.buildingDocumentModel!.doc_type);
        documentDecT.text = licenseModel.buildingDocumentModel!.doc_desc;
        bool fileE = await new File(filePath).exists();
        if (!fileE) {
          isFileExits = false;
        }
      }*/
      getAllDocument(applicationId);

      setState(() {});
    }
  }
  void getAllDocument(String id) async {
    docList = await DatabaseOperation.instance.getAllDocument(id);

    setState(() {});
  }
}
