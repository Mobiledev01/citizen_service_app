import 'dart:convert';
import 'package:citizen_service/Model/DropDownModel.dart';
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

class ViewBusinessLicense extends StatefulWidget {
  final String title, categoryId, serviceId, applicationId;

  ViewBusinessLicense(
      {Key? key,
      required this.title,
      required this.categoryId,
      required this.serviceId,
      required this.applicationId})
      : super(key: key);

  @override
  _ViewBusinessLicense createState() => _ViewBusinessLicense();
}

class _ViewBusinessLicense extends State<ViewBusinessLicense> {
  int _currentStep = 0;
  int doclist_index=0;
  int val = -1,occupy_val=-1;
  StepperType stepperType = StepperType.horizontal;
  bool isFileExits = true;

  final applicantNameT = TextEditingController();
  final familyNameT = TextEditingController();
  final mobileNoT = TextEditingController();
  final familyIdT = TextEditingController();
  final addressLine1T = TextEditingController();
  final addressLine2T = TextEditingController();
  final localityT = TextEditingController();
  final picodeT = TextEditingController();
  final tradeNameT = TextEditingController();
  final landAreaT = TextEditingController();
  final buildingAreaT = TextEditingController();
  final documentDecT = TextEditingController();

   List<DropDownModal> docTypeList = [];
  List<MstAppDocumentModel> docList = [];

  String selectedDistId='';
  String selectedTalukaId='';
  String selectedPanchayatId='';
  String selectedVillageId='';
  String selected_service_type='';
  String fileName = '';
  String filePath = '';
  String applicationId = '';
  String occupancy_selected = '';
  String serviceSelect='';
  String docTypeSelect = '';
  String occupancy_selected_label = '';

  TradeLicenseModel? licenseModel;

  @override
  void initState() {
    super.initState();

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
          backgroundColor: globals.isTrainingMode ? testModePrimaryColor : primaryColor,
          title: Text(trade_license),
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
       //   state: StepState.complete,
          isActive: _currentStep >= 0,
          content: applicantDetailsWidget()),
      Step(
        title: new Text('', style: formTitle),
        content: propertyDetailsWidget(),
        isActive: _currentStep >= 1,
       // state: StepState.complete,
      ),
      Step(
        isActive: _currentStep >= 2,
        title: new Text('', style: formTitle),
        content: licenseDetailsWidget(),
     //   state: StepState.complete,
      ),
      Step(
        title: new Text('', style: formTitle),
        content: uploadDocumentWidget(),
        isActive: _currentStep >= 3,
      //  state: StepState.complete,
      ),
    ];
  }

  Widget applicantDetailsWidget() {
    if(occupy_val==1)
    {
      occupancy_selected_label='Self';
    }
    else if(occupy_val==2)
    {
      occupancy_selected_label='Rented';
    }
    else if(occupy_val==3)
    {
      occupancy_selected_label='Government';
    }
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
                  getTranslated(
                      context, 'BusinessLicense', 'applicant_details').toUpperCase(),
                  style: whiteBoldText16,
                ),
              ),
            ),
          ),
          EmptyWidget(),
          Text(
            occupancy_detail,
            style: graypreviewText13,
          ),
          Text(
            occupancy_selected_label,
            style: grayBoldText16,
          ),
          Divider(
              thickness: 1
          ),
          Text(
            getTranslated(
                context, 'BusinessLicense', 'applicant_org_name'),
            style: graypreviewText13,
          ),
          Text(
            applicantNameT.text,
            style: grayBoldText16,
          ),
          Divider(
              thickness: 1
          ),
          Text(
              getTranslated(
                  context, 'BusinessLicense', 'family_name'),
            style: graypreviewText13,
          ),
          Text(
            familyNameT.text,
            style: grayBoldText16,
          ),
          Divider(
              thickness: 1
          ),
          Text(
            getTranslated(
                context, 'BusinessLicense', 'mobile_number'),
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
            getTranslated(
                context, 'BusinessLicense', 'family_id'),
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
            getTranslated(
                context, 'BusinessLicense', 'address_line_1'),
            style: graypreviewText13,
          ),
          Text(
            addressLine1T.text,
            style: grayBoldText16,
          ),
          Divider(
              thickness: 1
          ),
          Text(
            getTranslated(
                context, 'BusinessLicense', 'address_line_2'),
            style: graypreviewText13,
          ),
          Text(
            addressLine2T.text,
            style: grayBoldText16,
          ),
          Divider(
              thickness: 1
          ),
          Text(
            getTranslated(
                context, 'BusinessLicense', 'pincode'),
            style: graypreviewText13,
          ),
          Text(
            picodeT.text,
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
                  getTranslated(
                      context, 'BusinessLicense', 'property_village_details').toUpperCase(),
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

  Widget licenseDetailsWidget() {
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
                      context, 'BusinessLicense', 'license_details').toUpperCase(),
                  style: whiteBoldText16,
                ),
              ),
            ),
          ),
          EmptyWidget(),
          Text(
            getTranslated(
                context, 'BusinessLicense', 'type'),
            style: graypreviewText13,
          ),
          Text(
            selected_service_type,
            style: grayBoldText16,
          ),
          Divider(
              thickness: 1
          ),
          Text(
            getTranslated(
                context, 'BusinessLicense', 'sub_service'),
            style: graypreviewText13,
          ),
          Text(
            serviceSelect,
            style: grayBoldText16,
          ),
          Divider(
              thickness: 1
          ),
          Text(
            getTranslated(
                context, 'BusinessLicense', 'trade_name'),
            style: graypreviewText13,
          ),
          Text(
            tradeNameT.text,
            style: grayBoldText16,
          ),
          Divider(
              thickness: 1
          ),
          Text(
            getTranslated(
                context, 'BusinessLicense', 'land_area'),
            style: graypreviewText13,
          ),
          Text(
            landAreaT.text+" Sq mt",
            style: grayBoldText16,
          ),
          Divider(
              thickness: 1
          ),
          Text(
            getTranslated(
                context, 'BusinessLicense', 'building_area'),
            style: graypreviewText13,
          ),
          Text(
            buildingAreaT.text+" Sq mt",
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
                      context, 'BusinessLicense', 'upload_document_details').toUpperCase(),
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

          /*  Divider(),
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

      licenseModel = new TradeLicenseModel(
          applicantDetailsModel:
          jsonData.containsKey('1') && jsonData["1"] != null
              ? TradeLicenseApplicantDetailsModel.fromJson(jsonData["1"])
              : null,
          propertyDetailsModel:
          jsonData.containsKey('2') && jsonData["2"] != null
              ? TradeLicensePropertyDetailsModel.fromJson(jsonData["2"])
              : null,
          tradeLicenseTypeAppModel:
          jsonData.containsKey('3') && jsonData["3"] != null
              ? TradeLicenseTypeAppModel.fromJson(jsonData["3"])
              : null,
          tradeLicenseDocumentDetailsModel:
          jsonData.containsKey('4') && jsonData["4"] != null
              ? TradeLicenseDocumentDetailsModel.fromJson(jsonData["4"])
              : null);

      if (licenseModel!.applicantDetailsModel != null) {
        applicantNameT.text =licenseModel!.applicantDetailsModel!.applicant_name;
        familyIdT.text = licenseModel!.applicantDetailsModel!.family_id;
        familyNameT.text =
            licenseModel!.applicantDetailsModel!.family_spouse_name;
        addressLine1T.text = licenseModel!.applicantDetailsModel!.address_line1;
        addressLine2T.text = licenseModel!.applicantDetailsModel!.address_line2;
        mobileNoT.text = licenseModel!.applicantDetailsModel!.mob_no;
        picodeT.text = licenseModel!.applicantDetailsModel!.pin_code;
        occupy_val= int.parse(licenseModel!.applicantDetailsModel!.occupancy_dtl);
      }
      if (licenseModel!.propertyDetailsModel != null) {
        selectedDistId = licenseModel!.propertyDetailsModel!.district_id;
        selectedTalukaId = licenseModel!.propertyDetailsModel!.tp_id;
        selectedPanchayatId = licenseModel!.propertyDetailsModel!.gp_id;
        selectedVillageId = licenseModel!.propertyDetailsModel!.village_id;

        selectedDistId = await DatabaseOperation.instance.getDistrictName(selectedDistId);
        selectedTalukaId = await DatabaseOperation.instance.getTalukaName(selectedTalukaId);
        selectedPanchayatId = await DatabaseOperation.instance.getPanchayatName(selectedPanchayatId);
        selectedVillageId = await DatabaseOperation.instance.getVillageName(selectedVillageId);

      }

      if (licenseModel!.tradeLicenseTypeAppModel != null) {

        selected_service_type = await DatabaseOperation.instance.getDropdownName("getMSTTradeTypeData", licenseModel!.tradeLicenseTypeAppModel!.lic_service_type_id);
        serviceSelect=  await DatabaseOperation.instance.getDropdownName("getMSTTradeSubTypeData",  licenseModel!.tradeLicenseTypeAppModel!.sub_service_type);
        tradeNameT.text=licenseModel!.tradeLicenseTypeAppModel!.trade_name;
        landAreaT.text=licenseModel!.tradeLicenseTypeAppModel!.land_area_sq_meet;
        buildingAreaT.text=licenseModel!.tradeLicenseTypeAppModel!.building_area_sq_meet;
      }
   /*   if (licenseModel!.tradeLicenseDocumentDetailsModel != null) {
        filePath = licenseModel!.tradeLicenseDocumentDetailsModel!.doc_id;
        print('filepath'+filePath);
        var fname = licenseModel!.tradeLicenseDocumentDetailsModel!.doc_id.split(
            "/");
        fileName = fname[fname.length - 1];

        bool fileE = await new File(filePath).exists();
        if (!fileE) {
          isFileExits = false;
        }
       docTypeSelect = await DatabaseOperation.instance.getDropdownName("getMstDocData",licenseModel!.tradeLicenseDocumentDetailsModel!.doc_type_id);
       documentDecT.text=licenseModel!.tradeLicenseDocumentDetailsModel!.doc_description;

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
