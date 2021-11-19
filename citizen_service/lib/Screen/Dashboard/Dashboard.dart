import 'dart:async';
import 'dart:convert';

import 'package:citizen_service/HttpCalls/HttpCall.dart';
import 'package:citizen_service/Model/AdvtLicenseModel/AdvtLicenseAdvertiseDetailsModel.dart';
import 'package:citizen_service/Model/AdvtLicenseModel/AdvtLicenseApplicantDetailsModel.dart';
import 'package:citizen_service/Model/AdvtLicenseModel/AdvtLicenseModel.dart';
import 'package:citizen_service/Model/AdvtLicenseModel/AdvtLicensePropertyDetailsModel.dart';
import 'package:citizen_service/Model/BuildingLicenseModel/BuildingLicenseApplicantDetailsModel.dart';
import 'package:citizen_service/Model/BuildingLicenseModel/BuildingLicenseBuildingDetailsModel.dart';
import 'package:citizen_service/Model/BuildingLicenseModel/BuildingLicenseModel.dart';
import 'package:citizen_service/Model/BuildingLicenseModel/BuildingLicensePropertyDetailsModel.dart';
import 'package:citizen_service/Model/DCWaterConnectionModel/DCWaterConnectionApplicantDetailsModel.dart';
import 'package:citizen_service/Model/DCWaterConnectionModel/DCWaterConnectionModel.dart';
import 'package:citizen_service/Model/DCWaterConnectionModel/DCWaterConnectionPropertyDetailsModel.dart';
import 'package:citizen_service/Model/DrinkingWater/DrinkingWaterApplication.dart';
import 'package:citizen_service/Model/DrinkingWater/DrinkingWaterModel.dart';
import 'package:citizen_service/Model/EntertainmentLicenseModel/EntmtLicenseApplicantDetailsModel.dart';
import 'package:citizen_service/Model/EntertainmentLicenseModel/EntmtLicenseModel.dart';
import 'package:citizen_service/Model/EntertainmentLicenseModel/EntmtLicenseProgramDetailsModel.dart';
import 'package:citizen_service/Model/EntertainmentLicenseModel/EntmtLicensePropertyDetailsModel.dart';
import 'package:citizen_service/Model/FactoryClearanceModel/FactoryPerApplicantDetailsModel.dart';
import 'package:citizen_service/Model/FactoryClearanceModel/FactoryPerBuildingModel.dart';
import 'package:citizen_service/Model/FactoryClearanceModel/FactoryPerModel.dart';
import 'package:citizen_service/Model/FactoryClearanceModel/FactoryPerPropertyDetailsModel.dart';
import 'package:citizen_service/Model/MstAddApplicationModel.dart';
import 'package:citizen_service/Model/NewWaterConnectionModel/NewWaterConnectionApplicantDetailsModel.dart';
import 'package:citizen_service/Model/NewWaterConnectionModel/NewWaterConnectionModel.dart';
import 'package:citizen_service/Model/NewWaterConnectionModel/NewWaterConnectionPropertyDetailsModel.dart';
import 'package:citizen_service/Model/NewWaterConnectionModel/NewWaterConnectionWaterConnectionModel.dart';
import 'package:citizen_service/Model/NocEscoms/NocEscomsApplicant.dart';
import 'package:citizen_service/Model/NocEscoms/NocEscomsModel.dart';
import 'package:citizen_service/Model/NocEscoms/NocEscomsProperty.dart';
import 'package:citizen_service/Model/OccupancyCertificateModel/OccupancyCertificateApplicantDetailModel.dart';
import 'package:citizen_service/Model/OccupancyCertificateModel/OccupancyCertificateLicenseDetail.dart';
import 'package:citizen_service/Model/OccupancyCertificateModel/OccupancyCertificateModel.dart';
import 'package:citizen_service/Model/OccupancyCertificateModel/OccupancyCertificatePropertyDetail.dart';
import 'package:citizen_service/Model/RoadCuttingPermissionModel/RoadCuttingApplicantDetailsModel.dart';
import 'package:citizen_service/Model/RoadCuttingPermissionModel/RoadCuttingModel.dart';
import 'package:citizen_service/Model/RoadCuttingPermissionModel/RoadCuttingPropertyDetailsModel.dart';
import 'package:citizen_service/Model/RoadCuttingPermissionModel/RoadCuttingWorkModel.dart';
import 'package:citizen_service/Model/StreetLightModel/StreetLightApplication.dart';
import 'package:citizen_service/Model/StreetLightModel/StreetLightModel.dart';
import 'package:citizen_service/Model/VillageSanitationModel/VillageSanitationApplication.dart';
import 'package:citizen_service/Model/VillageSanitationModel/VillageSanitationModel.dart';
import 'package:citizen_service/Screen/BuildingScreen/BuildingLicenseScreen.dart';
import 'package:citizen_service/Screen/BuildingScreen/DisWaterConnection.dart';
import 'package:citizen_service/Screen/BuildingScreen/OccupancyCertificate.dart';
import 'package:citizen_service/Screen/BuildingScreen/ViewApplication/ViewBuildingLicenseScreen.dart';
import 'package:citizen_service/Screen/BuildingScreen/ViewApplication/ViewDisconnectingWaterConnection.dart';
import 'package:citizen_service/Screen/BuildingScreen/ViewApplication/ViewOccupancyCertificate.dart';
import 'package:citizen_service/Screen/BuildingScreen/ViewApplication/ViewWaterConnection.dart';
import 'package:citizen_service/Screen/BuildingScreen/WaterConnection.dart';
import 'package:citizen_service/Screen/DownloadMasterScreen/DownloadMasterScreen.dart';
import 'package:citizen_service/Screen/Maintenance/DrinkingWater.dart';
import 'package:citizen_service/Screen/Maintenance/Streetlight.dart';
import 'package:citizen_service/Screen/Maintenance/ViewApplication/ViewDrinkingWater.dart';
import 'package:citizen_service/Screen/Maintenance/ViewApplication/ViewStreetlight.dart';
import 'package:citizen_service/Screen/Maintenance/ViewApplication/ViewVillageSanitation.dart';
import 'package:citizen_service/Screen/Maintenance/VillageSanitation.dart';
import 'package:citizen_service/Screen/OtherScreen/Entertainmentlicense.dart';
import 'package:citizen_service/Screen/OtherScreen/IssuanceOfNocEscoms.dart';
import 'package:citizen_service/Screen/OtherScreen/RoadCuttingPermission.dart';
import 'package:citizen_service/Screen/OtherScreen/ViewApplication/ViewEntertainmentLicense.dart';
import 'package:citizen_service/Screen/OtherScreen/ViewApplication/ViewIssuanceOfRecords.dart';
import 'package:citizen_service/Screen/OtherScreen/ViewApplication/ViewNocEscoms.dart';
import 'package:citizen_service/Screen/OtherScreen/ViewApplication/ViewRoadCuttingPermission.dart';
import 'package:citizen_service/Screen/SyncScreen/SyncScreen.dart';
import 'package:citizen_service/Screen/TradeScreen/AdvertisementLicense.dart';
import 'package:citizen_service/Screen/TradeScreen/BusinessLicense.dart';
import 'package:citizen_service/Screen/TradeScreen/FactoryClearance.dart';
import 'package:citizen_service/Screen/TradeScreen/ViewApplication/ViewAdvtLicense.dart';
import 'package:citizen_service/Screen/TradeScreen/ViewApplication/ViewBusinessLicense.dart';
import 'package:citizen_service/Screen/TradeScreen/ViewApplication/ViewFactoryClearance.dart';
import 'package:citizen_service/SqliteDatabase/Database.dart';
import 'package:citizen_service/Utility/Color.dart';
import 'package:citizen_service/Utility/String.dart';
import 'package:citizen_service/Utility/Style.dart';
import 'package:citizen_service/Utility/Utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:citizen_service/GlobalsVariable/GlobalsVariable.dart' as globals;

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with TickerProviderStateMixin {

  AnimationController? animationController;
  String lable = 'Home';
  List<MstAddApplicationModel> applicationList = [];
  int selectedIndex = 0;
  List<String> _chipsList = ["All","Building","Trade","Others","Maintenance"];

  double valueIndicator = 0.0;
  int totalSyncApp = 0;
  int totalUnSyncApp = 0;
  bool indicatorShow = false;
  bool flag = false;
  bool success = false;

  @override
  initState() {
    animationController = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();

    checkDownloadAllMasters();
    getAllApplication();
  }

  @override
  dispose() {
    animationController!.dispose();
    super.dispose();
  }

  void choiceAction(String choice) {
    if (choice == Constants.download) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DownloadMasterScreen()));
    } else if (choice == Constants.upload) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SyncScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: 50),
          child: Text(
            getTranslated(context, 'DrawerMenu', lable),
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor:
            globals.isTrainingMode ? testModePrimaryColor : primaryColor,
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications_active_outlined,
              color: Colors.white,
              size: 25,
            ),
            onPressed: () {
              showMessageToast('Notification...');
            },
          ),
          PopupMenuButton<String>(
            onSelected: choiceAction,
            // color: primaryColor,
            itemBuilder: (BuildContext context) {
              return Constants.choices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(choice),
                      Icon(
                        choice.contains('Download')
                            ? Icons.cloud_download_outlined
                            : Icons.cloud_upload_outlined,
                        color: blackColor,
                      )
                    ],
                  ),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Container(
          child:
          Column(
            children: [
              Wrap(
                spacing: 1,
                direction: Axis.horizontal,
                children: techChips(),
              ),
              applicationList.isEmpty
                  ? Center(
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(8,60,8,8),
                      child: Text(no_records_found,style: grayNormalText16,)))
              : Expanded(
                child: Padding(
                    padding: EdgeInsets.all(8),
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        primary: true,
                        itemCount: applicationList.length,
                        itemBuilder: (BuildContext context, int index) {
                          final int count = applicationList.length > 10
                              ? 10
                              : applicationList.length;
                          final Animation<double> animation =
                          Tween<double>(begin: 0.0, end: 1.0).animate(
                            CurvedAnimation(
                              parent: animationController!,
                              curve: Interval((1 / count) * index, 1.0,
                                  curve: Curves.fastOutSlowIn),
                            ),
                          );
                          animationController?.forward();
                          return AnimatedBuilder(
                              animation: animationController!,
                              builder: (BuildContext context, Widget? child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: Transform(
                                    transform: Matrix4.translationValues(
                                        100 * (1.0 - animation.value), 0.0, 0.0),
                                    child: Card(
                                      elevation: 12,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                      child: SingleChildScrollView(
                                        child: Stack(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(8),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.fromLTRB(0,0,20,0),
                                                    child: Text(
                                                      applicationList[index].service_name,
                                                      style: dashboardLabelStyle,
                                                    ),
                                                  ),
                                                  Text(
                                                    applicationList[index].gENERATEDAPPLICATIONID.isEmpty ? applicationList[index].draft_id.isNotEmpty
                                                        ? "REF ID : " + applicationList[index].draft_id.toString() : "#" +
                                                        applicationList[index].id.toString() : "REF ID : " + applicationList[index].gENERATEDAPPLICATIONID,
                                                    style: formLabel,
                                                  ),
                                                  // Text(
                                                  //     getDateUsingForDate(applicationList[index].aPPLICATIONAPPLYDATE, 'dd/MM/yyyy', 'EEE dd MMM yyyy'),
                                                  //     style: formLabel),
                                                  // Text(
                                                  //   servieceType + applicationList[index].aPPLICATIONNAME,
                                                  //   style: formLabel,
                                                  // ),
                                                  Text(
                                                    getDateUsingForDate(applicationList[index].crt_date, 'dd/MM/yyyy', 'EEE dd MMM yyyy'),
                                                    style: formLabel,
                                                  ),
                                                  // Text(
                                                  //   'Step 3/5 : Field Verification',
                                                  //   style: formLabel,
                                                  // ),
                                                  // Text(
                                                  //   '21 days since process initiated',
                                                  //   style: grayBoldText16,
                                                  // ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          applicationList[index].sync_message.isNotEmpty
                                                              ? IconButton(
                                                            icon: Icon(
                                                              Icons.warning_amber_outlined,
                                                              size: 25,
                                                              color: redColor,
                                                            ),
                                                            tooltip:
                                                            'Error On Sync Application',
                                                            onPressed: () {
                                                              displayErrorMessageApplication(index);
                                                            },
                                                          ) : SizedBox(),
                                                          ( applicationList[index].aPPLICATIONDATA.isNotEmpty && applicationList[index].final_submit_flag != 'Y') || applicationList[index].sync_message.isNotEmpty ?
                                                          IconButton(
                                                            icon: Icon(
                                                              Icons.edit,
                                                              size: 25,
                                                              color: blackColor,
                                                            ),
                                                            tooltip:
                                                            'Edit Application',
                                                            onPressed: () {
                                                              navigationMenu(
                                                                  context,
                                                                  applicationList[index].cATEGORYID,
                                                                  applicationList[index].sERVICEID,
                                                                  applicationList[index].aPPLICATIONNAME,
                                                                  applicationList[index].id.toString(),
                                                                  applicationList[index].service_name);
                                                            },
                                                          )
                                                              : SizedBox(),
                                                          applicationList[index].final_submit_flag != 'Y' && applicationList[index].from_web != 'Y' && applicationList[index].sync_tab.isEmpty
                                                              ? IconButton(
                                                                  icon: Icon(
                                                                    Icons.delete_forever,
                                                                    size: 25,
                                                                    color: blackColor,
                                                                  ),
                                                                  tooltip:
                                                                  'Delete Application',
                                                                  onPressed: () {
                                                                    deleteApplication(index);
                                                                  },
                                                                )
                                                              : SizedBox(),
                                                          applicationList[index].final_submit_flag ==
                                                              'Y'
                                                              ? IconButton(
                                                            icon: Icon(
                                                              Icons.preview_outlined,
                                                              size: 25,
                                                              color:
                                                              blackColor,
                                                            ),
                                                            tooltip:
                                                            'View Application',
                                                            onPressed: () {
                                                              navigationViewMenu(
                                                                  context,
                                                                  applicationList[index].cATEGORYID,
                                                                  applicationList[index].sERVICEID,
                                                                  applicationList[index].aPPLICATIONNAME,
                                                                  applicationList[index].id.toString());
                                                            },
                                                          )
                                                              : SizedBox(),
                                                          applicationList[index].aPPLICATIONSYNCSTATUS == "Y"
                                                              ? IconButton(
                                                            icon: Icon(
                                                              Icons.stacked_line_chart_outlined,
                                                              size: 25,
                                                              color:
                                                              blackColor,
                                                            ),
                                                            tooltip:
                                                            'Track Application',
                                                            onPressed: () {
                                                              showMessageToast(
                                                                  'Track Application');
                                                            },
                                                          )
                                                              : SizedBox(),
                                                        ],
                                                      ),
                                                      applicationList[index].from_web == "Y"
                                                          ? CircleAvatar(
                                                        child: flag
                                                            ? Padding(padding: EdgeInsets.all(8.0),
                                                          child: CircularProgressIndicator(
                                                            strokeWidth: 2,
                                                            valueColor:
                                                            AlwaysStoppedAnimation(blueColor),
                                                          ),
                                                        )
                                                            : success
                                                            ? IconButton(
                                                          icon:
                                                          Icon(
                                                            Icons.assignment_turned_in_rounded,
                                                            size: 25,
                                                            color: greenColor,
                                                          ),
                                                          onPressed:
                                                              () {},
                                                        )
                                                            : GestureDetector(
                                                          onTap: () async {

                                                            bool? flag = await checkNetworkConnectivity();
                                                            if (flag!) {
                                                              getDownloadApplication(applicationList[index]);
                                                            }else{
                                                              showMessageToast(no_internet);
                                                            }

                                                          },
                                                          child: Icon(
                                                            Icons.download,
                                                            color: blackColor,
                                                          ),
                                                        ),
                                                        backgroundColor:
                                                        whiteColor,
                                                      )
                                                          : SizedBox(),
                                                      // Row(
                                                      //   children: [
                                                      //     Container(
                                                      //       padding:
                                                      //           EdgeInsets.all(5),
                                                      //       margin:
                                                      //           EdgeInsets.fromLTRB(
                                                      //               0, 0, 5, 0),
                                                      //       decoration: BoxDecoration(
                                                      //           color: orangeColor,
                                                      //           borderRadius:
                                                      //               BorderRadius
                                                      //                   .circular(
                                                      //                       8)),
                                                      //       child: Text('Pending',
                                                      //           style:
                                                      //               whiteBoldText14),
                                                      //     ),
                                                      //     Container(
                                                      //       padding:
                                                      //           EdgeInsets.all(5),
                                                      //       decoration: BoxDecoration(
                                                      //           color: greenColor,
                                                      //           borderRadius:
                                                      //               BorderRadius
                                                      //                   .circular(
                                                      //                       8)),
                                                      //       child: Text(
                                                      //         'GP',
                                                      //         style:
                                                      //             whiteBoldText14,
                                                      //       ),
                                                      //     ),
                                                      //   ],
                                                      // )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Positioned(
                                                right: -4,
                                                top: -4,
                                                child: applicationList[index].aPPLICATIONSYNCSTATUS.isEmpty || applicationList[index].aPPLICATIONSYNCSTATUS == "N" ? applicationList[index].from_web == "Y"
                                                    ? Card(
                                                  color: primaryColor,
                                                  elevation: 5,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.only(
                                                          topLeft: Radius.circular(0),
                                                          topRight: Radius.circular(8),
                                                          bottomLeft: Radius.circular(8))),
                                                  child: Padding(
                                                    padding:
                                                    EdgeInsets.all(
                                                        5.0),
                                                    child: Text(
                                                      ' Web ',
                                                      style:
                                                      whiteNormalText13,
                                                    ),
                                                  ),
                                                )
                                                    : applicationList[index].final_submit_flag.isEmpty ?
                                                Card(
                                                  color: deepOrangeAccentColor,
                                                  elevation: 5,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.only(
                                                          topLeft: Radius.circular(0),
                                                          topRight: Radius.circular(8),
                                                          bottomLeft: Radius.circular(8))),
                                                  child: Padding(
                                                    padding: EdgeInsets.all(5.0),
                                                    child: Text(
                                                      ' Draft ',
                                                      style:
                                                      whiteNormalText13,
                                                    ),
                                                  ),
                                                ) : Card(
                                                  color: redColor,
                                                  elevation: 5,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.only(
                                                          topLeft: Radius.circular(0),
                                                          topRight: Radius.circular(8),
                                                          bottomLeft: Radius.circular(8))),
                                                  child: Padding(
                                                    padding:
                                                    EdgeInsets.all(
                                                        5.0),
                                                    child: Text(
                                                      ' Not Sync ',
                                                      style:
                                                      whiteNormalText13,
                                                    ),
                                                  ),
                                                )
                                                    : Card(
                                                  color: greenColor,
                                                  elevation: 5,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.only(
                                                          topLeft: Radius.circular(0),
                                                          topRight: Radius.circular(8),
                                                          bottomLeft: Radius.circular(8))),
                                                  child: Padding(
                                                    padding:
                                                    EdgeInsets.all(5.0),
                                                    child: Text(
                                                      ' Sync ',
                                                      style:
                                                      whiteNormalText13,
                                                    ),
                                                  ),
                                                ))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              });
                        })
                ),
              )

            ],
          )
      ),
    );
  }

  void navigationMenu(
      BuildContext context,
      String categoryId,
      String subCategoryId,
      String title,
      String applicationId,
      String serviceName) {
    if (categoryId == '2') {
      // Building Category

      if (subCategoryId == '4') {
        Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DisconnectingWaterConnection(
                        title: title,
                        categoryId: categoryId,
                        serviceId: subCategoryId,
                        applicationId: applicationId,
                        servieName: serviceName)))
            .then((value) => getAllApplication());
      } else if (subCategoryId == '3') {
        Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WaterConnection(
                        title: title,
                        categoryId: categoryId,
                        serviceId: subCategoryId,
                        applicationId: applicationId,
                        servieName: serviceName)))
            .then((value) => getAllApplication());
      } else if (subCategoryId == '2') {
        Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BuildingLicenseScreen(
                        title: title,
                        categoryId: categoryId,
                        serviceId: subCategoryId,
                        applicationId: applicationId,
                        servieName: serviceName)))
            .then((value) => getAllApplication());
      }
      // else if (subCategoryId == '6') {
      //   Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //           builder: (context) =>
      //               Form9(
      //                   title: title,
      //                   categoryId: categoryId,
      //                   serviceId: subCategoryId,
      //                   applicationId: applicationId,
      //                   servieName: serviceName))).then((value) => getAllApplication());
      // }
      else if (subCategoryId == '7') {
        Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OccupancyCertificate(
                        title: title,
                        categoryId: categoryId,
                        serviceId: subCategoryId,
                        applicationId: applicationId,
                        servieName: serviceName)))
            .then((value) => getAllApplication());
      } else {
        showMessageToast('Coming soon');
      }
    } else if (categoryId == '4') {
      // Maintenance Category

      if (subCategoryId == '12') {
        Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DrinkingWater(
                        title: title,
                        categoryId: categoryId,
                        serviceId: subCategoryId,
                        applicationId: applicationId,
                        servieName: serviceName)))
            .then((value) => getAllApplication());
      } else if (subCategoryId == '13') {
        Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Streetlight(
                        title: title,
                        categoryId: categoryId,
                        serviceId: subCategoryId,
                        applicationId: applicationId,
                        servieName: serviceName)))
            .then((value) => getAllApplication());
      } else if (subCategoryId == '14') {
        Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => VillageSanitation(
                        title: title,
                        categoryId: categoryId,
                        serviceId: subCategoryId,
                        applicationId: applicationId,
                        servieName: serviceName)))
            .then((value) => getAllApplication());
      } else {
        showMessageToast('Coming soon');
      }
    } else if (categoryId == '5') {
      // OtherScreen Category

      if (subCategoryId == '18') {
        Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Entertainmentlicense(
                        title: title,
                        categoryId: categoryId,
                        serviceId: subCategoryId,
                        applicationId: applicationId,
                        servieName: serviceName)))
            .then((value) => getAllApplication());
      } else if (subCategoryId == '16') {
        Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => IssuanceOfNocEscoms(
                        title: title,
                        categoryId: categoryId,
                        serviceId: subCategoryId,
                        applicationId: applicationId,
                        servieName: serviceName)))
            .then((value) => getAllApplication());
      } else if (subCategoryId == '25') {
        // Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //             builder: (context) => MobileTower(
        //                 title: title,
        //                 categoryId: categoryId,
        //                 serviceId: subCategoryId,
        //                 applicationId: applicationId,
        //                 servieName: serviceName)))
        //     .then((value) => getAllApplication());
        showMessageToast('Coming soon');
      } else if (subCategoryId == '17') {
        Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RoadCuttingPermission(
                        title: title,
                        categoryId: categoryId,
                        serviceId: subCategoryId,
                        applicationId: applicationId,
                        servieName: serviceName)))
            .then((value) => getAllApplication());
      } else {
        showMessageToast('Coming soon');
      }
    }
    /* else if (categoryId == '7') {
      // Property Category

      if (subCategoryId == '88') {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PropertyTaxScreen()));
      } else {
        showMessageToast('Coming soon');
      }
    }*/
    else if (categoryId == '3') {
      // Trade Category

      if (subCategoryId == '11') {
        Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AdvertisementLicense(
                        title: title,
                        categoryId: categoryId,
                        serviceId: subCategoryId,
                        applicationId: applicationId,
                        servieName: serviceName)))
            .then((value) => getAllApplication());
      } else if (subCategoryId == '10') {
        Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FactoryClearance(
                        title: title,
                        categoryId: categoryId,
                        serviceId: subCategoryId,
                        applicationId: applicationId,
                        servieName: serviceName)))
            .then((value) => getAllApplication());
      } else if (subCategoryId == '9') {
        Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BusinessLicense(
                        title: title,
                        categoryId: categoryId,
                        serviceId: subCategoryId,
                        applicationId: applicationId,
                        servieName: serviceName)))
            .then((value) => getAllApplication());
      } else {
        showMessageToast('Coming soon');
      }
    } else {
      showMessageToast('Coming soon');
    }
  }

  List<Widget> techChips () {
    List<Widget> chips = [];
    for (int i=0; i< _chipsList.length; i++) {
      Widget item = Padding(
        padding: const EdgeInsets.only(left:0, right: 5),
        child: Stack(
          children: [
            ChoiceChip(
              label: Text(_chipsList[i]),
              labelStyle: TextStyle(color: Colors.white),
              backgroundColor: grayColor,
              selectedColor: grey,
              selected: selectedIndex == i,
              onSelected: (bool value)
              async {
                setState(() {
                  selectedIndex = i;
                });

                if(value){
                  if(i == 1){
                    applicationList.clear();
                    applicationList = await DatabaseOperation.instance.getBuildingApplications();
                    setState(() {});
                  }else if(i == 2){
                    applicationList.clear();
                    applicationList = await DatabaseOperation.instance.getTradeApplications();
                    setState(() {});
                  }else if(i == 3){
                    applicationList.clear();
                    applicationList = await DatabaseOperation.instance.getOtherApplications();
                    setState(() {});
                  }else if(i == 4){
                    applicationList.clear();
                    applicationList = await DatabaseOperation.instance.getMaintenanceApplications();
                    setState(() {});
                  }else{
                    applicationList.clear();
                    applicationList = await DatabaseOperation.instance.getAllMstAddApplicationModel();
                    setState(() {});
                  }
                }
              },
            ),
            // Positioned(
            //     right: 0,
            //     top: 0,
            //     child: Container(
            //       decoration: BoxDecoration(
            //         color: Colors.red[400],
            //         shape: BoxShape.circle,
            //         // boxShadow: [BoxShadow(blurRadius: 0, color: Colors.transparent, spreadRadius: 1)],
            //       ),
            //       child: Padding(
            //           padding: EdgeInsets.all(2.0),
            //           child: Text('12',style: TextStyle(fontSize: 12,color: whiteColor),)),
            //     )),
          ],
        ),
      );
      chips.add(item);
    }
    return chips;
  }

  void navigationViewMenu(BuildContext context, String categoryId,
      String subCategoryId, String title, String applicationId) {
    print(categoryId);
    print(subCategoryId);

    if (categoryId == '2') {
      // Building Category

      if (subCategoryId == '4') {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ViewDisconnectingWaterConnection(
                    title: title,
                    categoryId: categoryId,
                    serviceId: subCategoryId,
                    applicationId: applicationId)));
      } else if (subCategoryId == '3') {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ViewWaterConnection(
                    title: title,
                    categoryId: categoryId,
                    serviceId: subCategoryId,
                    applicationId: applicationId)));
      } else if (subCategoryId == '2') {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ViewBuildingLicense(
                    title: title,
                    categoryId: categoryId,
                    serviceId: subCategoryId,
                    applicationId: applicationId)));
      } else if (subCategoryId == '6') {
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => Form9()));
      } else if (subCategoryId == '7') {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ViewOccupancyCertificate(
                    title: title,
                    categoryId: categoryId,
                    serviceId: subCategoryId,
                    applicationId: applicationId)));
      } else {
        showMessageToast('Coming soon');
      }
    } else if (categoryId == '4') {
      // Maintenance Category

      if (subCategoryId == '12') {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ViewDrinkingWater(
                    title: title,
                    categoryId: categoryId,
                    serviceId: subCategoryId,
                    applicationId: applicationId)));
      } else if (subCategoryId == '13') {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ViewStreetLight(
                    title: title,
                    categoryId: categoryId,
                    serviceId: subCategoryId,
                    applicationId: applicationId)));
      } else if (subCategoryId == '14') {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ViewVillageSanitation(
                    title: title,
                    categoryId: categoryId,
                    serviceId: subCategoryId,
                    applicationId: applicationId)));
      } else {
        showMessageToast('Coming soon');
      }
    } else if (categoryId == '5') {
      // OtherScreen Category

      if (subCategoryId == '18') {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ViewEntertainmentLicense(
                    title: title,
                    categoryId: categoryId,
                    serviceId: subCategoryId,
                    applicationId: applicationId)));
      } else if (subCategoryId == '16') {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ViewNocEscoms(
                    title: title,
                    categoryId: categoryId,
                    serviceId: subCategoryId,
                    applicationId: applicationId)));
      } else if (subCategoryId == '15') {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ViewIssuanceOfRecords()));
      } else if (subCategoryId == '17') {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ViewRoadCuttingPermission(
                    title: title,
                    categoryId: categoryId,
                    serviceId: subCategoryId,
                    applicationId: applicationId)));
      } else {
        showMessageToast('Coming soon');
      }
    }
    /* else if (categoryId == '7') {
      // Property Category

      if (subCategoryId == '88') {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PropertyTaxScreen()));
      } else {
        showMessageToast('Coming soon');
      }
    }*/
    else if (categoryId == '3') {
      // Trade Category

      if (subCategoryId == '11') {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ViewAdvtLicense(
                    title: title,
                    categoryId: categoryId,
                    serviceId: subCategoryId,
                    applicationId: applicationId)));
      } else if (subCategoryId == '10') {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ViewFactoryClearance(
                    title: title,
                    categoryId: categoryId,
                    serviceId: subCategoryId,
                    applicationId: applicationId)));
      } else if (subCategoryId == '9') {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ViewBusinessLicense(
                    title: title,
                    categoryId: categoryId,
                    serviceId: subCategoryId,
                    applicationId: applicationId)));
      } else {
        showMessageToast('Coming soon');
      }
    } else {
      showMessageToast('Coming soon');
    }
  }

  void getAllApplication() async {
    // bool? flag = await checkNetworkConnectivity();
    // if (flag!) {
    //   getDashboardApplication();
    // } else {
      applicationList.clear();
      applicationList = await DatabaseOperation.instance.getAllMstAddApplicationModel();
      setState(() {});
    // }
  }

  void deleteApplication(int index) {
    // set up the button
    Widget okButton = TextButton(
      child: Text(delete),
      onPressed: () async {
        var i = await DatabaseOperation.instance.deleteAddedApplication(applicationList[index].id.toString());
        if (i > 0) {
          getAllApplication();
          Navigator.pop(context);
        }
      },
    );

    Widget noButton = TextButton(
      child: Text('No'),
      onPressed: () async {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Delete Application"),
      content: Text("Are you sure to delete this draft application ?"),
      actions: [
        noButton,
        okButton,
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

  void displayErrorMessageApplication(int index) {
    // set up the button
    Widget okButton = TextButton(
      child: Text(ok),
      onPressed: () async {
        Navigator.pop(context);
      },
    );

    String str = applicationList[index].sync_message;
    String result = '';
    jsonDecode(str).forEach((dynamicKey, list) {
      result += dynamicKey + ' : ' + list + '\n\n';
    });
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Error Messages"),
      content: SingleChildScrollView(
          physics: BouncingScrollPhysics(), child: Text(result)),
      actions: [
        okButton,
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

  void getDashboardApplication() async {
    var data = {"login_id": globals.loginSessionModel!.citizenRegistrationId};

    var map = (await httpPostMethod('/ajax/getReportDataWebService?serviceName=getCSDashboardData&serviceType=REPORT', jsonEncode(data)));

    if (map['Status'] == 200) {
      var body = jsonDecode(map['Body']);

      if (body.length > 0) {
        for (var i = 0; i < body.length; i++) {

          String date = '';

          if(body[i]['CRT_DATE'] != null && body[i]['CRT_DATE'].toString().isNotEmpty){
            List<String> dateArray = body[i]['CRT_DATE'].toString().split('-');
            String mon = dateArray[1].toLowerCase();
            String firstMon = mon.substring(0,1);
            date = dateArray[0]+'-'+mon.replaceFirst(firstMon, firstMon.toUpperCase()).toString()+'-'+dateArray[2];
          }

          MstAddApplicationModel mstAddApplicationModel =
              new MstAddApplicationModel(
                  id: null,
                  cATEGORYID: body[i]['SERVICE_ID'],
                  sERVICEID: body[i]['SUB_SERVICE_ID'],
                  aPPLICATIONNAME: body[i]['SERVICE_NAME'],
                  service_name: body[i]['SUB_SERVICE_NAME'],
                  gENERATEDAPPLICATIONID: body[i]['APPL_NO'],
                  aPPLICATIONAPPLYDATE: getDateUsingForDate(date, 'dd-MMM-yyyy', 'dd/MM/yyyy'),
                  aPPLICATIONDATA: '',
                  aPPLICATIONSYNCSTATUS: 'N',
                  aPPLICATIONSYNCDATE: '',
                  crt_user: '',
                  crt_date: getDateUsingForDate(date, 'dd-MMM-yyyy', 'dd/MM/yyyy'),
                  lst_upd_user: '',
                  lst_upd_date: getDateUsingForDate(date, 'dd-MMM-yyyy', 'dd/MM/yyyy'),
                  current_tab: body[i]['APPL_STAGE'] != null && body[i]['APPL_STAGE'] != '' ? (int.parse(body[i]['APPL_STAGE']) - 1).toString() : '',
                  from_web: 'Y',
                  draft_id: body[i]['DRAFT_ID'],
                  aPPVERSION: await getAppVersion());

          if (body[i]['DRAFT_ID'] != null && body[i]['DRAFT_ID'].toString().isNotEmpty) {
            // await DatabaseOperation.instance.deleteApplicationUsingDraftId(body[i]['DRAFT_ID']);
            int? count = await DatabaseOperation.instance.getDraftApplicationCount(body[i]['DRAFT_ID']);

            if (count == null || count == 0) {
              await DatabaseOperation.instance.insertMstAddApplicationModel(mstAddApplicationModel);
            }
          } else {
            // await DatabaseOperation.instance.deleteApplicationUsingAppId(body[i]['APPL_NO']);
            int? count = await DatabaseOperation.instance.getApplicationCount(body[i]['APPL_NO']);

            if (count == null || count == 0) {
              await DatabaseOperation.instance.insertMstAddApplicationModel(mstAddApplicationModel);

            }
          }
        }
      }
    }

    applicationList.clear();
    applicationList = await DatabaseOperation.instance.getAllMstAddApplicationModel();

    setState(() {});
  }

  showDownloadMasters(BuildContext context) async {
    Widget okButton = TextButton(
      child: Text('Ok', style: whiteNormalText14),
      style: cancelButtonBlueStyle,
      onPressed: () {
        Navigator.pop(context);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => DownloadMasterScreen()));
      },
    );

    // set up the AlertDialog
    AlertDialog alert1 = AlertDialog(
      title: Container(
          color: primaryColor,
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Download All Masters",
                style: whiteBoldText18,
              ),
            ),
          )),
      titlePadding: const EdgeInsets.all(10),
      content: Container(
        height: 40,
        child: Text("First Download All Masters before filling Application"),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child:alert1,
        );
      },
    );
  }

  Future<void> checkDownloadAllMasters() async {
    String? isDownloadDistrict = await getPreference('isDownloadDistrict');
    String? isDownloadTaluka = await getPreference('isDownloadTaluka');
    String? isDownloadGpachayat = await getPreference('isDownloadGramPanchayat');
    String? isDownloadVillage = await getPreference('isDownloadVillage');
    String? isDownloadAll = await getPreference('isDownloadAllMasters');
    //print('shared value'+isDownload_district.toString());
    if (isDownloadDistrict == null || isDownloadDistrict == 'N' || isDownloadDistrict.isEmpty || isDownloadTaluka == null ||
        isDownloadTaluka == 'N' || isDownloadTaluka.isEmpty || isDownloadGpachayat == null || isDownloadGpachayat == 'N' || isDownloadGpachayat.isEmpty ||
        isDownloadVillage == null || isDownloadVillage == 'N' || isDownloadVillage.isEmpty || isDownloadAll == null || isDownloadAll == 'N' || isDownloadAll.isEmpty) {
      Future.delayed(Duration.zero, () => showDownloadMasters(context));
    }
  }

  void getDownloadApplication(MstAddApplicationModel mstAddApplicationModel) async {
   
    String trnCsApplId = mstAddApplicationModel.gENERATEDAPPLICATIONID.isEmpty ? mstAddApplicationModel.draft_id : mstAddApplicationModel.gENERATEDAPPLICATIONID;

    var data = {'trn_cs_appl_id': trnCsApplId};

    var map;

    showDialogWithLoad(context);

    if (mstAddApplicationModel.cATEGORYID == '2' && mstAddApplicationModel.sERVICEID == '3') {
      map = (await httpFromDataPostMethod('/csAjax/getNewWaterConnData/' + trnCsApplId, data));
    } else if (mstAddApplicationModel.cATEGORYID == '2' && mstAddApplicationModel.sERVICEID == '4') {
      map = (await httpFromDataPostMethod('/csAjax/getDiscWaterConnData/' + trnCsApplId, data));
    } else if (mstAddApplicationModel.cATEGORYID == '2' && mstAddApplicationModel.sERVICEID == '2') {
      map = (await httpFromDataPostMethod('/csAjax/getBuildApplData/' + trnCsApplId, data));
    } else if (mstAddApplicationModel.cATEGORYID == '2' && mstAddApplicationModel.sERVICEID == '7') {
      map = (await httpFromDataPostMethod('/csAjax/getOccuCertiData/' + trnCsApplId, data));
    } else if (mstAddApplicationModel.cATEGORYID == '4' && mstAddApplicationModel.sERVICEID == '12') {
      map = (await httpFromDataPostMethod('/csAjax/getsavedftMainDrinkingWaterlDtl/' + trnCsApplId, data));
    } else if (mstAddApplicationModel.cATEGORYID == '4' && mstAddApplicationModel.sERVICEID == '13') {
      map = (await httpFromDataPostMethod('/csAjax/getsavedftMainStreetLightDtl/' + trnCsApplId, data));
    } else if (mstAddApplicationModel.cATEGORYID == '4' && mstAddApplicationModel.sERVICEID == '14') {
      map = (await httpFromDataPostMethod('/csAjax/getsavedftMaintVillageSanitationDtl/' + trnCsApplId, data));
    } else if (mstAddApplicationModel.cATEGORYID == '5' && mstAddApplicationModel.sERVICEID == '18') {
      map = (await httpFromDataPostMethod('/csAjax/getEntmtApplData/' + trnCsApplId, data));
    } else if (mstAddApplicationModel.cATEGORYID == '5' && mstAddApplicationModel.sERVICEID == '16') {
      map = (await httpFromDataPostMethod('/csAjax/getIssuNocRecDtl/' + trnCsApplId, data));
    } else if (mstAddApplicationModel.cATEGORYID == '5' && mstAddApplicationModel.sERVICEID == '17') {
      map = (await httpFromDataPostMethod('/csAjax/getNewRoadCuttingData/' + trnCsApplId, data));
    } else if (mstAddApplicationModel.cATEGORYID == '5' && mstAddApplicationModel.sERVICEID == '18') {
      // var map = (await httpFromDataPostMethod('/csAjax/roadcuttig/'+trn_cs_appl_id, data));
    } else if (mstAddApplicationModel.cATEGORYID == '3' && mstAddApplicationModel.sERVICEID == '11') {
      map = (await httpFromDataPostMethod('/csAjax/getApplDraftAdvlicAppDetail/' + trnCsApplId, data));
    } else if (mstAddApplicationModel.cATEGORYID == '3' && mstAddApplicationModel.sERVICEID == '10') {
      map = (await httpFromDataPostMethod('/csAjax/getFactPerData/' + trnCsApplId, data));
    } else if (mstAddApplicationModel.cATEGORYID == '3' && mstAddApplicationModel.sERVICEID == '9') {
      map = (await httpFromDataPostMethod('/csAjax/getBuildApplData/' + trnCsApplId, data));
    }

    if (map['Status'] == 1000) {
      if (map['Body'] != null) {
        var json = jsonDecode(map['Body']);
        var jsonListData = jsonDecode(json['jsonListData'].toString().toLowerCase());

        if (jsonListData.length > 0) {
          print('-------------------------------------');
          print(jsonEncode(jsonListData[0]));
          print('-------------------------------------');

          if (mstAddApplicationModel.cATEGORYID == '2' && mstAddApplicationModel.sERVICEID == '3') {
            NewWaterConnectionApplicantDetailsModel? applicantDetailsModel = new NewWaterConnectionApplicantDetailsModel.fromJson(jsonListData[0]);
            NewWaterConnectionPropertyDetailsModel? propertyDetailsModel = new NewWaterConnectionPropertyDetailsModel.fromJson(jsonListData[0]);
            NewWaterConnectionWaterConnectionModel? waterConnectionModel = new NewWaterConnectionWaterConnectionModel.fromJson(jsonListData[0]);

            NewWaterConnectionModel? mainModel;

            if(mstAddApplicationModel.current_tab == '0'){
              mainModel = new NewWaterConnectionModel(waterConnDocumentModel: null, propertyDetailsModel: null, waterConnectionModel: null, applicantDetailsModel: applicantDetailsModel);
            }
            else if(mstAddApplicationModel.current_tab == '1'){
              mainModel = new NewWaterConnectionModel(waterConnDocumentModel: null, propertyDetailsModel: propertyDetailsModel, waterConnectionModel: null, applicantDetailsModel: applicantDetailsModel);
            }
            else if(mstAddApplicationModel.current_tab == '2'){
              mainModel = new NewWaterConnectionModel(waterConnDocumentModel: null, propertyDetailsModel: propertyDetailsModel, waterConnectionModel: waterConnectionModel, applicantDetailsModel: applicantDetailsModel);
            }
            // else if(mstAddApplicationModel.current_tab == '3'){
           // mainModel = new NewWaterConnectionModel(waterConnDocumentModel: null, propertyDetailsModel: propertyDetailsModel, waterConnectionModel: waterConnectionModel, applicantDetailsModel: documentDetailsModel);
            // }
            else {
              // mainModel = null;
              mainModel = new NewWaterConnectionModel(waterConnDocumentModel: null, propertyDetailsModel: propertyDetailsModel, waterConnectionModel: waterConnectionModel, applicantDetailsModel: applicantDetailsModel);
            }

            print(jsonEncode(applicantDetailsModel));
            print(jsonEncode(propertyDetailsModel));
            print(jsonEncode(waterConnectionModel));

            await DatabaseOperation.instance.updateOnlineAppData(mstAddApplicationModel.id.toString(),jsonEncode(mainModel), getCurrentDateUsingFormatter(dateFormate_dd_MM_yyyy));
            showMessageToast("Application Data Download Successfully");

            applicationList.clear();
            applicationList = await DatabaseOperation.instance.getAllMstAddApplicationModel();
            setState(() {});

          } else if (mstAddApplicationModel.cATEGORYID == '2' && mstAddApplicationModel.sERVICEID == '4') {

            DCWaterConnectionApplicantDetailsModel? applicantDetailsModel = new DCWaterConnectionApplicantDetailsModel.fromJson(jsonListData[0]);
            DCWaterConnectionPropertyDetailsModel? propertyDetailsModel = new DCWaterConnectionPropertyDetailsModel.fromJson(jsonListData[0]);
            //DCWaterConnectionDocDetailsModel? docDetailsModel = DCWaterConnectionDocDetailsModel.fromJson(jsonListData[0]);

            DCWaterConnectionModel? mainModel;
            if(mstAddApplicationModel.current_tab == '0'){
              mainModel = new DCWaterConnectionModel(applicantDetailsModel, null, null);
            }
            else if(mstAddApplicationModel.current_tab == '1'){
              mainModel = new DCWaterConnectionModel(applicantDetailsModel, propertyDetailsModel, null);
            }
            // else if(mstAddApplicationModel.current_tab == '2'){
            //   mainModel = new DCWaterConnectionModel(applicantDetailsModel, propertyDetailsModel, docDetailsModel);
            // }
            else {
              // mainModel = null;
              mainModel = new DCWaterConnectionModel(applicantDetailsModel, propertyDetailsModel, null);
            }

            print(jsonEncode(applicantDetailsModel));
            print(jsonEncode(mainModel.dcWaterConnectionPropertyDetailsModel));

            await DatabaseOperation.instance.updateOnlineAppData(mstAddApplicationModel.id.toString(),jsonEncode(mainModel), getCurrentDateUsingFormatter(dateFormate_dd_MM_yyyy));

            showMessageToast("Application Data Download Successfully");

            applicationList.clear();
            applicationList = await DatabaseOperation.instance.getAllMstAddApplicationModel();
            setState(() {});

          } else if (mstAddApplicationModel.cATEGORYID == '2' && mstAddApplicationModel.sERVICEID == '2') {

            BuildingLicenseApplicantDetailsModel? applicantDetailsModel = new BuildingLicenseApplicantDetailsModel.fromJson(jsonListData[0]);
            BuildingLicensePropertyDetailsModel? propertyDetailsModel = new BuildingLicensePropertyDetailsModel.fromJson(jsonListData[0]);
            BuildingLicenseBuildingDetailsModel? buildingDetailsModel = BuildingLicenseBuildingDetailsModel.fromJson(jsonListData[0]);
           // BuildingLicenseDocumentDetailsModel? documentDetailsModel = BuildingLicenseDocumentDetailsModel.fromJson(jsonListData[0]);
            BuildingLicenseModel? mainModel;

            if(mstAddApplicationModel.current_tab == '0'){
              mainModel = new BuildingLicenseModel(applicantDetailsModel: applicantDetailsModel, propertyDetailsModel: null, buildingDetailsModel: null, buildingDocumentModel: null);
            }
            else if(mstAddApplicationModel.current_tab == '1'){
              mainModel = new BuildingLicenseModel(applicantDetailsModel: applicantDetailsModel, propertyDetailsModel: propertyDetailsModel, buildingDetailsModel: null, buildingDocumentModel: null);
            }
            else if(mstAddApplicationModel.current_tab == '2'){
              mainModel = new BuildingLicenseModel(applicantDetailsModel: applicantDetailsModel, propertyDetailsModel: propertyDetailsModel, buildingDetailsModel: buildingDetailsModel, buildingDocumentModel: null);
            }
            // else if(mstAddApplicationModel.current_tab == '3'){
            // mainModel = new AdvtLicenseModel(applicantDetailsModel: applicantDetailsModel, propertyDetailsModel: propertyDetailsModel, advertiseDetailsModel: advertiseDetailsModel, advertiseDocumentModel: documentDetailsModel);
            // }
            else {
              // mainModel = null;
              mainModel = new BuildingLicenseModel(applicantDetailsModel: applicantDetailsModel, propertyDetailsModel: propertyDetailsModel, buildingDetailsModel: buildingDetailsModel, buildingDocumentModel: null);
            }

            print(jsonEncode(applicantDetailsModel));
            print(jsonEncode(propertyDetailsModel));
            print(jsonEncode(buildingDetailsModel));

            await DatabaseOperation.instance.updateOnlineAppData(mstAddApplicationModel.id.toString(),jsonEncode(mainModel), getCurrentDateUsingFormatter(dateFormate_dd_MM_yyyy));
            showMessageToast("Application Data Download Successfully");

            applicationList.clear();
            applicationList = await DatabaseOperation.instance.getAllMstAddApplicationModel();
            setState(() {});

          } else if (mstAddApplicationModel.cATEGORYID == '2' && mstAddApplicationModel.sERVICEID == '7') {

            OccupancyCertificateApplicantDetail? occupancyCertificateApplicantDetail = new OccupancyCertificateApplicantDetail.fromJson(jsonListData[0]);
            OccupancyCertificatePropertyDetail? occupancyCertificatePropertyDetail = new OccupancyCertificatePropertyDetail.fromJson(jsonListData[0]);
            OccupancyCertificateLicenseDetail? occupancyCertificateLicenseDetail = OccupancyCertificateLicenseDetail.fromJson(jsonListData[0]);
            // OccupancyCertificateDocumentDetail? occupancyCertificateDocumentDetail = OccupancyCertificateDocumentDetail.fromJson(jsonListData[0]);

            OccupancyCertificateModel? mainModel;

            if(mstAddApplicationModel.current_tab == '0'){
              mainModel = new OccupancyCertificateModel(occupancyCertificateApplicantDetail, null, null, null);
            }
            else if(mstAddApplicationModel.current_tab == '1'){
              mainModel = new OccupancyCertificateModel(occupancyCertificateApplicantDetail, occupancyCertificatePropertyDetail, null, null);
            }
            else if(mstAddApplicationModel.current_tab == '2'){
              mainModel = new OccupancyCertificateModel(occupancyCertificateApplicantDetail, occupancyCertificatePropertyDetail, occupancyCertificateLicenseDetail, null);
            }
            // else if(mstAddApplicationModel.current_tab == '3'){
            // mainModel = new AdvtLicenseModel(applicantDetailsModel: applicantDetailsModel, propertyDetailsModel: propertyDetailsModel, advertiseDetailsModel: advertiseDetailsModel, advertiseDocumentModel: occupancyCertificateDocumentDetail);
            // }
            else {
              // mainModel = null;
              mainModel = new OccupancyCertificateModel(occupancyCertificateApplicantDetail, occupancyCertificatePropertyDetail, occupancyCertificateLicenseDetail, null);
            }


            print(jsonEncode(occupancyCertificateApplicantDetail));
            print(jsonEncode(occupancyCertificatePropertyDetail));
            print(jsonEncode(occupancyCertificateLicenseDetail));

            await DatabaseOperation.instance.updateOnlineAppData(mstAddApplicationModel.id.toString(),jsonEncode(mainModel), getCurrentDateUsingFormatter(dateFormate_dd_MM_yyyy));
            showMessageToast("Application Data Download Successfully");

            applicationList.clear();
            applicationList = await DatabaseOperation.instance.getAllMstAddApplicationModel();
            setState(() {});

          } else if (mstAddApplicationModel.cATEGORYID == '4' && mstAddApplicationModel.sERVICEID == '12') {
            DrinkingWaterApplication? drinkingWaterApplication = new DrinkingWaterApplication.fromJson(jsonListData[0]);

            DrinkingWaterModel mainModel = new DrinkingWaterModel(drinkingWaterApplication);

            print(jsonEncode(drinkingWaterApplication));

            await DatabaseOperation.instance.updateOnlineAppData(mstAddApplicationModel.id.toString(),jsonEncode(mainModel), getCurrentDateUsingFormatter(dateFormate_dd_MM_yyyy));
            showMessageToast("Application Data Download Successfully");

            applicationList.clear();
            applicationList = await DatabaseOperation.instance.getAllMstAddApplicationModel();
            setState(() {});

          } else if (mstAddApplicationModel.cATEGORYID == '4' && mstAddApplicationModel.sERVICEID == '13') {

            StreetLightApplication? streetLightApplication = new StreetLightApplication.fromJson(jsonListData[0]);

            StreetLightModel mainModel = new StreetLightModel(streetLightApplication);

            print(jsonEncode(streetLightApplication));

            await DatabaseOperation.instance.updateOnlineAppData(mstAddApplicationModel.id.toString(),jsonEncode(mainModel), getCurrentDateUsingFormatter(dateFormate_dd_MM_yyyy));
            showMessageToast("Application Data Download Successfully");

            applicationList.clear();
            applicationList = await DatabaseOperation.instance.getAllMstAddApplicationModel();
            setState(() {});

          } else if (mstAddApplicationModel.cATEGORYID == '4' && mstAddApplicationModel.sERVICEID == '14') {
            VillageSanitationApplication? villageSanitationApplication = new VillageSanitationApplication.fromJson(jsonListData[0]);

            VillageSanitationModel mainModel = new VillageSanitationModel(villageSanitationApplication);

            print(jsonEncode(villageSanitationApplication));

            await DatabaseOperation.instance.updateOnlineAppData(mstAddApplicationModel.id.toString(),jsonEncode(mainModel), getCurrentDateUsingFormatter(dateFormate_dd_MM_yyyy));
            showMessageToast("Application Data Download Successfully");

            applicationList.clear();
            applicationList = await DatabaseOperation.instance.getAllMstAddApplicationModel();
            setState(() {});

          } else if (mstAddApplicationModel.cATEGORYID == '5' && mstAddApplicationModel.sERVICEID == '16') {

            NocEscomsApplicant? nocEscomsApplicant = new NocEscomsApplicant.fromJson(jsonListData[0]);
            NocEcomsProperty? nocEcomsProperty = new NocEcomsProperty.fromJson(jsonListData[0]);
            //NocEcomsDoc? nocEcomsDoc = NocEcomsDoc.fromJson(jsonListData[0]);

            NocEscomsModel? mainModel;

            if(mstAddApplicationModel.current_tab == '0'){
               mainModel = new NocEscomsModel(nocEscomsApplicant, null, null);
            }
            else if(mstAddApplicationModel.current_tab == '1'){
              mainModel = new NocEscomsModel(nocEscomsApplicant, nocEcomsProperty, null);
            }
            // else if(mstAddApplicationModel.current_tab == '2'){
            //   mainModel = new NocEscomsModel(nocEscomsApplicant, nocEcomsPro
            //   perty, nocEcomsDoc);
            // }
            else {
              // mainModel = null;
              mainModel = new NocEscomsModel(nocEscomsApplicant, nocEcomsProperty, null);
            }

            await DatabaseOperation.instance.updateOnlineAppData(mstAddApplicationModel.id.toString(),jsonEncode(mainModel), getCurrentDateUsingFormatter(dateFormate_dd_MM_yyyy));
            showMessageToast("Application Data Download Successfully");

            applicationList.clear();
            applicationList = await DatabaseOperation.instance.getAllMstAddApplicationModel();
            setState(() {});

          } else if (mstAddApplicationModel.cATEGORYID == '5' && mstAddApplicationModel.sERVICEID == '18') {

            EntmtLicenseApplicantDetailsModel? applicantDetailsModel = new EntmtLicenseApplicantDetailsModel.fromJson(jsonListData[0]);
            EntmtLicensePropertyDetailsModel? propertyDetailsModel = new EntmtLicensePropertyDetailsModel.fromJson(jsonListData[0]);
            EntmtLicenseProgramDetailsModel programDetailsModel = new EntmtLicenseProgramDetailsModel.fromJson(jsonListData[0]);
            //EntmtLicenseDocumentDetailsModel documentDetailsModel = new EntmtLicenseDocumentDetailsModel.fromJson(jsonListData[0]);

            EntmtLicenseModel? mainModel;
            if(mstAddApplicationModel.current_tab == '0'){
              mainModel = new EntmtLicenseModel(applicantDetailsModel: applicantDetailsModel, propertyDetailsModel: null, programDetailsModel: null, entertainmentDocumentModel: null);
            }
            else if(mstAddApplicationModel.current_tab == '1'){
              mainModel = new EntmtLicenseModel(applicantDetailsModel: applicantDetailsModel, propertyDetailsModel: propertyDetailsModel, programDetailsModel: null, entertainmentDocumentModel: null);
            }
            else if(mstAddApplicationModel.current_tab == '2'){
              mainModel = new EntmtLicenseModel(applicantDetailsModel: applicantDetailsModel, propertyDetailsModel: propertyDetailsModel, programDetailsModel: programDetailsModel, entertainmentDocumentModel: null);
            }
            // else if(mstAddApplicationModel.current_tab == '3'){
            //   mainModel = new EntmtLicenseModel(applicantDetailsModel: applicantDetailsModel, propertyDetailsModel: propertyDetailsModel, programDetailsModel: programDetailsModel, entertainmentDocumentModel: documentDetailsModel);
            // }
            else {
              // mainModel = null;
              mainModel = new EntmtLicenseModel(applicantDetailsModel: applicantDetailsModel, propertyDetailsModel: propertyDetailsModel, programDetailsModel: programDetailsModel, entertainmentDocumentModel: null);
            }


            await DatabaseOperation.instance.updateOnlineAppData(mstAddApplicationModel.id.toString(),jsonEncode(mainModel), getCurrentDateUsingFormatter(dateFormate_dd_MM_yyyy));
            showMessageToast("Application Data Download Successfully");

            applicationList.clear();
            applicationList = await DatabaseOperation.instance.getAllMstAddApplicationModel();
            setState(() {});

          } else if (mstAddApplicationModel.cATEGORYID == '3' && mstAddApplicationModel.sERVICEID == '11') {

            AdvtLicenseApplicantDetailsModel? applicantDetailsModel = new AdvtLicenseApplicantDetailsModel.fromJson(jsonListData[0]);
            AdvtLicensePropertyDetailsModel? propertyDetailsModel = new AdvtLicensePropertyDetailsModel.fromJson(jsonListData[0]);
            AdvtLicenseAdvertiseDetailsModel advertiseDetailsModel = new AdvtLicenseAdvertiseDetailsModel.fromJson(jsonListData[0]);
           // AdvtLicenseDocumentDetailsModel documentDetailsModel = new AdvtLicenseDocumentDetailsModel.fromJson(jsonListData[0]);

            AdvtLicenseModel? mainModel;

            if(mstAddApplicationModel.current_tab == '0'){
              mainModel = new AdvtLicenseModel(applicantDetailsModel: applicantDetailsModel, propertyDetailsModel: null, advertiseDetailsModel: null, advertiseDocumentModel: null);
            }
            else if(mstAddApplicationModel.current_tab == '1'){
              mainModel = new AdvtLicenseModel(applicantDetailsModel: applicantDetailsModel, propertyDetailsModel: propertyDetailsModel, advertiseDetailsModel: null, advertiseDocumentModel: null);
            }
            else if(mstAddApplicationModel.current_tab == '2'){
              mainModel = new AdvtLicenseModel(applicantDetailsModel: applicantDetailsModel, propertyDetailsModel: propertyDetailsModel, advertiseDetailsModel: advertiseDetailsModel, advertiseDocumentModel: null);
            }
            // else if(mstAddApplicationModel.current_tab == '3'){
            // mainModel = new AdvtLicenseModel(applicantDetailsModel: applicantDetailsModel, propertyDetailsModel: propertyDetailsModel, advertiseDetailsModel: advertiseDetailsModel, advertiseDocumentModel: documentDetailsModel);
            // }
            else {
              // mainModel = null;
              mainModel = new AdvtLicenseModel(applicantDetailsModel: applicantDetailsModel, propertyDetailsModel: propertyDetailsModel, advertiseDetailsModel: advertiseDetailsModel, advertiseDocumentModel: null);
            }

            print(jsonEncode(applicantDetailsModel));
            print(jsonEncode(propertyDetailsModel));
            print(jsonEncode(advertiseDetailsModel));

            await DatabaseOperation.instance.updateOnlineAppData(mstAddApplicationModel.id.toString(),jsonEncode(mainModel), getCurrentDateUsingFormatter(dateFormate_dd_MM_yyyy));
            showMessageToast("Application Data Download Successfully");

            applicationList.clear();
            applicationList = await DatabaseOperation.instance.getAllMstAddApplicationModel();
            setState(() {});

          } else if (mstAddApplicationModel.cATEGORYID == '3' && mstAddApplicationModel.sERVICEID == '10') {

            FactoryPerApplicantDetailsModel? applicantDetailsModel = new FactoryPerApplicantDetailsModel.fromJson(jsonListData[0]);
            FactoryPerPropertyDetailsModel? propertyDetailsModel = new FactoryPerPropertyDetailsModel.fromJson(jsonListData[0]);
            FactoryPerBuildingModel factoryPerBuildingModel = new FactoryPerBuildingModel.fromJson(jsonListData[0]);
           // FactoryPerDocumentDetailsModel documentDetailsModel = new FactoryPerDocumentDetailsModel.fromJson(jsonListData[0]);

            FactoryPerModel? mainModel;

            if(mstAddApplicationModel.current_tab == '0'){
              mainModel = new FactoryPerModel(applicantDetailsModel: applicantDetailsModel, factoryPerBuildingModel: null, propertyDetailsModel: null, factoryPerDocumentDetailsModel: null);
            }
            else if(mstAddApplicationModel.current_tab == '1'){
              mainModel = new FactoryPerModel(applicantDetailsModel: applicantDetailsModel, factoryPerBuildingModel: null, propertyDetailsModel: propertyDetailsModel, factoryPerDocumentDetailsModel: null);
            }
            else if(mstAddApplicationModel.current_tab == '2'){
              mainModel = new FactoryPerModel(applicantDetailsModel: applicantDetailsModel, factoryPerBuildingModel: factoryPerBuildingModel, propertyDetailsModel: propertyDetailsModel, factoryPerDocumentDetailsModel: null);
            }
            // else if(mstAddApplicationModel.current_tab == '3'){
            //mainModel = new FactoryPerModel(applicantDetailsModel: applicantDetailsModel, factoryPerBuildingModel: factoryPerBuildingModel, propertyDetailsModel: propertyDetailsModel, factoryPerDocumentDetailsModel: documentDetailsModel);
            // }
            else {
              // mainModel = null;
              mainModel = new FactoryPerModel(applicantDetailsModel: applicantDetailsModel, factoryPerBuildingModel: factoryPerBuildingModel, propertyDetailsModel: propertyDetailsModel, factoryPerDocumentDetailsModel: null);
            }

            print(jsonEncode(applicantDetailsModel));
            print(jsonEncode(propertyDetailsModel));
            print(jsonEncode(factoryPerBuildingModel));

            await DatabaseOperation.instance.updateOnlineAppData(mstAddApplicationModel.id.toString(),jsonEncode(mainModel), getCurrentDateUsingFormatter(dateFormate_dd_MM_yyyy));
            showMessageToast("Application Data Download Successfully");

            applicationList.clear();
            applicationList = await DatabaseOperation.instance.getAllMstAddApplicationModel();
            setState(() {});

          } else if (mstAddApplicationModel.cATEGORYID == '5' && mstAddApplicationModel.sERVICEID == '17') {
            RoadCuttingApplicantDetailsModel? applicantDetailsModel = new RoadCuttingApplicantDetailsModel.fromJson(jsonListData[0]);
            RoadCuttingPropertyDetailsModel? propertyDetailsModel = new RoadCuttingPropertyDetailsModel.fromJson(jsonListData[0]);
            RoadCuttingWorkModel roadCuttingWorkModel = new RoadCuttingWorkModel.fromJson(jsonListData[0]);
            // RoadCuttingDocumentDetailsModel documentDetailsModel = new RoadCuttingDocumentDetailsModel.fromJson(jsonListData[0]);

            RoadCuttingModel? mainModel;

            if(mstAddApplicationModel.current_tab == '0'){
              mainModel = new RoadCuttingModel(applicantDetailsModel: applicantDetailsModel, propertyDetailsModel: null, roadCuttingWorkModel: null, roadCuttingDocumentDetailsModel: null);
            } else if(mstAddApplicationModel.current_tab == '1'){
              mainModel = new RoadCuttingModel(applicantDetailsModel: applicantDetailsModel, propertyDetailsModel: propertyDetailsModel, roadCuttingWorkModel: null, roadCuttingDocumentDetailsModel: null);
            } else if(mstAddApplicationModel.current_tab == '2'){
              mainModel = new RoadCuttingModel(applicantDetailsModel: applicantDetailsModel, propertyDetailsModel: propertyDetailsModel, roadCuttingWorkModel: roadCuttingWorkModel, roadCuttingDocumentDetailsModel: null);
            }
            // else if(mstAddApplicationModel.current_tab == '3'){
            //mainModel = new RoadCuttingModel(applicantDetailsModel: applicantDetailsModel, propertyDetailsModel: propertyDetailsModel, roadCuttingWorkModel: roadCuttingWorkModel, roadCuttingDocumentDetailsModel: null);
            // }
            else {
              // mainModel = null;
              mainModel = new RoadCuttingModel(applicantDetailsModel: applicantDetailsModel, propertyDetailsModel: propertyDetailsModel, roadCuttingWorkModel: roadCuttingWorkModel, roadCuttingDocumentDetailsModel: null);
            }

            await DatabaseOperation.instance.updateOnlineAppData(mstAddApplicationModel.id.toString(),jsonEncode(mainModel), getCurrentDateUsingFormatter(dateFormate_dd_MM_yyyy));
            showMessageToast("Application Data Download Successfully");

            applicationList.clear();
            applicationList = await DatabaseOperation.instance.getAllMstAddApplicationModel();
            setState(() {});

          }
        }
      }
    }
    Navigator.pop(context);
  }
}

class Constants {
  static const String download = 'Download';
  static const String upload = 'Upload';

  static const List<String> choices = <String>[download, upload];
}
