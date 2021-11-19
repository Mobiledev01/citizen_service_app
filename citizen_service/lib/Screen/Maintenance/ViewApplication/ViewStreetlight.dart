import 'dart:convert';

import 'package:citizen_service/Model/DropDownModel.dart';
import 'package:citizen_service/Model/MstAddApplicationModel.dart';
import 'package:citizen_service/Model/StreetLightModel/StreetLightApplication.dart';
import 'package:citizen_service/Model/StreetLightModel/StreetLightModel.dart';
import 'package:citizen_service/SqliteDatabase/Database.dart';
import 'package:citizen_service/Utility/Color.dart';
import 'package:citizen_service/Utility/EmptyWidget.dart';
import 'package:citizen_service/Utility/String.dart';
import 'package:citizen_service/Utility/Style.dart';
import 'package:citizen_service/Utility/Utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:citizen_service/GlobalsVariable/GlobalsVariable.dart'
    as globals;

class ViewStreetLight extends StatefulWidget {
  final String categoryId, serviceId, title, applicationId;

  const ViewStreetLight(
      {Key? key,
      required this.title,
      required this.categoryId,
      required this.serviceId,
      required this.applicationId})
      : super(key: key);

  @override
  _ViewStreetLightState createState() => _ViewStreetLightState();
}

class _ViewStreetLightState extends State<ViewStreetLight> {
  final applicationName = TextEditingController();
  final mobileNumber = TextEditingController();
  final landmarkLocation = TextEditingController();

  List<DropDownModal> problemList = [];
  String problemSelect = '';
  String applicationId = '';
  String? selectedDistId;
  String? selectedTalukaId;
  String? selectedPanchayatId;
  String? selectedVillageId;

  bool isFileExits = true;

  @override
  void initState() {
    super.initState();

    if (widget.applicationId.isNotEmpty && widget.applicationId != '0') {
      setState(() {
        applicationId = widget.applicationId;
      });
      fetchApplicationData(applicationId);
    }
    problemList.add(new DropDownModal(
        title: 'problemList 1', titleKn: 'problemList 1', id: '1'));
    problemList.add(new DropDownModal(
        title: 'problemList 2', titleKn: 'problemList 2', id: '2'));
    problemList.add(new DropDownModal(
        title: 'problemList 3', titleKn: 'problemList 3', id: '3'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor:
              globals.isTrainingMode ? testModePrimaryColor : primaryColor,
          title: Text(street_light),
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
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 8, 15, 0),
                  child: Container(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              color: primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(30),
                                      bottomLeft: Radius.circular(30))),                              elevation: 3.0,
                              child: Padding(
                                padding: EdgeInsets.all(7.0),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    getTranslated(context, 'Streetlight',
                                            'applicant_details')
                                        .toUpperCase(),
                                    style: whiteBoldText16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          EmptyWidget(),
                          Text(
                            getTranslated(
                                context, 'Streetlight', 'applicant_name'),
                            style: graypreviewText13,
                          ),
                          Text(
                            applicationName.text,
                            style: grayBoldText16,
                          ),
                          Divider(thickness: 1),
                          Text(
                            getTranslated(
                                context, 'Streetlight', 'mobile_number'),
                            style: graypreviewText13,
                          ),
                          Text(
                            mobileNumber.text,
                            style: grayBoldText16,
                          ),
                          Divider(thickness: 1),
                          Text(
                            getTranslated(
                                context, 'Building_License', 'district'),
                            style: graypreviewText13,
                          ),
                          Text(
                            selectedDistId ?? '',
                            style: grayBoldText16,
                          ),
                          Divider(thickness: 1),
                          Text(
                            getTranslated(
                                context, 'Building_License', 'taluka'),
                            style: graypreviewText13,
                          ),
                          Text(
                            selectedTalukaId ?? '',
                            style: grayBoldText16,
                          ),
                          Divider(thickness: 1),
                          Text(
                            getTranslated(
                                context, 'Building_License', 'panchayat'),
                            style: graypreviewText13,
                          ),
                          Text(
                            selectedPanchayatId ?? '',
                            style: grayBoldText16,
                          ),
                          Divider(thickness: 1),
                          Text(
                            getTranslated(
                                context, 'Building_License', 'village'),
                            style: graypreviewText13,
                          ),
                          Text(
                            selectedVillageId ?? '',
                            style: grayBoldText16,
                          ),
                          Divider(thickness: 1),
                          Text(
                            getTranslated(context, 'Streetlight', 'land_mark'),
                            style: graypreviewText13,
                          ),
                          Text(
                            landmarkLocation.text,
                            style: grayBoldText16,
                          ),
                          Divider(thickness: 1),
                          Text(
                            getTranslated(
                                context, 'Streetlight', 'problem_des'),
                            style: graypreviewText13,
                          ),
                          Text(
                            problemSelect,
                            style: grayBoldText16,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )),
            ],
          ),
        ));
  }

  void fetchApplicationData(String applicationId) async {
    MstAddApplicationModel? model =
        await DatabaseOperation.instance.getApplicationUsingID(applicationId);
    if (model != null && model.aPPLICATIONDATA.isNotEmpty) {
      var jsonData = jsonDecode(model.aPPLICATIONDATA);
      StreetLightModel Model = new StreetLightModel(
          jsonData.containsKey('1') && jsonData["1"] != null
              ? StreetLightApplication.fromJson(jsonData["1"])
              : null);
      if (Model.streetLightApplication != null) {
        applicationName.text = Model.streetLightApplication!.applicant_name;
        mobileNumber.text = Model.streetLightApplication!.mob_no;
        selectedDistId = await DatabaseOperation.instance
            .getDistrictName(Model.streetLightApplication!.district_id);
        selectedTalukaId = await DatabaseOperation.instance
            .getTalukaName(Model.streetLightApplication!.taluka_id);
        selectedPanchayatId = await DatabaseOperation.instance
            .getPanchayatName(Model.streetLightApplication!.panchayat_id);
        selectedVillageId = await DatabaseOperation.instance
            .getVillageName(Model.streetLightApplication!.village_id);
        landmarkLocation.text = Model.streetLightApplication!.landmark_location;
        problemSelect = await DatabaseOperation.instance.getDropdownName(
            "getMstProblemDetails",
            Model.streetLightApplication!.problem_description_id);
        setState(() {});
      }
    }
  }
}
