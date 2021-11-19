import 'dart:convert';

import 'package:citizen_service/Model/DropDownModel.dart';
import 'package:citizen_service/GlobalsVariable/GlobalsVariable.dart'
    as globals;
import 'package:citizen_service/Model/VillageSanitationModel/VillageSanitationApplication.dart';
import 'package:citizen_service/Model/VillageSanitationModel/VillageSanitationModel.dart';
import 'package:citizen_service/SqliteDatabase/Database.dart';
import 'package:citizen_service/Utility/Color.dart';
import 'package:citizen_service/Utility/EmptyWidget.dart';
import 'package:citizen_service/Utility/String.dart';
import 'package:citizen_service/Utility/Style.dart';
import 'package:citizen_service/Utility/Utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewVillageSanitation extends StatefulWidget {
  final String categoryId, serviceId, title, applicationId;

  ViewVillageSanitation(
      {Key? key,
      required this.title,
      required this.categoryId,
      required this.serviceId,
      required this.applicationId})
      : super(key: key);

  @override
  _ViewVillageSanitationState createState() => _ViewVillageSanitationState();
}

class _ViewVillageSanitationState extends State<ViewVillageSanitation> {
  final applicationName = TextEditingController();
  final mobileNumber = TextEditingController();
  final landmarkLocation = TextEditingController();
  final applicationNameFocusNode = FocusNode();
  final mobileNumberFocusNode = FocusNode();
  final landmarkLocationFocusNode = FocusNode();

  final formKeyApplicantDetails = GlobalKey<FormState>();
  final GlobalKey expansionTileKey1 = GlobalKey();

  List<DropDownModal> problemList = [];
  String problemSelect = '';

  String? selectedDistId;
  String? selectedTalukaId;
  String? selectedPanchayatId;
  String? selectedVillageId;
  String applicationId = '';



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
          title: Text(village_sanitation),
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
                                    bottomLeft: Radius.circular(30))),                            elevation: 3.0,
                            child: Padding(
                              padding: EdgeInsets.all(7.0),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  getTranslated(context, 'VillageSanitation',
                                      'applicant_details').toUpperCase(),
                                  style: whiteBoldText16,
                                ),
                              ),
                            ),
                          ),
                        ),
                        EmptyWidget(),
                        Text(
                          getTranslated(
                              context, 'VillageSanitation', 'applicant_name'),
                          style: graypreviewText13,
                        ),
                        Text(
                          applicationName.text,
                          style: grayBoldText16,
                        ),
                        Divider(thickness: 1),
                        Text(
                          getTranslated(
                              context, 'VillageSanitation', 'mobile_number'),
                          style: graypreviewText13,
                        ),
                        Text(
                          mobileNumber.text,
                          style: grayBoldText16,
                        ),
                        Divider(thickness: 1),
                        Text(
                          getTranslated(context, 'Building_License',
                              'district'),
                          style: graypreviewText13,
                        ),
                        Text(
                          selectedDistId ?? '',
                          style: grayBoldText16,
                        ),
                        Divider(thickness: 1),
                        Text(

                          getTranslated(context, 'Building_License',
                              'taluka'),
                          style: graypreviewText13,
                        ),
                        Text(
                          selectedTalukaId ?? '',
                          style: grayBoldText16,
                        ),
                        Divider(thickness: 1),
                        Text(
                          getTranslated(context, 'Building_License',
                              'panchayat'),
                          style: graypreviewText13,
                        ),
                        Text(
                          selectedPanchayatId ?? '',
                          style: grayBoldText16,
                        ),
                        Divider(thickness: 1),
                        Text(
                          getTranslated(context, 'Building_License',
                              'village'),
                          style: graypreviewText13,
                        ),
                        Text(
                          selectedVillageId ?? '',
                          style: grayBoldText16,
                        ),
                        Divider(thickness: 1),
                        Text(
                          getTranslated(
                              context, 'VillageSanitation', 'land_mark'),
                          style: graypreviewText13,
                        ),
                        Text(
                          landmarkLocation.text,
                          style: grayBoldText16,
                        ),
                        Divider(thickness: 1),
                        Text(
                          getTranslated(
                              context, 'VillageSanitation', 'problem_des'),
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
              )),
            ],
          ),
        ));
  }

  void fetchApplicationData(String applicationId) async {
    var model =
        await DatabaseOperation.instance.getApplicationUsingID(applicationId);
    if (model != null && model.aPPLICATIONDATA.isNotEmpty) {
      var jsonData = jsonDecode(model.aPPLICATIONDATA);
      VillageSanitationModel villageSanitationModel =
          new VillageSanitationModel(
              jsonData.containsKey('1') && jsonData["1"] != null
                  ? VillageSanitationApplication.fromJson(jsonData["1"])
                  : null);
      if (villageSanitationModel.villageSanitationApplication != null) {
        applicationName.text =
            villageSanitationModel.villageSanitationApplication!.applicant_name;
        mobileNumber.text =
            villageSanitationModel.villageSanitationApplication!.mob_no;
        selectedDistId = await DatabaseOperation.instance.getDistrictName(villageSanitationModel.villageSanitationApplication!.district_id);
        selectedTalukaId = await DatabaseOperation.instance.getTalukaName(villageSanitationModel.villageSanitationApplication!.taluka_id);
        selectedPanchayatId = await DatabaseOperation.instance.getPanchayatName(villageSanitationModel.villageSanitationApplication!.panchayat_id);
        selectedVillageId = await DatabaseOperation.instance.getVillageName(villageSanitationModel.villageSanitationApplication!.village_id);
        landmarkLocation.text = villageSanitationModel
            .villageSanitationApplication!.landmark_location;
        problemSelect = await DatabaseOperation.instance.getDropdownName("getMstProblemDetails", villageSanitationModel
            .villageSanitationApplication!.problem_description_id);

        setState(() {});
      }
    }
  }
}
