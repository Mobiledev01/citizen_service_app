import 'dart:convert';
import 'package:citizen_service/Model/AdvtLicenseModel/AdvtLicenseAdvertiseDetailsModel.dart';
import 'package:citizen_service/Model/AdvtLicenseModel/AdvtLicenseApplicantDetailsModel.dart';
import 'package:citizen_service/Model/AdvtLicenseModel/AdvtLicenseDocumentDetailsModel.dart';
import 'package:citizen_service/Model/AdvtLicenseModel/AdvtLicenseModel.dart';
import 'package:citizen_service/Model/AdvtLicenseModel/AdvtLicensePropertyDetailsModel.dart';
import 'package:citizen_service/Model/DropDownModel.dart';
import 'package:citizen_service/Model/EntertainmentLicenseModel/EntmtLicenseApplicantDetailsModel.dart';
import 'package:citizen_service/Model/EntertainmentLicenseModel/EntmtLicenseDocumentDetailsModel.dart';
import 'package:citizen_service/Model/EntertainmentLicenseModel/EntmtLicenseModel.dart';
import 'package:citizen_service/Model/EntertainmentLicenseModel/EntmtLicenseProgramDetailsModel.dart';
import 'package:citizen_service/Model/EntertainmentLicenseModel/EntmtLicensePropertyDetailsModel.dart';
import 'package:citizen_service/Model/FactoryClearanceModel/FactoryPerApplicantDetailsModel.dart';
import 'package:citizen_service/Model/FactoryClearanceModel/FactoryPerBuildingModel.dart';
import 'package:citizen_service/Model/FactoryClearanceModel/FactoryPerDocumentDetailsModel.dart';
import 'package:citizen_service/Model/FactoryClearanceModel/FactoryPerModel.dart';
import 'package:citizen_service/Model/FactoryClearanceModel/FactoryPerPropertyDetailsModel.dart';
import 'package:citizen_service/Model/MstAddApplicationModel.dart';
import 'package:citizen_service/Model/MstAppDocumentModel.dart';
import 'package:citizen_service/Model/NewWaterConnectionModel/NewWaterConnectionApplicantDetailsModel.dart';
import 'package:citizen_service/Model/NewWaterConnectionModel/NewWaterConnectionDocumentDetailsModel.dart';
import 'package:citizen_service/Model/NewWaterConnectionModel/NewWaterConnectionModel.dart';
import 'package:citizen_service/Model/NewWaterConnectionModel/NewWaterConnectionPropertyDetailsModel.dart';
import 'package:citizen_service/Model/NewWaterConnectionModel/NewWaterConnectionWaterConnectionModel.dart';
import 'package:citizen_service/Model/TradeLicenseModel/TradeLicenseApplicantDetailsModel.dart';
import 'package:citizen_service/Model/TradeLicenseModel/TradeLicenseDocumentDetailsModel.dart';
import 'package:citizen_service/Model/TradeLicenseModel/TradeLicenseModel.dart';
import 'package:citizen_service/Model/TradeLicenseModel/TradeLicensePropertyDetailsModel.dart';
import 'package:citizen_service/Model/TradeLicenseModel/TradeLicenseTypeAppModel.dart';
import 'package:citizen_service/SqliteDatabase/Database.dart';
import 'package:citizen_service/Utility/Color.dart';
import 'package:citizen_service/Utility/EmptyWidget.dart';
import 'package:citizen_service/Utility/String.dart';
import 'package:citizen_service/Utility/Style.dart';
import 'package:citizen_service/Utility/Utility.dart';
import 'package:citizen_service/Utility/ViewImage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:citizen_service/GlobalsVariable/GlobalsVariable.dart' as globals;

class ViewEntertainmentLicense extends StatefulWidget {
  final String title, categoryId, serviceId, applicationId;

  ViewEntertainmentLicense(
      {Key? key,
      required this.title,
      required this.categoryId,
      required this.serviceId,
      required this.applicationId})
      : super(key: key);

  @override
  _ViewEntertainmentLicense createState() => _ViewEntertainmentLicense();
}

class _ViewEntertainmentLicense extends State<ViewEntertainmentLicense> {
  final FocusNode focusNodeMobileNo = FocusNode();
  StepperType stepperType = StepperType.horizontal;
  int _currentStep = 0;
  int doclist_index=0;

  bool isFileExits = true;

  final  nameT = TextEditingController();
  final  parentNameT = TextEditingController();
  final  familyIdT = TextEditingController();
  final  address1T = TextEditingController();
  final  address2T = TextEditingController();
  final  mobileNoT = TextEditingController();
  final  pincodeT = TextEditingController();
  final documentDecT = TextEditingController();

  List<DropDownModal> propertyList = [
    DropDownModal(id: '1', title: 'Property', titleKn: ''),
  ];

  List<DropDownModal> entertainment_list = [
    DropDownModal(id: '1', title: 'Plays', titleKn: ''),
    DropDownModal(id: '2', title: 'Games', titleKn: ''),
    DropDownModal(id: '3', title: 'Circus', titleKn: ''),
    DropDownModal(id: '4', title: 'Street Plays', titleKn: ''),
    DropDownModal(id: '5', title: 'Others', titleKn: ''),
  ];

  List<DropDownModal> docTypeList = [
    DropDownModal(id: '1', title: 'Dist1', titleKn: '1'),
    DropDownModal(id: '2', title: 'Dist2', titleKn: '2'),
    DropDownModal(id: '3', title: 'Dist3', titleKn: '3'),
    DropDownModal(id: '4', title: 'Dist4', titleKn: '4'),
    DropDownModal(id: '5', title: 'Dist5', titleKn: '5')
  ];
  List<String> multiple_programme=[];

  String selectedProperty='', entertainment_select='';
  String selectedDistId='';
  String selectedTalukaId='';
  String selectedPanchayatId='';
  String selectedVillageId='';
  String applicationId = '';
  String entmtPlace = '';
  String fileName = '';
  String filePath = '';
  String selected_place='';
  String enmt_prog_conducted = '';
  String docTypeSelect = '';

  EntmtLicenseModel? licenseModel;
  List<MstAppDocumentModel> docList = [];

  @override
  void initState() {
    super.initState();

    if (widget.applicationId.isNotEmpty && widget.applicationId != '0') {
      fetchApplicationData(widget.applicationId);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: globals.isTrainingMode ? testModePrimaryColor : primaryColor,
          title: Text(entertainment_title),
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
                          showMessageToast('Application Draft Successfully Training Mode');
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
        content: entertainmentProgrammeWidget(),
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
                  getTranslated(context, 'Entertainmentlicense',
                      'applicant_details').toUpperCase(),
                  style: whiteBoldText16,
                ),
              ),
            ),
          ),
         EmptyWidget(),
          Text(
            getTranslated(context, 'Entertainmentlicense', 'applicant_name'),
            style: graypreviewText13,
          ),
          Text(
            nameT.text,
            style: grayBoldText16,
          ),
          Divider(
              thickness: 1
          ),
          Text(
            getTranslated(context, 'Entertainmentlicense', 'parent_nm'),
            style: graypreviewText13,
          ),
          Text(
            parentNameT.text,
            style: grayBoldText16,
          ),
          Divider(
              thickness: 1
          ),
          Text(
            getTranslated(context, 'Entertainmentlicense', 'family_id'),
            style: graypreviewText13,
          ),
          Text(
            familyIdT.text,
            style: grayBoldText16,
          ),
          Divider(
              thickness: 1
          ),
          Text(
            getTranslated(context, 'Entertainmentlicense', 'address_line_1'),
            style: graypreviewText13,
          ),
          Text(
            address1T.text,
            style: grayBoldText16,
          ),
          Divider(
              thickness: 1
          ),
          Text(
            getTranslated(context, 'Entertainmentlicense', 'address_line_1'),
            style: graypreviewText13,
          ),
          Text(
            address2T.text,
            style: grayBoldText16,
          ),
          Divider(
              thickness: 1
          ),
          Text(
            getTranslated(context, 'Entertainmentlicense', 'mobile_number'),
            style: graypreviewText13,
          ),
          Text(
            mobileNoT.text,
            style: grayBoldText16,
          ),
          Divider(
              thickness: 1
          ),
          Text(
            getTranslated(context, 'Entertainmentlicense', 'pincode'),
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
                    bottomLeft: Radius.circular(30))),
            elevation: 0,
            child: Padding(
              padding: EdgeInsets.all(7.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  getTranslated(context, 'Entertainmentlicense',
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
          Divider(
              thickness: 1
          ),
          Text(
            getTranslated(context, 'Building_License',
                'taluka'),
            style: graypreviewText13,
          ),
          Text(
            selectedTalukaId,
            style: grayBoldText16,
          ),
          Divider(
              thickness: 1
          ),
          Text(
            getTranslated(context, 'Building_License',
                'panchayat'),
            style: graypreviewText13,
          ),
          Text(
            selectedPanchayatId,
            style: grayBoldText16,
          ),
          Divider(
              thickness: 1
          ),
          Text(
            getTranslated(context, 'Building_License','village'),
            style: graypreviewText13,
          ),
          Text(
            selectedVillageId,
            style: grayBoldText16,
          ),
          Divider(
              thickness: 1
          ),
          Text(
            getTranslated(context, 'Entertainmentlicense', 'property'),
            style: graypreviewText13,
          ),
          Text(
            selectedProperty,
            style: grayBoldText16,
          ),

        ],
      ),
    );
  }

  Widget entertainmentProgrammeWidget() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            color: primaryColor,
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
                  getTranslated(context, 'Entertainmentlicense',
                      'entertainment_programme').toUpperCase(),
                  style: whiteBoldText16,
                ),
              ),
            ),
          ),
          EmptyWidget(),
          Text(
            getTranslated(
                context, 'Entertainmentlicense', 'entertainment_place'),
            style: graypreviewText13,
          ),
          Text(
            selected_place,
            style: grayBoldText16,
          ),
          Divider(
              thickness: 1
          ),
          Text(
            getTranslated(
                context, 'Entertainmentlicense', 'entertainment_type'),
            style: graypreviewText13,
          ),
          Text(
            entertainment_select,
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
                    bottomLeft: Radius.circular(30))),
            elevation: 0,
            child: Padding(
              padding: EdgeInsets.all(7.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  getTranslated(context, 'Entertainmentlicense',
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
              // height: docList.length>0 ? 150 :0,
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
          /*Divider(),
          Text(
            doc_ty,
            style: graypreviewText13,
          ),
          Text(
            docTypeSelect,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              Padding(
              padding:EdgeInsets.all(10),
              child:
                  TextButton.icon(
                    style: TextButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(50.0),
                      ),
                    ),
                    onPressed: () {
                      if (filePath.isNotEmpty) {
                        print('filepath'+filePath);
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
                      size: 25,
                      color: whiteColor,
                    ),
                    label: Text(' View ',
                        style: whiteBoldText14,
                        overflow: TextOverflow.ellipsis),
                  ),
              ),
                  Expanded(
                    child:Text(fileName,
                      style: blackNormalText14,
                      maxLines: null,),
                  ),
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

      licenseModel = new EntmtLicenseModel(
          applicantDetailsModel:
          jsonData.containsKey('1') && jsonData["1"] != null
              ? EntmtLicenseApplicantDetailsModel.fromJson(jsonData["1"])
              : null,
          propertyDetailsModel:
          jsonData.containsKey('2') && jsonData["2"] != null
              ? EntmtLicensePropertyDetailsModel.fromJson(jsonData["2"])
              : null,
          programDetailsModel:
          jsonData.containsKey('3') && jsonData["3"] != null
              ? EntmtLicenseProgramDetailsModel.fromJson(jsonData["3"])
              : null,
          entertainmentDocumentModel:
          jsonData.containsKey('4') && jsonData["4"] != null
              ? EntmtLicenseDocumentDetailsModel.fromJson(jsonData["4"])
              : null);

      if (licenseModel!.applicantDetailsModel != null) {
        nameT.text = licenseModel!.applicantDetailsModel!.appl_org_name;
        familyIdT.text = licenseModel!.applicantDetailsModel!.familty_id;
        parentNameT.text =
            licenseModel!.applicantDetailsModel!.parent_spouse_name;
        address1T.text = licenseModel!.applicantDetailsModel!.add_line_1;
        address2T.text = licenseModel!.applicantDetailsModel!.add_line_2;
        mobileNoT.text = licenseModel!.applicantDetailsModel!.mobile_no;
        pincodeT.text = licenseModel!.applicantDetailsModel!.pin_code;
      }

      if (licenseModel!.propertyDetailsModel != null) {
        selectedDistId = licenseModel!.propertyDetailsModel!.district_id;
        selectedTalukaId = licenseModel!.propertyDetailsModel!.taluka_id;
        selectedPanchayatId = licenseModel!.propertyDetailsModel!.gram_id;
        selectedVillageId = licenseModel!.propertyDetailsModel!.village_id;
        selectedProperty = licenseModel!.propertyDetailsModel!.property_id;

        selectedDistId = await DatabaseOperation.instance.getDistrictName(selectedDistId);
        selectedTalukaId = await DatabaseOperation.instance.getTalukaName(selectedTalukaId);
        selectedPanchayatId = await DatabaseOperation.instance.getPanchayatName(selectedPanchayatId);
        selectedVillageId = await DatabaseOperation.instance.getVillageName(selectedVillageId);
      }

      if (licenseModel!.programDetailsModel != null) {
        enmt_prog_conducted= licenseModel!.programDetailsModel!.ent_prog_conducted;
        entertainment_select= await DatabaseOperation.instance.getDropdownName("getMstEntertProgTypeData",  licenseModel!.programDetailsModel!.ent_prog_type_id);

        if(enmt_prog_conducted.contains('#'))
        {

          for (var i = 0; i < 2; i += 1)
          {
            if(selected_place.toString().isNotEmpty)
            {
              selected_place=selected_place + ' , '+place_option[i];
            }
            else
            {
              selected_place=place_option[i];
            }
          }

        }
        else
        {
          enmt_prog_conducted=='1' ? selected_place=place_option[0] : selected_place=place_option[1];
        }
      }
     /* if (licenseModel!.entertainmentDocumentModel != null) {
        filePath = licenseModel!.entertainmentDocumentModel!.doc_id;
        print('filepath' + filePath);
        var fname = licenseModel!.entertainmentDocumentModel!.doc_id.split(
            "/");
        fileName = fname[fname.length - 1];

        bool fileE = await new File(filePath).exists();
        if (!fileE) {
          isFileExits = false;
        }
        docTypeSelect = await DatabaseOperation.instance.getDropdownName("getMstDocData", licenseModel!.entertainmentDocumentModel!.doc_type);

        documentDecT.text = licenseModel!.entertainmentDocumentModel!.doc_desc;
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
