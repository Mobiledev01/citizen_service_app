import 'dart:convert';

import 'package:citizen_service/HttpCalls/ApplicaitonSaveCall.dart';
import 'package:citizen_service/Model/MstAddApplicationModel.dart';
import 'package:citizen_service/Screen/HomeScreen/HomeScreen.dart';
import 'package:citizen_service/SqliteDatabase/Database.dart';
import 'package:citizen_service/Utility/Color.dart';
import 'package:citizen_service/Utility/String.dart';
import 'package:citizen_service/Utility/Style.dart';
import 'package:citizen_service/Utility/Utility.dart';
import 'package:flutter/material.dart';
import 'package:citizen_service/GlobalsVariable/GlobalsVariable.dart' as globals;

class SyncScreen extends StatefulWidget {
  const SyncScreen({Key? key}) : super(key: key);

  @override
  _SyncScreenState createState() => _SyncScreenState();
}

class _SyncScreenState extends State<SyncScreen> {
  bool isNetCon = false;
  List<MstAddApplicationModel> allApplicationList = [];
  List<MstAddApplicationModel> syncApplicationList = [];
  List<MstAddApplicationModel> pendingApplicationList = [];
  double valueIndicator = 0.0;
  int totalSyncApp = 0;
  int totalUnSyncApp = 0;
  bool indicatorShow = false;
  bool syncButtonEnable = true;
  String categoryId = '';
  String subCategoryId = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllApplication();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: WillPopScope(
        onWillPop: () async {
          if(syncButtonEnable){
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
            return false;
          }else{
            showMessageToast('Please wait until process finish...');
            return true;
          }
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()))
              },
              icon: Icon(Icons.arrow_back, color: whiteColor),
            ),
            bottom: TabBar(
              indicatorColor: whiteColor,
              tabs: [
                Tab(text: 'All'),
                Tab(text: 'Sync'),
                Tab(text: 'Pending'),
              ],
            ),
            title: Text(sync_application),
            backgroundColor:
                globals.isTrainingMode ? testModePrimaryColor : primaryColor,
            actions: [
              // isNetCon
              //     ? IconButton(
              //         icon: Icon(
              //           Icons.wifi_outlined,
              //           color: greenColor,
              //           size: 20,
              //         ),
              //         onPressed: () {},
              //       )
              //     : IconButton(
              //         icon: Icon(
              //           Icons.wifi_off_outlined,
              //           color: redColor,
              //           size: 20,
              //         ),
              //         onPressed: () {},
              //       ),
              IconButton(
                icon: Icon(
                  Icons.cloud_upload_outlined,
                  color: Colors.white,
                  size: 25,
                ),
                onPressed: () async {

                  bool? flag = await checkNetworkConnectivity();
                  if (flag!) {
                    if(syncButtonEnable){
                      syncProcess();
                    }else{
                      showMessageToast('Please wait until process finish...');
                    }
                  } else {
                    showMessageToast(no_internet);
                  }

                },
              ),
            ],
          ),
          body: TabBarView(
            children: [
              loadAllApplication(),
              loadAllSyncApplication(),
              loadAllUnSyncApplication()
            ],
          ),
        ),
      ),
    );
  }

  Widget loadAllApplication() {
    return Container(
        child: Padding(
      padding: EdgeInsets.all(8.0),
      child: allApplicationList.isEmpty
          ? Center(child: Text('No Record Found !'))
          : SingleChildScrollView(
              child: Column(
                children: [
                  indicatorShow
                      ? Padding(
                        padding: EdgeInsets.fromLTRB(5.0, 0, 5.0, 5.0),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Text('$totalSyncApp/$totalUnSyncApp')),
                      ) : SizedBox(),
                  indicatorShow
                      ? Padding(
                        padding: EdgeInsets.fromLTRB(5.0, 0, 5.0, 3.0),
                        child: LinearProgressIndicator(
                            backgroundColor: grayColor,
                            valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                            value: valueIndicator,
                            minHeight: 6,
                          ),
                      ) : SizedBox(),
                  ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      primary: true,
                      itemCount: allApplicationList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: Stack(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      allApplicationList[index].gENERATEDAPPLICATIONID.isEmpty ? allApplicationList[index].draft_id.isNotEmpty
                                          ? "#" +
                                          allApplicationList[index].draft_id.toString()
                                          : "#" +
                                          allApplicationList[index].id.toString()
                                          : "#" +
                                          allApplicationList[index].gENERATEDAPPLICATIONID,
                                      style: grayBoldText16,
                                    ),
                                    Text(
                                        getDateUsingForDate(allApplicationList[index].aPPLICATIONAPPLYDATE, 'dd/MM/yyyy', 'EEE dd MMM yyyy'),
                                        style: blackBoldText14),
                                    Text(
                                      servieceType + allApplicationList[index].aPPLICATIONNAME,
                                      style: blackNormalText14,
                                    ),
                                    Text(
                                      serviceName + allApplicationList[index].service_name,
                                      style: blackBoldText14,
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                  right: -4,
                                  top: -4,
                                  child: allApplicationList[index].aPPLICATIONSYNCSTATUS.isEmpty || allApplicationList[index].aPPLICATIONSYNCSTATUS == "N"
                                      ? allApplicationList[index].sync_message.isNotEmpty
                                          ? Padding(
                                              padding: EdgeInsets.all(5.0),
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.warning_amber_outlined,
                                                  size: 25,
                                                  color: redColor,
                                                ),
                                                tooltip:
                                                    'Error On Sync Application',
                                                onPressed: () {
                                                  displayErrorMessageApplication(allApplicationList[index]);
                                                },
                                              ),
                                            )
                                          : allApplicationList[index].final_submit_flag.isNotEmpty
                                              ? Padding(
                                                  padding: EdgeInsets.all(5.0),
                                                  child: IconButton(
                                                    icon: Icon(
                                                      Icons.pending_outlined,
                                                      size: 25,
                                                      color: orangeAccentColor,
                                                    ),
                                                    tooltip:
                                                        'Pending Sync Application',
                                                    onPressed: () {},
                                                  ),
                                                )
                                              : Card(
                                                  color: deepOrangeAccentColor,
                                                  elevation: 5,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(0),
                                                              topRight: Radius.circular(8),
                                                              bottomLeft: Radius.circular(8))),
                                                  child: Padding(
                                                    padding: EdgeInsets.all(5.0),
                                                    child: Text('Draft', style: whiteNormalText13,),
                                                  ),
                                                )
                                      : Padding(
                                          padding: EdgeInsets.all(5.0),
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.check_outlined,
                                              size: 25,
                                              color: greenColor,
                                            ),
                                            tooltip: 'Edit Application',
                                            onPressed: () {},
                                          ),
                                        ))
                            ],
                          ),
                        );
                      }),
                ],
              ),
            ),
    ));
  }

  Widget loadAllSyncApplication() {
    return Container(
        child: Padding(
      padding: EdgeInsets.all(8.0),
      child: syncApplicationList.isEmpty
          ? Center(child: Text('No Record Found !'))
          : SingleChildScrollView(
              child: Column(
                children: [
                  indicatorShow
                      ? Align(
                          alignment: Alignment.topLeft,
                          child: Text('$totalSyncApp/$totalUnSyncApp'))
                      : SizedBox(),
                  indicatorShow
                      ? LinearProgressIndicator(
                          backgroundColor: grayColor,
                          valueColor:
                              new AlwaysStoppedAnimation<Color>(Colors.red),
                          value: valueIndicator,
                          minHeight: 6,
                        )
                      : SizedBox(),
                  ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      primary: true,
                      itemCount: syncApplicationList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: Stack(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      allApplicationList[index].gENERATEDAPPLICATIONID.isEmpty
                                          ? "#" + allApplicationList[index].id.toString()
                                          : "#" + allApplicationList[index].gENERATEDAPPLICATIONID,
                                      style: grayBoldText16,
                                    ),
                                    Text(
                                        getDateUsingForDate(allApplicationList[index].aPPLICATIONAPPLYDATE, 'dd/MM/yyyy', 'EEE dd MMM yyyy'),
                                        style: blackBoldText14),
                                    Text(
                                      servieceType + allApplicationList[index].aPPLICATIONNAME,
                                      style: blackNormalText14,
                                    ),
                                    Text(
                                      serviceName + allApplicationList[index].service_name,
                                      style: blackBoldText14,
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                  right: -4,
                                  top: -4,
                                  child: syncApplicationList[index].aPPLICATIONSYNCSTATUS ==
                                          "Y" ? Padding(
                                          padding: EdgeInsets.all(5.0),
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.check_outlined,
                                              size: 25,
                                              color: greenColor,
                                            ),
                                            tooltip: 'Synced Application',
                                            onPressed: () {},
                                          ),
                                        )
                                      : SizedBox())
                            ],
                          ),
                        );
                      }),
                ],
              ),
            ),
    ));
  }

  Widget loadAllUnSyncApplication() {
    return Container(
      child: Padding(
      padding: EdgeInsets.all(8.0),
      child: pendingApplicationList.isEmpty
          ? Center(child: Text('No Record Found !'))
          : SingleChildScrollView(
              child: Column(
                children: [
                  indicatorShow
                      ? Align(
                          alignment: Alignment.topLeft,
                          child: Text('$totalSyncApp/$totalUnSyncApp'))
                      : SizedBox(),
                  indicatorShow
                      ? LinearProgressIndicator(
                          backgroundColor: grayColor,
                          valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                          value: valueIndicator,
                          minHeight: 6,
                        )
                      : SizedBox(),
                  ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      primary: true,
                      itemCount: pendingApplicationList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: Stack(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      allApplicationList[index].gENERATEDAPPLICATIONID.isEmpty ? "#" + allApplicationList[index].id.toString() : "#" + allApplicationList[index].gENERATEDAPPLICATIONID,
                                      style: grayBoldText16,
                                    ),
                                    Text(
                                        getDateUsingForDate(allApplicationList[index].aPPLICATIONAPPLYDATE, 'dd/MM/yyyy', 'EEE dd MMM yyyy'),
                                        style: blackBoldText14),
                                    Text(
                                      servieceType + allApplicationList[index].aPPLICATIONNAME,
                                      style: blackNormalText14,
                                    ),
                                    Text(
                                      serviceName +
                                          allApplicationList[index].service_name,
                                      style: blackBoldText14,
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                  right: -4,
                                  top: -4,
                                  child: pendingApplicationList[index].aPPLICATIONSYNCSTATUS.isEmpty || pendingApplicationList[index].aPPLICATIONSYNCSTATUS == "N" ? pendingApplicationList[index].sync_message.isNotEmpty
                                          ? Padding(
                                              padding: EdgeInsets.all(5.0),
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.warning_amber_outlined,
                                                  size: 25,
                                                  color: redColor,
                                                ),
                                                tooltip: 'Error On Sync Application',
                                                onPressed: () {
                                                  displayErrorMessageApplication(allApplicationList[index]);
                                                },
                                              ),
                                            )
                                          : allApplicationList[index].final_submit_flag.isNotEmpty
                                              ? Padding(
                                                  padding: EdgeInsets.all(5.0),
                                                  child: IconButton(
                                                    icon: Icon(
                                                      Icons.pending_outlined,
                                                      size: 25,
                                                      color: orangeAccentColor,
                                                    ),
                                                    tooltip: 'Pending Sync Application',
                                                    onPressed: () {},
                                                  ),
                                                )
                                              : Card(
                                                  color: deepOrangeAccentColor,
                                                  elevation: 5,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius.circular(0),
                                                              topRight: Radius.circular(8),
                                                              bottomLeft: Radius.circular(8))),
                                                  child: Padding(
                                                    padding: EdgeInsets.all(5.0),
                                                    child: Text(
                                                      'Draft',
                                                      style: whiteNormalText13,
                                                    ),
                                                  ),
                                                )
                                      : SizedBox())
                            ],
                          ),
                        );
                      }),
                ],
              ),
            ),
    ));
  }

  void displayErrorMessageApplication(MstAddApplicationModel mstAddApplicationModel) {
    // set up the button
    Widget okButton = TextButton(
      child: Text(ok),
      onPressed: () async {
        Navigator.pop(context);
      },
    );

    String str = mstAddApplicationModel.sync_message;
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

  void checkProgress(bool flag, String id) async {
    if (flag) {
      await DatabaseOperation.instance.updateSyncApplicationStatus(id);
      setState(() {
        totalSyncApp = totalSyncApp + 1;
        valueIndicator = totalSyncApp / totalUnSyncApp;
      });

      if (totalSyncApp == totalUnSyncApp) {
        showMessageToast('Sync Successfully...');
        getAllApplicationData();
      }
    } else {
      setState(() {
        syncButtonEnable = true;
      });
      showMessageToast('Something went wrong !!');
    }
  }

  void getAllApplication() async {
    allApplicationList = await DatabaseOperation.instance.getAllApplicationModel();
    syncApplicationList = await DatabaseOperation.instance.getAllSyncApplication();
    pendingApplicationList = await DatabaseOperation.instance.getAllPendingApplication();
    // totalUnSyncApp = await DatabaseOperation.instance.getAllUnSyncApplicationCount();
    totalUnSyncApp = pendingApplicationList.length;
    setState(() {});
  }

  void getAllApplicationData() async {
    allApplicationList = await DatabaseOperation.instance.getAllApplicationModel();
    syncApplicationList = await DatabaseOperation.instance.getAllSyncApplication();
    pendingApplicationList = await DatabaseOperation.instance.getAllPendingApplication();
  }

  void syncProcess() async {

    if (pendingApplicationList.isNotEmpty) {
      setState(() {
        syncButtonEnable = false;
      });
    }

    Future.delayed(Duration.zero, () {});

    if(pendingApplicationList.isNotEmpty){

      for (var i = 0; i < pendingApplicationList.length; i++) {
        MstAddApplicationModel? model = pendingApplicationList[i];

        if (model.aPPLICATIONSYNCSTATUS == 'N' && model.final_submit_flag == 'Y' && model.aPPLICATIONDATA.isNotEmpty) {

          if(!indicatorShow){
            setState(() {
              indicatorShow = true;
            });
          }

          Future.delayed(Duration.zero, () {});

          categoryId = model.cATEGORYID;
          subCategoryId = model.sERVICEID;

          print(categoryId);
          print(subCategoryId);

          if (categoryId == '2') {
            // Building Category
            if (subCategoryId == '4') {
              var flag = await saveDCWaterConnectionDetails(model);
              checkProgress(flag, model.id.toString());
            } else if (subCategoryId == '3') {
              var flag = await saveWaterConnectionDetails(model);
              checkProgress(flag, model.id.toString());
            } else if (subCategoryId == '2') {
              var flag = await saveBuildingLicenseScreenDetails(model);
              checkProgress(flag, model.id.toString());
            } else if (subCategoryId == '6') {
              //Form9
            } else if (subCategoryId == '7') {
              var flag = await saveOccupancyCertificateDetails(model);
              checkProgress(flag, model.id.toString());
            } else {
              showMessageToast('Coming soon');
            }
          } else if (categoryId == '4') {
            // Maintenance Category
            if (subCategoryId == '12') {
              var flag = await saveDrinkingWater(model);
              checkProgress(flag, model.id.toString());
            } else if (subCategoryId == '13') {
              var flag = await saveStreetlight(model);
              checkProgress(flag, model.id.toString());
            } else if (subCategoryId == '14') {
              var flag = await saveVillageSanitation(model);
              checkProgress(flag, model.id.toString());
            } else {
              showMessageToast('Coming soon');
            }
          } else if (categoryId == '5') {
            // OtherScreen Category
            if (subCategoryId == '18') {
              var flag = await saveEnmtLicenseDetails(model);
              checkProgress(flag, model.id.toString());
            } else if (subCategoryId == '16') {
              var flag = await saveIssuanceOfNocEscomsDetails(model);
              checkProgress(flag, model.id.toString());
            } else if (subCategoryId == '15') {
              //IssuanceOfRecords
            } else if (subCategoryId == '17') {
              var flag = await saveRoadCuttingPerDetails(model);
              checkProgress(flag, model.id.toString());
            } else {
              showMessageToast('Coming soon');
            }
          } else if (categoryId == '3') {
            // Trade Category
            if (subCategoryId == '11') {
              var flag = await saveAdvertisementLicenseDetails(model);
              checkProgress(flag, model.id.toString());
            } else if (subCategoryId == '10') {
              var flag = await saveFactoryClearanceDetails(model);
              checkProgress(flag, model.id.toString());
            } else if (subCategoryId == '9') {
              var flag = await saveBusinessLicenseDetails(model);
              checkProgress(flag, model.id.toString());
            } else {
              showMessageToast('Coming soon');
            }
          } else {
            showMessageToast('No data found !');
            setState(() {
              syncButtonEnable = true;
            });
          }
        }
      }

    } else {
      showMessageToast('No data found !');
      setState(() {
        syncButtonEnable = true;
      });
    }

  }
}
