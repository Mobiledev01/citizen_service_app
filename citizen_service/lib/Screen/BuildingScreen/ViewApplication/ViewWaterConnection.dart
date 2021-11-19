import 'dart:convert';
import 'package:citizen_service/GlobalsVariable/GlobalsVariable.dart';
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
import 'package:citizen_service/Utility/EmptyWidget.dart';
import 'package:citizen_service/Utility/String.dart';
import 'package:citizen_service/Utility/Style.dart';
import 'package:citizen_service/Utility/Utility.dart';
import 'package:citizen_service/Utility/ViewImage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:citizen_service/GlobalsVariable/GlobalsVariable.dart'
    as globals;

class ViewWaterConnection extends StatefulWidget {
  final String title, categoryId, serviceId, applicationId;

  ViewWaterConnection(
      {Key? key,
      required this.title,
      required this.categoryId,
      required this.serviceId,
      required this.applicationId})
      : super(key: key);

  @override
  _ViewWaterConnectionState createState() => _ViewWaterConnectionState();
}

class _ViewWaterConnectionState extends State<ViewWaterConnection> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.horizontal;

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

  List<DropDownModal> purposeList = [];
  List<DropDownModal> properList = [];
  List<DropDownModal> waterTeriffList = [];
  List<DropDownModal> docTypeList = [];
  List<MstAppDocumentModel> docList = [];

  String purposeSelect = '';
  String fileName = '';
  String filePath = '';
  String propertySelect = '';
  String waterTeriffSelect = '';
  String docTypeSelect = '';
  String? selectedDistId = '';
  String? selectedTalukaId = '';
  String? selectedPanchayatId = '';
  String? selectedVillageId = '';
  bool isFileExits = true;

  @override
  void initState() {
    super.initState();

    purposeList.add(
        new DropDownModal(title: 'purpose 1', titleKn: 'purpose 1', id: '1'));
    purposeList.add(
        new DropDownModal(title: 'purpose 2', titleKn: 'purpose 2', id: '2'));
    purposeList.add(
        new DropDownModal(title: 'purpose 3', titleKn: 'purpose 3', id: '3'));

    waterTeriffList.add(new DropDownModal(
        title: 'waterTeriffList 1', titleKn: 'waterTeriffList 1', id: '1'));
    waterTeriffList.add(new DropDownModal(
        title: 'waterTeriffList 2', titleKn: 'waterTeriffList 2', id: '2'));
    waterTeriffList.add(new DropDownModal(
        title: 'waterTeriffList 3', titleKn: 'waterTeriffList 3', id: '3'));

    properList.add(new DropDownModal(
        title: 'properList 1', titleKn: 'properList 1', id: '1'));
    properList.add(new DropDownModal(
        title: 'properList 2', titleKn: 'properList 2', id: '2'));
    properList.add(new DropDownModal(
        title: 'properList 3', titleKn: 'properList 3', id: '3'));

    docTypeList.add(new DropDownModal(
        title: 'docTypeList 1', titleKn: 'docTypeList 1', id: '1'));
    docTypeList.add(new DropDownModal(
        title: 'docTypeList 2', titleKn: 'docTypeList 2', id: '2'));
    docTypeList.add(new DropDownModal(
        title: 'docTypeList 3', titleKn: 'docTypeList 3', id: '3'));

    if (widget.applicationId.isNotEmpty && widget.applicationId != '0') {
      fetchApplicationData(widget.applicationId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor:
              globals.isTrainingMode ? testModePrimaryColor : primaryColor,
          title: Text(new_water_con),
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
          content: applicantDetailsWidget()),
      Step(
        title: new Text('', style: formTitle),
        content: propertyDetailsWidget(),
        isActive: _currentStep >= 1,
      ),
      Step(
        title: new Text('', style: formTitle),
        content: waterConnectionDetails(),
        isActive: _currentStep >= 2,
      ),
      Step(
        title: new Text('', style: formTitle),
        content: uploadDocumentWidget(),
        isActive: _currentStep >= 3,
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
                    bottomLeft: Radius.circular(30))),            elevation: 0,
            child: Padding(
              padding: EdgeInsets.all(7.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  getTranslated(context, 'WaterConnection', 'applicant_details')
                      .toUpperCase()
                      .toUpperCase(),
                  style: whiteBoldText16,
                ),
              ),
            ),
          ),
          EmptyWidget(),
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
    );
  }

  Widget propertyDetailsWidget() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            color: primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30))),            elevation: 0,
            child: Padding(
              padding: EdgeInsets.all(7.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  getTranslated(context, 'WaterConnection',
                          'property_village_details')
                      .toUpperCase(),
                  style: whiteBoldText16,
                ),
              ),
            ),
          ),
          EmptyWidget(),
          Text(
            getTranslated(context, 'Building_License', 'district'),
            style: graypreviewText13,
          ),
          Text(
            selectedDistId!,
            style: grayBoldText16,
          ),
          Divider(thickness: 1),
          Text(
            getTranslated(context, 'Building_License', 'taluka'),
            style: graypreviewText13,
          ),
          Text(
            selectedTalukaId!,
            style: grayBoldText16,
          ),
          Divider(thickness: 1),
          Text(
            getTranslated(context, 'Building_License', 'panchayat'),
            style: graypreviewText13,
          ),
          Text(
            selectedPanchayatId!,
            style: grayBoldText16,
          ),
          Divider(thickness: 1),
          Text(
            getTranslated(context, 'Building_License', 'village'),
            style: graypreviewText13,
          ),
          Text(
            selectedVillageId!,
            style: grayBoldText16,
          ),
          Divider(thickness: 1),
          Text(
            getTranslated(context, 'WaterConnection', 'property_id'),
            style: graypreviewText13,
          ),
          Text(
            'df',
            style: grayBoldText16,
          ),
        ],
      ),
    );
  }

  Widget waterConnectionDetails() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            color: primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30))),            elevation: 0,
            child: Padding(
              padding: EdgeInsets.all(7.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  getTranslated(context, 'WaterConnection', 'water_conn_detail')
                      .toUpperCase(),
                  style: whiteBoldText16,
                ),
              ),
            ),
          ),
          EmptyWidget(),
          Text(
            getTranslated(context, 'WaterConnection', 'purpose_of_water_con'),
            style: graypreviewText13,
          ),
          Text(
            purposeSelect,
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
            waterTeriffSelect,
            style: grayBoldText16,
          ),
          Divider(thickness: 1),
          Text(
            getTranslated(context, 'WaterConnection', 'east'),
            style: graypreviewText13,
          ),
          Text(
            eastT.text,
            style: grayBoldText16,
          ),
          Divider(thickness: 1),
          Text(
            getTranslated(context, 'WaterConnection', 'south'),
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
    );
  }

  Widget uploadDocumentWidget() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            color: primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30))),            elevation: 0,
            child: Padding(
              padding: EdgeInsets.all(7.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  getTranslated(
                          context, 'WaterConnection', 'upload_document_details')
                      .toUpperCase(),
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
         /* Divider(),
          Text(
            getTranslated(context, 'WaterConnection', 'doc_ty'),
            style: graypreviewText13,
          ),
          Text(
            docTypeSelect,
            style: grayBoldText16,
          ),
          Divider(thickness: 1),
          Text(
            getTranslated(context, 'WaterConnection', 'doc_dis'),
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
              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextButton.icon(
                      style: TextButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                      onPressed: () {
                        if (filePath.isNotEmpty) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewImage(
                                      filepath: filePath, filename: fileName)));
                        } else {
                          showMessageToast('No Image to display');
                        }
                      },
                      icon: Icon(
                        fileName.contains('pdf')
                            ? Icons.picture_as_pdf
                            : Icons.image,
                        size: 25,
                        color: whiteColor,
                      ),
                      label: Text(' View ',
                          style: whiteBoldText14,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        fileName,
                        style: blackNormalText14,
                        maxLines: 3,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),*/
        ],
      ),
    );
  }

  void fetchApplicationData(String applicationId) async {
    MstAddApplicationModel? model =
        await DatabaseOperation.instance.getApplicationUsingID(applicationId);
    if (model != null && model.aPPLICATIONDATA.isNotEmpty) {
      var jsonData = jsonDecode(model.aPPLICATIONDATA);

      NewWaterConnectionModel mainModel = new NewWaterConnectionModel(
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

      if (mainModel.applicantDetailsModel != null) {
        applicationNameT.text = mainModel.applicantDetailsModel!.appl_name;
        familyIdT.text = mainModel.applicantDetailsModel!.family_id;
        pincodeT.text = mainModel.applicantDetailsModel!.pin_code;
        parentNameT.text = mainModel.applicantDetailsModel!.parent_spouse_name;
        address1T.text = mainModel.applicantDetailsModel!.add_line_1;
        address2T.text = mainModel.applicantDetailsModel!.add_line_2;
        mobileNumberT.text = mainModel.applicantDetailsModel!.mob_no;
      }
      if (mainModel.propertyDetailsModel != null) {
        selectedDistId = mainModel.propertyDetailsModel!.district_id;
        selectedTalukaId = mainModel.propertyDetailsModel!.tp_id;
        selectedPanchayatId = mainModel.propertyDetailsModel!.gp_id;
        selectedVillageId = mainModel.propertyDetailsModel!.village_id;
        propertySelect = mainModel.propertyDetailsModel!.property_id;

        selectedDistId = await DatabaseOperation.instance
            .getDistrictName(mainModel.propertyDetailsModel!.district_id);
        selectedTalukaId = await DatabaseOperation.instance
            .getTalukaName(mainModel.propertyDetailsModel!.tp_id);
        selectedPanchayatId = await DatabaseOperation.instance
            .getPanchayatName(mainModel.propertyDetailsModel!.gp_id);
        selectedVillageId = await DatabaseOperation.instance
            .getVillageName(mainModel.propertyDetailsModel!.village_id);
      }

      if (mainModel.waterConnectionModel != null) {
        purposeSelect = await DatabaseOperation.instance.getDropdownName(
            "getMstPurNewWaterConn",
            mainModel.waterConnectionModel!.ppsd_of_water_conn);
        waterTeriffSelect = await DatabaseOperation.instance.getDropdownName(
            "getMstWaterTariffData",
            mainModel.waterConnectionModel!.water_teriff);
        familyMemberT.text = mainModel.waterConnectionModel!.no_of_family_mem;
        eastT.text = mainModel.waterConnectionModel!.east;
        southT.text = mainModel.waterConnectionModel!.south;
        westT.text = mainModel.waterConnectionModel!.west;
        northT.text = mainModel.waterConnectionModel!.north;
      }
      /*if (mainModel.waterConnDocumentModel != null) {
        filePath = mainModel.waterConnDocumentModel!.doc_id;
        var fname = mainModel.waterConnDocumentModel!.doc_id.split("/");
        fileName = fname[fname.length - 1];
        documentDecT.text = mainModel.waterConnDocumentModel!.doc_description;
        docTypeSelect = await DatabaseOperation.instance.getDropdownName(
            "getMstDocData", mainModel.waterConnDocumentModel!.doc_type_id);
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
