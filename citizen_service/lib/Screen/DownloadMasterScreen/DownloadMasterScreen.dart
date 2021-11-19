import 'dart:convert';

import 'package:citizen_service/HttpCalls/HttpCall.dart';
import 'package:citizen_service/Screen/HomeScreen/HomeScreen.dart';
import 'package:citizen_service/Utility/Color.dart';
import 'package:citizen_service/Utility/String.dart';
import 'package:citizen_service/Utility/Utility.dart';

import 'package:flutter/material.dart';
import 'package:citizen_service/GlobalsVariable/GlobalsVariable.dart'
    as globals;

class DownloadMasterScreen extends StatefulWidget {
  const DownloadMasterScreen({Key? key}) : super(key: key);

  @override
  _DownloadMasterScreenState createState() => _DownloadMasterScreenState();
}

class _DownloadMasterScreenState extends State<DownloadMasterScreen> {

  bool isNetCon = false;
  bool isAllMasterSync = false;
  // bool isAllMasterStatus=false;
  bool isAllDistrictSync = false;
  bool isAllTalukaSync = false;
  bool isAllGramPanchayatSync = false;
  bool isAllVillageSync = false;

  String districtMsg = '';
  String talukaMsg = '';
  String panchayatMsg = '';
  String villageMsg = '';

  int totalMasterApi = 28;
  int downloadMasterApi = 0;


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
          if(isAllMasterSync || isAllDistrictSync || isAllTalukaSync || isAllGramPanchayatSync || isAllVillageSync){
            showMessageToast('Please wait until process finish..');
            return false;
          } else{
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => HomeScreen()));
            return true;
          }
      },
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => {
                      if(isAllMasterSync || isAllDistrictSync || isAllTalukaSync || isAllGramPanchayatSync || isAllVillageSync) {
                        showMessageToast('Please wait until process finish..')
                      } else {
                        Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()))
                      }
              },
              icon: Icon(Icons.arrow_back, color: whiteColor),
            ),
            title: Text(download_master_data),
            backgroundColor: globals.isTrainingMode ? testModePrimaryColor : primaryColor,
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
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Container(
                    height: 95,
                    child: Card(
                      elevation: 6,
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: isAllMasterSync
                              ? Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation(whiteColor),
                                  ),
                                )
                              : Icon(
                                  Icons.download_outlined,
                                  color: whiteColor,
                                ),
                          backgroundColor: primaryColor,
                        ),
                        title: Text('Get All Master Data'),
                        subtitle: Text(downloadMasterApi.toString()+'/'+totalMasterApi.toString()),
                        trailing: isAllMasterSync ? SizedBox() :
                        IconButton(
                          icon: Icon(
                            Icons.download_sharp,
                            size: 30,
                          ),
                          onPressed: () async {
                            bool? flag = await checkNetworkConnectivity();
                            if(flag!){
                              getAllMasterDataApiCall();
                            }else{
                              showMessageToast(no_internet);
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                 Container(
                    height: 95,
                    child: Card(
                      elevation: 6,
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        leading: CircleAvatar(
                        child: isAllDistrictSync
                            ? Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation(whiteColor),
                                ),
                              )
                            : Icon(
                                Icons.download_outlined,
                                color: whiteColor,
                              ),
                        backgroundColor: primaryColor,
                      ),
                      title: Text('Get All District'),
                        subtitle: Text(districtMsg),
                        trailing: isAllDistrictSync ? SizedBox() : IconButton(
                          icon: Icon(
                            Icons.download_sharp,
                            size: 30,
                          ),
                          onPressed: () async {
                            bool? flag = await checkNetworkConnectivity();
                            if(flag! && !isAllDistrictSync){
                              getAllDistrict();
                            }else{
                              showMessageToast(no_internet);
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                 Container(
                    height: 95,
                    child: Card(
                      elevation: 6,
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: isAllTalukaSync
                              ? Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation(whiteColor),
                            ),
                          )
                              : Icon(
                            Icons.download_outlined,
                            color: whiteColor,
                          ),
                          backgroundColor: primaryColor,
                        ),
                        title: Text('Get All Taluka'),
                        subtitle: Text(talukaMsg),
                        trailing: isAllTalukaSync ? SizedBox() : IconButton(
                          icon: Icon(
                            Icons.download_sharp,
                            size: 30,
                          ),
                          onPressed: () async {
                            bool? flag = await checkNetworkConnectivity();
                            if(flag! && !isAllTalukaSync){
                              getAllTaluka();
                            }else{
                              showMessageToast(no_internet);
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                 Container(
                    height: 95,
                    child: Card(
                      elevation: 6,
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: isAllGramPanchayatSync
                              ? Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation(whiteColor),
                            ),
                          )
                              : Icon(
                            Icons.download_outlined,
                            color: whiteColor,
                          ),
                          backgroundColor: primaryColor,
                        ),
                        title: Text('Get All GramPanchayat'),
                        subtitle: Text(panchayatMsg),
                        trailing: isAllGramPanchayatSync ? SizedBox() : IconButton(
                          icon: Icon(
                            Icons.download_sharp,
                            size: 30,
                          ),
                          onPressed: () async {
                            bool? flag = await checkNetworkConnectivity();
                            if(flag! && !isAllGramPanchayatSync){
                              getAllGramPanchayat();
                            }else{
                              showMessageToast(no_internet);
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                Container(
                    height: 95,
                    child: Card(
                      elevation: 6,
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: isAllVillageSync
                              ? Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation(whiteColor),
                            ),
                          )
                              : Icon(
                            Icons.download_outlined,
                            color: whiteColor,
                          ),
                          backgroundColor: primaryColor,
                        ),
                        title: Text('Get All Village'),
                        subtitle: Text(villageMsg),
                        trailing: isAllVillageSync ? SizedBox() : IconButton(
                          icon: Icon(
                            Icons.download_sharp,
                            size: 30,
                          ),
                          onPressed: () async {
                            bool? flag = await checkNetworkConnectivity();
                            if(flag! && !isAllVillageSync){
                              getAllVillage();
                            }else{
                              showMessageToast(no_internet);
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ),
    );
  }

  void getAllMasterDataApiCall() async {
    bool flag = true;

    var data = {};
    setState(() {
      isAllMasterSync = true;
      totalMasterApi = 28;
      downloadMasterApi = 0;
    });

    var map = (await httpPostDropDownMasterCall('/ajax/getMasterServiceList?service_name=getMstPurNewWaterConn', jsonEncode(data), '2','3', 'getMstPurNewWaterConn'));

    flag = map;
    isAllMasterSync = map;

    if (flag) {
      downloadMasterApi = downloadMasterApi + 1;
      setState(() {});
      var map = (await httpPostDropDownMasterCall('/ajax/getMasterServiceList?service_name=getMstProblemDetails', jsonEncode(data), '4','12', 'getMstProblemDetails'));

      flag = map;
      isAllMasterSync = map;
    }

    flag = map;
    isAllMasterSync = map;

    if (flag) {
      downloadMasterApi = downloadMasterApi + 1;
      setState(() {});
      var map = (await httpPostDropDownMasterCall('/ajax/getMasterServiceList?service_name=getMstWaterTariffData', jsonEncode(data), '2','3', 'getMstWaterTariffData'));

      flag = map;
      isAllMasterSync = map;
    }


    if (flag) {
      downloadMasterApi = downloadMasterApi + 1;
      setState(() {});
      var map = (await httpPostDropDownMasterCall('/ajax/getMasterServiceList?service_name=getMSTTradeSubTypeData', jsonEncode(data), '3','9', 'getMSTTradeSubTypeData'));

      flag = map;
      isAllMasterSync = map;
    }

    if (flag) {
      downloadMasterApi = downloadMasterApi + 1;
      setState(() {});
      var map = (await httpPostDropDownMasterCall('/ajax/getMasterServiceList?service_name=getMSTTradeTypeData', jsonEncode(data), '3','9', 'getMSTTradeTypeData'));

      flag = map;
      isAllMasterSync = map;
    }


    if (flag) {
      downloadMasterApi = downloadMasterApi + 1;
      setState(() {});
      var map = (await httpPostDropDownMasterCall('/ajax/getMasterServiceList?service_name=getMstPurposeData', jsonEncode(data), '2','2', 'getMstPurposeData'));

      flag = map;
      isAllMasterSync = map;
    }

    if (flag) {
      downloadMasterApi = downloadMasterApi + 1;
      setState(() {});
      var map = (await httpPostDropDownMasterCall('/ajax/getMasterServiceList?service_name=getMstBuildingConstructionData', jsonEncode(data), '2','2', 'getMstBuildingConstructionData'));

      flag = map;
      isAllMasterSync = map;
    }


    if (flag) {
      downloadMasterApi = downloadMasterApi + 1;
      setState(() {});
      var map = (await httpPostDropDownMasterCall('/ajax/getMasterServiceList?service_name=getMstDirectionDoorConstData', jsonEncode(data), '2','2', 'getMstDirectionDoorConstData'));

      flag = map;
      isAllMasterSync = map;
    }

    if (flag) {
      downloadMasterApi = downloadMasterApi + 1;
      setState(() {});
      var map = (await httpPostDropDownMasterCall('/ajax/getMasterServiceList?service_name=getMstFactoryTypeData', jsonEncode(data), '3','10', 'getMstFactoryTypeData'));

      flag = map;
      isAllMasterSync = map;
    }

    if (flag) {
      downloadMasterApi = downloadMasterApi + 1;
      setState(() {});
      var map = (await httpPostDropDownMasterCall('/ajax/getMasterServiceList?service_name=getMstAdvtBoardTypeData', jsonEncode(data), '3','11', 'getMstAdvtBoardTypeData'));

      flag = map;
      isAllMasterSync = map;
    }

    if (flag) {
      downloadMasterApi = downloadMasterApi + 1;
      setState(() {});
      var map = (await httpPostDropDownMasterCall('/ajax/getMasterServiceList?service_name=getMstAdvtBoardSizeData', jsonEncode(data), '3','11', 'getMstAdvtBoardSizeData'));

      flag = map;
      isAllMasterSync = map;
    }

    if (flag) {
      downloadMasterApi = downloadMasterApi + 1;
      setState(() {});
      var map = (await httpPostDropDownMasterCall('/ajax/getMasterServiceList?service_name=getMstProblemDetails', jsonEncode(data), '4','12', 'getMstProblemDetails'));

      flag = map;
      isAllMasterSync = map;
    }

    if (flag) {
      downloadMasterApi = downloadMasterApi + 1;
      setState(() {});
      var map = (await httpPostDropDownMasterCall('/ajax/getMasterServiceList?service_name=getMstInfoRequiredData', jsonEncode(data), '5','15', 'getMstInfoRequiredData'));

      flag = map;
      isAllMasterSync = map;
    }

    if (flag) {
      downloadMasterApi = downloadMasterApi + 1;
      setState(() {});
      var map = (await httpPostDropDownMasterCall('/ajax/getMasterServiceList?service_name=getMstEntertProgTypeData', jsonEncode(data), '5','18', 'getMstEntertProgTypeData'));

      flag = map;
      isAllMasterSync = map;
    }

    if (flag) {
      downloadMasterApi = downloadMasterApi + 1;
      setState(() {});
      var data = {
        "CATEGORY_ID":"2",
        "SUB_CATEGORY_ID":"3"
      };
      var map = (await httpPostDropDownMasterCall('/ajax/getMasterServiceList?service_name=getMstDocData',
          jsonEncode(data), '2','3', 'getMstDocData'));

      flag = map;
      isAllMasterSync = map;
    }


    if (flag) {
      downloadMasterApi = downloadMasterApi + 1;
      setState(() {});
      var data = {
        "CATEGORY_ID":"2",
        "SUB_CATEGORY_ID":"2"
      };
      var map = (await httpPostDropDownMasterCall('/ajax/getMasterServiceList?service_name=getMstDocData',
          jsonEncode(data), '2','2', 'getMstDocData'));

      flag = map;
      isAllMasterSync = map;
    }



    if (flag) {
      downloadMasterApi = downloadMasterApi + 1;
      setState(() {});
      var data = {
        "CATEGORY_ID":"2",
        "SUB_CATEGORY_ID":"7"
      };
      var map = (await httpPostDropDownMasterCall('/ajax/getMasterServiceList?service_name=getMstDocData',
          jsonEncode(data), '2','7', 'getMstDocData'));

      flag = map;
      isAllMasterSync = map;
    }

    if (flag) {
      downloadMasterApi = downloadMasterApi + 1;
      setState(() {});
      var data = {
        "CATEGORY_ID":"2",
        "SUB_CATEGORY_ID":"4"
      };
      var map = (await
      httpPostDropDownMasterCall('/ajax/getMasterServiceList?service_name=getMstDocData',
          jsonEncode(data), '2','4', 'getMstDocData'));

      flag = map;
      isAllMasterSync = map;
    }




    if (flag) {
      downloadMasterApi = downloadMasterApi + 1;
      setState(() {});
      var data = {
        "CATEGORY_ID":"4",
        "SUB_CATEGORY_ID":"14"
      };
      var map = (await httpPostDropDownMasterCall('/ajax/getMasterServiceList?service_name=getMstDocData',
          jsonEncode(data), '2','14', 'getMstDocData'));

      flag = map;
      isAllMasterSync = map;
    }

    if (flag) {
      downloadMasterApi = downloadMasterApi + 1;
      setState(() {});
      var data = {
        "CATEGORY_ID":"4",
        "SUB_CATEGORY_ID":"13"
      };
      var map = (await httpPostDropDownMasterCall('/ajax/getMasterServiceList?service_name=getMstDocData',
          jsonEncode(data), '4','13', 'getMstDocData'));

      flag = map;
      isAllMasterSync = map;
    }

    if (flag) {
      downloadMasterApi = downloadMasterApi + 1;
      setState(() {});
      var data = {
        "CATEGORY_ID":"4",
        "SUB_CATEGORY_ID":"12"
      };
      var map = (await httpPostDropDownMasterCall('/ajax/getMasterServiceList?service_name=getMstDocData',
          jsonEncode(data), '4','12', 'getMstDocData'));

      flag = map;
      isAllMasterSync = map;
    }



    if (flag) {
      downloadMasterApi = downloadMasterApi + 1;
      setState(() {});
      var data = {
        "CATEGORY_ID":"5",
        "SUB_CATEGORY_ID":"15"
      };
      var map = (await httpPostDropDownMasterCall('/ajax/getMasterServiceList?service_name=getMstDocData',
          jsonEncode(data), '5','15', 'getMstDocData'));

      flag = map;
      isAllMasterSync = map;
    }

    if (flag) {
      downloadMasterApi = downloadMasterApi + 1;
      setState(() {});
      var data = {
        "CATEGORY_ID":"5",
        "SUB_CATEGORY_ID":"16"
      };
      var map = (await httpPostDropDownMasterCall('/ajax/getMasterServiceList?service_name=getMstDocData',
          jsonEncode(data), '5','16', 'getMstDocData'));

      flag = map;
      isAllMasterSync = map;
    }

    if (flag) {
      downloadMasterApi = downloadMasterApi + 1;
      setState(() {});
      var data = {
        "CATEGORY_ID":"5",
        "SUB_CATEGORY_ID":"17"
      };
      var map = (await httpPostDropDownMasterCall('/ajax/getMasterServiceList?service_name=getMstDocData',
          jsonEncode(data), '5','17', 'getMstDocData'));

      flag = map;
      isAllMasterSync = map;
    }
    if (flag) {
      downloadMasterApi = downloadMasterApi + 1;
      setState(() {});
      var data = {
        "CATEGORY_ID":"5",
        "SUB_CATEGORY_ID":"18"
      };
      var map = (await httpPostDropDownMasterCall('/ajax/getMasterServiceList?service_name=getMstDocData',
          jsonEncode(data), '5','18', 'getMstDocData'));

      flag = map;
      isAllMasterSync = map;
    }




    if (flag) {
      downloadMasterApi = downloadMasterApi + 1;
      setState(() {});
      var data = {
        "CATEGORY_ID":"3",
        "SUB_CATEGORY_ID":"10"
      };
      var map = (await httpPostDropDownMasterCall('/ajax/getMasterServiceList?service_name=getMstDocData',
          jsonEncode(data), '3','10', 'getMstDocData'));

      flag = map;
      isAllMasterSync = map;
    }
    if (flag) {
      downloadMasterApi = downloadMasterApi + 1;
      setState(() {});
      var data = {
        "CATEGORY_ID":"3",
        "SUB_CATEGORY_ID":"9"
      };
      var map = (await httpPostDropDownMasterCall('/ajax/getMasterServiceList?service_name=getMstDocData',
          jsonEncode(data), '3','9', 'getMstDocData'));

      flag = map;
      isAllMasterSync = map;
    }
    if (flag) {
      downloadMasterApi = downloadMasterApi + 1;
      setState(() {});
      var data = {
        "CATEGORY_ID":"3",
        "SUB_CATEGORY_ID":"11"
      };
      var map = (await httpPostDropDownMasterCall('/ajax/getMasterServiceList?service_name=getMstDocData',
          jsonEncode(data), '3','11', 'getMstDocData'));

      flag = map;
      isAllMasterSync = map;
    }
    if (flag) {
      downloadMasterApi = downloadMasterApi + 1;
      setState(() {});
      var map = (await httpPostDropDownMasterCall('/ajax/getMasterServiceList?service_name=getMstProblemDetails', jsonEncode(data), '3','9', 'getMstProblemDetails'));
      flag = map;
      isAllMasterSync = map;
    }

    if(totalMasterApi >= downloadMasterApi){
      isAllMasterSync = false;
      flag = false;
      addPreference('isDownloadAllMasters', 'Y');
    }
    else if(downloadMasterApi==0)
      {
       addPreference('isDownloadAllMasters', 'N');
      }
    if (mounted)
    setState(() {});
  }
  void getAllDistrict() async {
    setState(() {
      isAllDistrictSync = true;
      districtMsg = 'Please wait for a while...';
    });

    var map = (await httpPostDistrictCall());
    if (map) {
      isAllDistrictSync = false;
      districtMsg = 'Success';
      addPreference('isDownloadDistrict', 'Y');

    } else {
      districtMsg = 'Something Went Wrong !';
      addPreference('isDownloadDistrict', 'N');

    }
    if (mounted)
    setState(() {    });
  }

  void getAllTaluka() async{
    setState(() {
      isAllTalukaSync = true;
      talukaMsg = 'Please wait for a while...';
    });

    var map = (await httpPostTalukaCall());
    if (map) {
      isAllTalukaSync = false;
      talukaMsg = 'Success';
      addPreference('isDownloadTaluka', 'Y');
    } else {
      talukaMsg = 'Something Went Wrong !';
      addPreference('isDownloadTaluka', 'N');
    }
    if (mounted)
    setState(() {    });
  }

  void getAllGramPanchayat() async {
    setState(() {
      isAllGramPanchayatSync = true;
      panchayatMsg = 'Please wait for a while...';
    });

    var map = (await httpPostPanchayatCall());
    if (map) {
      isAllGramPanchayatSync = false;
      panchayatMsg = 'Success';
      addPreference('isDownloadGramPanchayat', 'Y');
    } else {
      panchayatMsg = 'Something Went Wrong !';
      addPreference('isDownloadGramPanchayat', 'N');
    }
    if (mounted)
    setState(() {    });
  }

  void getAllVillage() async {
    setState(() {
      isAllVillageSync = true;
      villageMsg = 'Please wait for a while...';
    });

    var map = (await httpPostVillageCall());
    if (map) {
      isAllVillageSync = false;
      villageMsg = 'Success';
      addPreference('isDownloadVillage', 'Y');
    } else {
      villageMsg = 'Something Went Wrong !';
      addPreference('isDownloadVillage', 'N');
    }
    if (mounted)
    setState(() {    });
  }


}
