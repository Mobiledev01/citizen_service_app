import 'dart:convert';
import 'package:citizen_service/HttpCalls/HttpCallForAllApplication.dart';
import 'package:citizen_service/Model/MstAddApplicationModel.dart';
import 'package:citizen_service/Model/MstAppDocumentModel.dart';
import 'package:citizen_service/SqliteDatabase/Database.dart';
import 'package:citizen_service/GlobalsVariable/GlobalsVariable.dart'
as globals;
import 'package:intl/intl.dart';

Future<bool> saveWaterConnectionDetails(MstAddApplicationModel model) async {
  var jsonData = jsonDecode(model.aPPLICATIONDATA);
  bool flag = true;

  if (model.sync_tab.isEmpty && jsonData.containsKey('1') && jsonData["1"] != null) {
    var jsonObject = jsonData["1"];
    if(model.from_web.isNotEmpty && model.draft_id.isNotEmpty){
      jsonObject['trn_cs_appl_id'] = model.draft_id;
    }
    flag = await syncSubTab(
        jsonObject, "saveApplicantDetail/"+globals.loginSessionModel!.citizenRegistrationId!, model.id.toString(), "0");
  } else {
    flag = false;
  }

  String id = model.draft_id.isNotEmpty
      ? model.draft_id
      : await DatabaseOperation.instance
          .getApplicationGeneratedIdUsingID(model.id.toString());

  if ((flag || model.sync_tab == "0") &&
      jsonData.containsKey('2') &&
      jsonData["2"] != null &&
      id.isNotEmpty) {
    var jsonObject = jsonData["2"];
    jsonObject['trn_cs_appl_id'] = id;
    flag = await syncSubTab(
        jsonObject, "savePropertyVillageData/"+globals.loginSessionModel!.citizenRegistrationId!, model.id.toString(), "1");
  } else {
    flag = false;
  }

  if ((flag || model.sync_tab == "1") &&
      jsonData.containsKey('3') &&
      jsonData["3"] != null &&
      id.isNotEmpty) {
    var jsonObject = jsonData["3"];
    jsonObject['trn_cs_appl_id'] = id;
    flag = await syncSubTab(
        jsonObject, "savewaterConnectionData/"+globals.loginSessionModel!.citizenRegistrationId!, model.id.toString(), "2");
  } else {
    flag = false;
  }

  if ((flag || model.sync_tab == "2") && jsonData.containsKey('4') && jsonData["4"] != null && id.isNotEmpty) {
    // var jsonObject = jsonData["4"];
    // jsonObject['trn_cs_appl_id'] = id;

    List<MstAppDocumentModel> docList = await DatabaseOperation.instance.getAllDocument(model.id.toString());

    if(docList.length > 0){
      for(int z=0;z<docList.length;z++){
        var jsonData = {
          'doc_temp':docList[z].document_path,
          'doc_type_id':docList[z].document_id,
          'doc_description':docList[z].document_description,
          'trn_cs_appl_id':id,
        };
        print(jsonEncode(jsonData));
        flag = await syncTabWithDoc(jsonData, "saveDocumentData/"+globals.loginSessionModel!.citizenRegistrationId!, model.id.toString(), "3",docList[z].id.toString());
      }
      if (flag) {
        await DatabaseOperation.instance.updateSyncTabStatus(model.id.toString(), "3");
        await DatabaseOperation.instance.updateSyncMessageStatus(model.id.toString(), '');
      }
    }else{
      flag = false;
    }

  } else {
    flag = false;
  }

  if ((flag || model.sync_tab == "3") && id.isNotEmpty) {
    var jsonObject = {'trn_cs_appl_id' : id};
    flag = await syncSubTab(jsonObject, "saveDetailwaterConnectionData/"+globals.loginSessionModel!.citizenRegistrationId! , model.id.toString(), "F");
  } else {
    flag = false;
  }

  return flag;
}

//KASIM START
Future<bool> saveDCWaterConnectionDetails(MstAddApplicationModel model) async {
  var jsonData = jsonDecode(model.aPPLICATIONDATA);
  bool flag = true;
  if (model.sync_tab.isEmpty &&
      jsonData.containsKey('1') &&
      jsonData["1"] != null) {
    var jsonObject = jsonData["1"];
    if(model.from_web.isNotEmpty && model.draft_id.isNotEmpty){
      jsonObject['trn_cs_appl_id'] = model.draft_id;
    }
    flag = await syncSubTab(jsonObject,
        "saveWaterDisconnectingApplicantDetail/"+globals.loginSessionModel!.citizenRegistrationId!, model.id.toString(), "0");
  } else {
    flag = false;
  }

  String id = model.draft_id.isNotEmpty
      ? model.draft_id
      : await DatabaseOperation.instance
      .getApplicationGeneratedIdUsingID(model.id.toString());

  if ((flag || model.sync_tab == "0") &&
      jsonData.containsKey('2') &&
      jsonData["2"] != null &&
      id.isNotEmpty) {
    var jsonObject = jsonData["2"];
    jsonObject['trn_cs_appl_id'] = id;
    print(id);
    flag = await syncSubTab(jsonObject,
        "saveWaterDisconnectingPropertyDetail/"+globals.loginSessionModel!.citizenRegistrationId!, model.id.toString(), "1");
  } else {
    flag = false;
  }

  if ((flag || model.sync_tab == "1") && jsonData.containsKey('3') && jsonData["3"] != null && id.isNotEmpty) {
    // var jsonObject = jsonData["3"];
    // jsonObject['trn_cs_appl_id'] = id;

    List<MstAppDocumentModel> docList = await DatabaseOperation.instance.getAllDocument(model.id.toString());

    if(docList.length > 0){
      for(int z=0;z<docList.length;z++){
        var jsonData = {
          'doc_temp':docList[z].document_path,
          'doc_type_id':docList[z].document_id,
          'doc_description':docList[z].document_description,
          'trn_cs_appl_id':id,
        };
        print(jsonEncode(jsonData));
        flag = await syncTabWithDoc(jsonData, "saveWaterDisconnectingUploadData/"+globals.loginSessionModel!.citizenRegistrationId!, model.id.toString(), "3",docList[z].id.toString());
      }
      if (flag) {
        await DatabaseOperation.instance.updateSyncTabStatus(model.id.toString(), "3");
        await DatabaseOperation.instance.updateSyncMessageStatus(model.id.toString(), '');
      }
    }else{
      flag = false;
    }

  } else {
    flag = false;
  }
  if ((flag || model.sync_tab == "3") && id.isNotEmpty) {
    var jsonObject = {'trn_cs_appl_id' : id};
    flag = await syncSubTab(jsonObject, "saveFinalDisconnectingData/"+globals.loginSessionModel!.citizenRegistrationId!, model.id.toString(), "F");
  } else {
    flag = false;
  }

  return flag;
}

Future<bool> saveOccupancyCertificateDetails(
    MstAddApplicationModel model) async {
  var jsonData = jsonDecode(model.aPPLICATIONDATA);
  bool flag = true;

  if (model.sync_tab.isEmpty && jsonData.containsKey('1') && jsonData["1"] != null) {
    var jsonObject = jsonData["1"];
    if(model.from_web.isNotEmpty && model.draft_id.isNotEmpty){
      jsonObject['trn_cs_appl_id'] = model.draft_id;
    }
    flag = await syncSubTab(jsonObject, "saveOccuCertificateAppdetail/"+globals.loginSessionModel!.citizenRegistrationId!, model.id.toString(), "0");
  } else {
    flag = false;
  }

 String id = model.draft_id.isNotEmpty
      ? model.draft_id
      : await DatabaseOperation.instance
          .getApplicationGeneratedIdUsingID(model.id.toString());

  if ((flag || model.sync_tab == "0") && jsonData.containsKey('2') && jsonData["2"] != null && id.isNotEmpty) {
    var jsonObject = jsonData["2"];
    jsonObject['trn_cs_appl_id'] = id;
    print(id);
    flag = await syncSubTab(jsonObject, "saveOccuCertificatePropDetail/"+globals.loginSessionModel!.citizenRegistrationId!,
        model.id.toString(), "1");
  } else {
    flag = false;
  }

  if ((flag || model.sync_tab == "1") && jsonData.containsKey('3') && jsonData["3"] != null && id.isNotEmpty) {
    var jsonObject = jsonData["3"];
    jsonObject['trn_cs_appl_id'] = id;
    print(id);
    flag = await syncSubTab(jsonObject, "saveOccuCertificateLicDetail/"+globals.loginSessionModel!.citizenRegistrationId!,
        model.id.toString(), "2");
  } else {
    flag = false;
  }

  if ((flag || model.sync_tab == "2") && jsonData.containsKey('4') && jsonData["4"] != null && id.isNotEmpty) {
    List<MstAppDocumentModel> docList = await DatabaseOperation.instance.getAllDocument(model.id.toString());

    if(docList.length > 0){
      for(int z=0;z<docList.length;z++){
        var jsonData = {
          'doc_temp':docList[z].document_path,
          'doc_type':docList[z].document_id,
          'doc_desc':docList[z].document_description,
          'trn_cs_appl_id':id,
        };
        print(jsonEncode(jsonData));
        flag = await syncTabWithDoc(jsonData, "saveOccuCertificateDocDetail/"+globals.loginSessionModel!.citizenRegistrationId!, model.id.toString(), "3",docList[z].id.toString());
      }
      if (flag) {
        await DatabaseOperation.instance.updateSyncTabStatus(model.id.toString(), "3");
        await DatabaseOperation.instance.updateSyncMessageStatus(model.id.toString(), '');
      }
    }else{
      flag = false;
    }
  } else {
    flag = false;
  }

  if ((flag || model.sync_tab == "3") && id.isNotEmpty) {
    var jsonObject = {'trn_cs_appl_id' : id};
    flag = await syncSubTab(jsonObject, "saveDetailOccupCertificateData/"+globals.loginSessionModel!.citizenRegistrationId!, model.id.toString(), "F");
  } else {
    flag = false;
  }

  return flag;
}

Future<bool> saveBuildingLicenseScreenDetails(MstAddApplicationModel model) async {
  var jsonData = jsonDecode(model.aPPLICATIONDATA);
  bool flag = true;

  if (model.sync_tab.isEmpty &&
      jsonData.containsKey('1') &&
      jsonData["1"] != null) {
    var jsonObject = jsonData["1"];
    if(model.from_web.isNotEmpty && model.draft_id.isNotEmpty){
      jsonObject['trn_cs_appl_id'] = model.draft_id;
    }
    flag = await syncSubTab(
        jsonObject, "saveBuildLicAppData/"+globals.loginSessionModel!.citizenRegistrationId!, model.id.toString(), "0");
  }
  else {
    flag = false;
  }

  String id = model.draft_id.isNotEmpty
      ? model.draft_id
      : await DatabaseOperation.instance
      .getApplicationGeneratedIdUsingID(model.id.toString());

  if ((flag || model.sync_tab == "0") &&
      jsonData.containsKey('2') &&
      jsonData["2"] != null &&
      id.isNotEmpty) {
    var jsonObject = jsonData["2"];
    jsonObject['trn_cs_appl_id'] = id;
    print(id);
    flag = await syncSubTab(
        jsonObject, "saveBuildLicPropData/"+globals.loginSessionModel!.citizenRegistrationId!, model.id.toString(), "1");
  } else {
    flag = false;
  }

  if ((flag || model.sync_tab == "1") &&
      jsonData.containsKey('3') &&
      jsonData["3"] != null &&
      id.isNotEmpty) {
    var jsonObject = jsonData["3"];
    jsonObject['trn_cs_appl_id'] = id;
    print(id);
    flag = await syncSubTab(
        jsonObject, "saveBuildLicBuildingData/"+globals.loginSessionModel!.citizenRegistrationId!, model.id.toString(), "2");
  } else {
    flag = false;
  }

  if ((flag || model.sync_tab == "2") && jsonData.containsKey('4') && jsonData["4"] != null && id.isNotEmpty) {
    // var jsonObject = jsonData["4"];
    // jsonObject['trn_cs_appl_id'] = id;

    List<MstAppDocumentModel> docList = await DatabaseOperation.instance.getAllDocument(model.id.toString());

    if(docList.length > 0){

      for(int z=0;z<docList.length;z++){


        var jsonData = {
          'doc_temp':docList[z].document_path,
          'doc_type':docList[z].document_id,
          'doc_desc':docList[z].document_description,
          'trn_cs_appl_id':id,
        };
        print(jsonEncode(jsonData));
        flag = await syncTabWithDoc(jsonData, "saveBuildingLicUploadDocData/"+globals.loginSessionModel!.citizenRegistrationId!, model.id.toString(), "3",docList[z].id.toString());
      }
      if (flag) {
        await DatabaseOperation.instance.updateSyncTabStatus(model.id.toString(), "3");
        await DatabaseOperation.instance.updateSyncMessageStatus(model.id.toString(), '');
      }
    }else{
      flag = false;
    }

  } else {
    flag = false;
  }

  if ((flag || model.sync_tab == "3") && id.isNotEmpty) {
    var jsonObject = {'trn_cs_appl_id' : id};
    flag = await syncSubTab(jsonObject, "saveDftFinalBuildLicData/"+globals.loginSessionModel!.citizenRegistrationId!, model.id.toString(), "F");
  } else {
    flag = false;
  }

  return flag;
}

//OTHER
Future<bool> saveIssuanceOfNocEscomsDetails(
    MstAddApplicationModel model) async {
  var jsonData = jsonDecode(model.aPPLICATIONDATA);
  bool flag = true;
  if (model.sync_tab.isEmpty &&
      jsonData.containsKey('1') &&
      jsonData["1"] != null) {
    var jsonObject = jsonData["1"];
    if(model.from_web.isNotEmpty && model.draft_id.isNotEmpty){
      jsonObject['trn_cs_appl_id'] = model.draft_id;
    }
    flag = await syncSubTab(
        jsonObject,
        "saveApplicantIssuanceOfNocforEscomsData/"+globals.loginSessionModel!.citizenRegistrationId!,
        model.id.toString(),
        "0");
  } else {
    flag = false;
  }

  String id = model.draft_id.isNotEmpty
      ? model.draft_id
      : await DatabaseOperation.instance
      .getApplicationGeneratedIdUsingID(model.id.toString());

  if ((flag || model.sync_tab == "0") && jsonData.containsKey('2') && jsonData["2"] != null && id.isNotEmpty) {
    var jsonObject = jsonData["2"];
    jsonObject['trn_cs_appl_id'] = id;
    flag = await syncSubTab(jsonObject, "savePropertyIssuanceOfNocForEscomsData/"+globals.loginSessionModel!.citizenRegistrationId!, model.id.toString(), "1");
  } else {
    flag = false;
  }

  if ((flag || model.sync_tab == "1") && jsonData.containsKey('3') && jsonData["3"] != null && id.isNotEmpty) {
    // var jsonObject = jsonData["3"];
    // jsonObject['trn_cs_appl_id'] = id;
    // flag = await syncWaterConTabWithDoc(
    //     jsonObject,
    //     "saveUploadDocIssuanceOfNocForEscomsData/"+globals.loginSessionModel!.citizenRegistrationId!,
    //     model.id.toString(),
    //     "2");
    List<MstAppDocumentModel> docList = await DatabaseOperation.instance.getAllDocument(model.id.toString());

    if(docList.length > 0){
      for(int z=0;z<docList.length;z++){
        var jsonData = {
          'doc_temp':docList[z].document_path,
          'doc_type_id':docList[z].document_id,
          'doc_desc':docList[z].document_description,
          'trn_cs_appl_id':id,
        };
        print(jsonEncode(jsonData));
        flag = await syncTabWithDoc(jsonData, "saveUploadDocIssuanceOfNocForEscomsData/"+globals.loginSessionModel!.citizenRegistrationId!, model.id.toString(), "3",docList[z].id.toString());
      }
      if (flag) {
        await DatabaseOperation.instance.updateSyncTabStatus(model.id.toString(), "2");
        await DatabaseOperation.instance.updateSyncMessageStatus(model.id.toString(), '');
      }
    }else{
      flag = false;
    }

  } else {
    flag = false;
  }

  if ((flag || model.sync_tab == "2") && id.isNotEmpty) {
    var jsonObject = {'trn_cs_appl_id' : id};
    flag = await syncSubTab(jsonObject, "saveFinalIssuanceOfNocForEscomsData/"+globals.loginSessionModel!.citizenRegistrationId!,
        model.id.toString(), "F");
  } else {
    flag = false;
  }

  return flag;
}

// MAINTAENANCE
Future<bool> saveDrinkingWater(MstAddApplicationModel model) async {
  var jsonData = jsonDecode(model.aPPLICATIONDATA);
  bool flag = true;
  if (model.sync_tab.isEmpty && jsonData.containsKey('1') && jsonData["1"] != null) {
    var jsonObject = jsonData["1"];
    if(model.from_web.isNotEmpty && model.draft_id.isNotEmpty){
      jsonObject['trn_cs_appl_id'] = model.draft_id;
    }
    flag = await syncSubTab(
        jsonObject, "dftMaintDrinkingWater/"+globals.loginSessionModel!.citizenRegistrationId!, model.id.toString(), "0");
  } else {
    flag = false;
  }
 String id = model.draft_id.isNotEmpty
      ? model.draft_id
      : await DatabaseOperation.instance
          .getApplicationGeneratedIdUsingID(model.id.toString());

  if ((flag || model.sync_tab == "0") && id.isNotEmpty) {
    var jsonObject = {'trn_cs_appl_id' : id};

    flag = await syncSubTab(jsonObject, "saveMaintDrinkingWater/"+globals.loginSessionModel!.citizenRegistrationId!, model.id.toString(), "F");
  } else {
    flag = false;
  }
  return flag;
}

Future<bool> saveStreetlight(MstAddApplicationModel model) async {
  var jsonData = jsonDecode(model.aPPLICATIONDATA);
  bool flag = true;

  if (model.sync_tab.isEmpty &&
      jsonData.containsKey('1') &&
      jsonData["1"] != null) {
    var jsonObject = jsonData["1"];
    if(model.from_web.isNotEmpty && model.draft_id.isNotEmpty){
      jsonObject['trn_cs_appl_id'] = model.draft_id;
    }
    flag = await syncSubTab(
        jsonObject, "dftMaintStreetLight/"+globals.loginSessionModel!.citizenRegistrationId!, model.id.toString(), "0");
  } else {
    flag = false;
  }

 String id = model.draft_id.isNotEmpty
      ? model.draft_id
      : await DatabaseOperation.instance
          .getApplicationGeneratedIdUsingID(model.id.toString());

  if ((flag || model.sync_tab == "0") && id.isNotEmpty) {
    var jsonObject = {'trn_cs_appl_id' : id};
    flag = await syncSubTab(jsonObject, "saveMaintStreetLight/"+globals.loginSessionModel!.citizenRegistrationId! , model.id.toString(), "F");
  } else {
    flag = false;
  }
  return flag;
}

// saveDftFinalBuildLicData
Future<bool> saveVillageSanitation(MstAddApplicationModel model) async {
  var jsonData = jsonDecode(model.aPPLICATIONDATA);
  bool flag = true;

  if (model.sync_tab.isEmpty &&
      jsonData.containsKey('1') &&
      jsonData["1"] != null) {
    var jsonObject = jsonData["1"];
    if(model.from_web.isNotEmpty && model.draft_id.isNotEmpty){
      jsonObject['trn_cs_appl_id'] = model.draft_id;
    }
    flag = await syncSubTab(jsonObject, "dftMaintVillageSanitation/"+globals.loginSessionModel!.citizenRegistrationId!,
        model.id.toString(), "0");
  } else {
    flag = false;
  }

 String id = model.draft_id.isNotEmpty
      ? model.draft_id
      : await DatabaseOperation.instance
          .getApplicationGeneratedIdUsingID(model.id.toString());

  if ((flag || model.sync_tab == "0") && id.isNotEmpty) {
    var jsonObject = {'trn_cs_appl_id' : id};
    flag = await syncSubTab(jsonObject, "saveMaintVillageSanitation/"+globals.loginSessionModel!.citizenRegistrationId!, model.id.toString(), "F");
  } else {
    flag = false;
  }
  return flag;
}
//KASIM END

//ALPITA START

//Trade - Business License

Future<bool> saveBusinessLicenseDetails(MstAddApplicationModel model) async {
  var jsonData = jsonDecode(model.aPPLICATIONDATA);
  bool flag = true;

  if (model.sync_tab.isEmpty &&
      jsonData.containsKey('1') &&
      jsonData["1"] != null) {
    var jsonObject = jsonData["1"];
    if(model.from_web.isNotEmpty && model.draft_id.isNotEmpty){
      jsonObject['trn_cs_appl_id'] = model.draft_id;
    }
    flag = await syncSubTab(
        jsonObject, "saveDftDtlTradeLicApp/"+globals.loginSessionModel!.citizenRegistrationId!, model.id.toString(), "0");
  } else {
    flag = false;
  }

 String id = model.draft_id.isNotEmpty
      ? model.draft_id
      : await DatabaseOperation.instance
          .getApplicationGeneratedIdUsingID(model.id.toString());

  if ((flag || model.sync_tab == "0") &&
      jsonData.containsKey('2') &&
      jsonData["2"] != null &&
      id.isNotEmpty) {
    var jsonObject = jsonData["2"];
    jsonObject['trn_cs_appl_id'] = id;
    print(id);
    flag = await syncSubTab(
        jsonObject, "saveDftDtlTradeLicPropApp/"+globals.loginSessionModel!.citizenRegistrationId!, model.id.toString(), "1");
  } else {
    flag = false;
  }

  if ((flag || model.sync_tab == "1") &&
      jsonData.containsKey('3') &&
      jsonData["3"] != null &&
      id.isNotEmpty) {
    var jsonObject = jsonData["3"];
    jsonObject['trn_cs_appl_id'] = id;
    print(id);
    flag = await syncSubTab(
        jsonObject, "saveDftDtlTradeLicTypeApp/"+globals.loginSessionModel!.citizenRegistrationId!, model.id.toString(), "2");
  } else {
    flag = false;
  }

  if ((flag || model.sync_tab == "2") && jsonData.containsKey('4') && jsonData["4"] != null && id.isNotEmpty) {
    // var jsonObject = jsonData["4"];
    // jsonObject['trn_cs_appl_id'] = id;
    // flag = await syncWaterConTabWithDoc(jsonObject, "saveDftDtlTradeLicDocApp/"+globals.loginSessionModel!.citizenRegistrationId!, model.id.toString(), "3");

    List<MstAppDocumentModel> docList = await DatabaseOperation.instance.getAllDocument(model.id.toString());

    if(docList.length > 0){
      for(int z=0;z<docList.length;z++){
        var jsonData = {
          'doc_temp':docList[z].document_path,
          'doc_type_id':docList[z].document_id,
          'doc_description':docList[z].document_description,
          'trn_cs_appl_id':id,
        };
        print(jsonEncode(jsonData));
        flag = await syncTabWithDoc(jsonData, "saveDftDtlTradeLicDocApp/"+globals.loginSessionModel!.citizenRegistrationId!, model.id.toString(), "3",docList[z].id.toString());
      }
      if (flag) {
        await DatabaseOperation.instance.updateSyncTabStatus(model.id.toString(), "3");
        await DatabaseOperation.instance.updateSyncMessageStatus(model.id.toString(), '');
      }
    }else{
      flag = false;
    }


  } else {
    flag = false;
  }

  if ((flag || model.sync_tab == "3") && id.isNotEmpty) {
    var jsonObject = {'trn_cs_appl_id' : id};
    flag = await syncSubTab(jsonObject, "saveDtlTradeLicAppFinal/"+globals.loginSessionModel!.citizenRegistrationId!, model.id.toString(), "F");
  } else {
    flag = false;
  }

  return flag;
}

//TRADE - ADVERTISEMENT LICENSE

Future<bool> saveAdvertisementLicenseDetails(
    MstAddApplicationModel model) async {
  var jsonData = jsonDecode(model.aPPLICATIONDATA);
  bool flag = true;

  if (model.sync_tab.isEmpty &&
      jsonData.containsKey('1') &&
      jsonData["1"] != null) {
    var jsonObject = jsonData["1"];
    if(model.from_web.isNotEmpty && model.draft_id.isNotEmpty){
      jsonObject['trn_cs_appl_id'] = model.draft_id;
    }
    flag = await syncSubTab(
        jsonObject, "saveAdvlicAppDetail/"+globals.loginSessionModel!.citizenRegistrationId!, model.id.toString(), "0");
  } else {
    flag = false;
  }

 String id = model.draft_id.isNotEmpty
      ? model.draft_id
      : await DatabaseOperation.instance
          .getApplicationGeneratedIdUsingID(model.id.toString());

  if ((flag || model.sync_tab == "0") &&
      jsonData.containsKey('2') &&
      jsonData["2"] != null &&
      id.isNotEmpty) {
    var jsonObject = jsonData["2"];
    jsonObject['trn_cs_appl_id'] = id;
    print(id);
    flag = await syncSubTab(
        jsonObject, "saveAdvLicPropDetail/"+globals.loginSessionModel!.citizenRegistrationId!, model.id.toString(), "1");
  } else {
    flag = false;
  }

  if ((flag || model.sync_tab == "1") &&
      jsonData.containsKey('3') &&
      jsonData["3"] != null &&
      id.isNotEmpty) {
    var jsonObject = jsonData["3"];
    jsonObject['trn_cs_appl_id'] = id;
    print(id);
    flag = await syncSubTab(
        jsonObject, "savAdvLicDetailofAdv/"+globals.loginSessionModel!.citizenRegistrationId!, model.id.toString(), "2");
  } else {
    flag = false;
  }

  if ((flag || model.sync_tab == "2") && jsonData.containsKey('4') && jsonData["4"] != null && id.isNotEmpty) {
    // var jsonObject = jsonData["4"];
    // jsonObject['trn_cs_appl_id'] = id;
    // flag = await syncWaterConTabWithDoc(jsonObject, "savAdvLicDocDetail/"+globals.loginSessionModel!.citizenRegistrationId!, model.id.toString(), "3");

    List<MstAppDocumentModel> docList = await DatabaseOperation.instance.getAllDocument(model.id.toString());

    if(docList.length > 0){
      for(int z=0;z<docList.length;z++){
        var jsonData = {
          'doc_temp':docList[z].document_path,
          'doc_type':docList[z].document_id,
          'doc_desc':docList[z].document_description,
          'trn_cs_appl_id':id,
        };
        print(jsonEncode(jsonData));
        flag = await syncTabWithDoc(jsonData, "savAdvLicDocDetail/"+globals.loginSessionModel!.citizenRegistrationId!, model.id.toString(), "3",docList[z].id.toString());
      }
      if (flag) {
        await DatabaseOperation.instance.updateSyncTabStatus(model.id.toString(), "3");
        await DatabaseOperation.instance.updateSyncMessageStatus(model.id.toString(), '');
      }
    }else{
      flag = false;
    }

  } else {
    flag = false;
  }

  if ((flag || model.sync_tab == "3") && id.isNotEmpty) {
    var jsonObject = {'trn_cs_appl_id' : id};
    flag = await syncSubTab(jsonObject, "saveDetailAdvtLicData/"+globals.loginSessionModel!.citizenRegistrationId!, model.id.toString(), "F");
  } else {
    flag = false;
  }

  return flag;
}

//TRADE- FACTORY CLEARANCE

Future<bool> saveFactoryClearanceDetails(MstAddApplicationModel model) async {
  var jsonData = jsonDecode(model.aPPLICATIONDATA);
  bool flag = true;


  if (model.sync_tab.isEmpty && jsonData.containsKey('1') && jsonData["1"] != null) {
    var jsonObject = jsonData["1"];
    if(model.from_web.isNotEmpty && model.draft_id.isNotEmpty){
      jsonObject['trn_cs_appl_id'] = model.draft_id;
    }
    flag = await syncSubTab(jsonObject, "saveFactoryClearAppDetail/"+globals.loginSessionModel!.citizenRegistrationId!, model.id.toString(), "0");
  } else {
    flag = false;
  }

  String id = model.gENERATEDAPPLICATIONID.isNotEmpty ? model.gENERATEDAPPLICATIONID : await DatabaseOperation.instance.getApplicationGeneratedIdUsingID(model.id.toString());

  if ((flag || model.sync_tab == "0") &&
      jsonData.containsKey('2') &&
      jsonData["2"] != null &&
      id.isNotEmpty) {
    var jsonObject = jsonData["2"];
    jsonObject['trn_cs_appl_id'] = id;
    flag = await syncSubTab(
        jsonObject, "saveFactoryClearPropDetail/"+globals.loginSessionModel!.citizenRegistrationId!, model.id.toString(), "1");
  } else {
    flag = false;
  }

  if ((flag || model.sync_tab == "1") &&
      jsonData.containsKey('3') &&
      jsonData["3"] != null &&
      id.isNotEmpty) {
    var jsonObject = jsonData["3"];
    jsonObject['trn_cs_appl_id'] = id;
    flag = await syncSubTab(
        jsonObject, "saveFactoryClearDetail/"+globals.loginSessionModel!.citizenRegistrationId!, model.id.toString(), "2");
  } else {
    flag = false;
  }

  if ((flag || model.sync_tab == "2") && jsonData.containsKey('4') && jsonData["4"] != null && id.isNotEmpty) {
    // var jsonObject = jsonData["4"];
    // jsonObject['trn_cs_appl_id'] = id;
    // flag = await syncWaterConTabWithDoc(jsonObject, "savefactclearDocumentDetail/"+globals.loginSessionModel!.citizenRegistrationId!, model.id.toString(), "3");

    List<MstAppDocumentModel> docList = await DatabaseOperation.instance.getAllDocument(model.id.toString());

    if(docList.length > 0){
      for(int z=0;z<docList.length;z++){
        var jsonData = {
          'doc_temp':docList[z].document_path,
          'doc_type':docList[z].document_id,
          'doc_desc':docList[z].document_description,
          'trn_cs_appl_id':id,
        };
        print(jsonEncode(jsonData));
        flag = await syncTabWithDoc(jsonData, "savefactclearDocumentDetail/"+globals.loginSessionModel!.citizenRegistrationId!, model.id.toString(), "3",docList[z].id.toString());
      }
      if (flag) {
        await DatabaseOperation.instance.updateSyncTabStatus(model.id.toString(), "3");
        await DatabaseOperation.instance.updateSyncMessageStatus(model.id.toString(), '');
      }
    }else{
      flag = false;
    }

  } else {
    flag = false;
  }

  if ((flag || model.sync_tab == "3") && id.isNotEmpty) {
    var jsonObject = {'trn_cs_appl_id' : id};
    flag = await syncSubTab(
        jsonObject, "saveFactoryPermissionDetail/"+globals.loginSessionModel!.citizenRegistrationId!, model.id.toString(), "F");
  } else {
    flag = false;
  }

  return flag;
}
//OTHERS - ENTERTAINMENT LICENSE

Future<bool> saveEnmtLicenseDetails(MstAddApplicationModel model) async {
  var jsonData = jsonDecode(model.aPPLICATIONDATA);
  bool flag = true;

  if (model.sync_tab.isEmpty &&
      jsonData.containsKey('1') &&
      jsonData["1"] != null) {
    var jsonObject = jsonData["1"];
    if(model.from_web.isNotEmpty && model.draft_id.isNotEmpty){
      jsonObject['trn_cs_appl_id'] = model.draft_id;
    }
    flag = await syncSubTab(jsonObject, "saveEnterntainmentLicAppData/"+globals.loginSessionModel!.citizenRegistrationId!,
        model.id.toString(), "0");
  } else {
    flag = false;
  }

 String id = model.draft_id.isNotEmpty
      ? model.draft_id
      : await DatabaseOperation.instance
          .getApplicationGeneratedIdUsingID(model.id.toString());

  if ((flag || model.sync_tab == "0") &&
      jsonData.containsKey('2') &&
      jsonData["2"] != null &&
      id.isNotEmpty) {
    var jsonObject = jsonData["2"];
    jsonObject['trn_cs_appl_id'] = id;
    print(id);
    flag = await syncSubTab(jsonObject, "saveEnterntainmentLicPropData/"+globals.loginSessionModel!.citizenRegistrationId!,
        model.id.toString(), "1");
  } else {
    flag = false;
  }

  if ((flag || model.sync_tab == "1") &&
      jsonData.containsKey('3') &&
      jsonData["3"] != null &&
      id.isNotEmpty) {
    var jsonObject = jsonData["3"];
    jsonObject['trn_cs_appl_id'] = id;
    print(id);
    flag = await syncSubTab(jsonObject, "saveEntertainmentLicProgData/"+globals.loginSessionModel!.citizenRegistrationId!,
        model.id.toString(), "2");
  } else {
    flag = false;
  }

  if ((flag || model.sync_tab == "2") && jsonData.containsKey('4') && jsonData["4"] != null && id.isNotEmpty) {
    // var jsonObject = jsonData["4"];
    // jsonObject['trn_cs_appl_id'] = id;
    // print(id);
    // flag = await syncWaterConTabWithDoc(jsonObject, "saveEntertainmentUploadDocData/"+globals.loginSessionModel!.citizenRegistrationId!, model.id.toString(), "3");

    List<MstAppDocumentModel> docList = await DatabaseOperation.instance.getAllDocument(model.id.toString());

    if(docList.length > 0){
      for(int z=0;z<docList.length;z++){
        var jsonData = {
          'doc_temp':docList[z].document_path,
          'doc_type':docList[z].document_id,
          'doc_desc':docList[z].document_description,
          'trn_cs_appl_id':id,
        };
        print(jsonEncode(jsonData));
        flag = await syncTabWithDoc(jsonData, "saveEntertainmentUploadDocData/"+globals.loginSessionModel!.citizenRegistrationId!, model.id.toString(), "3",docList[z].id.toString());
      }
      if (flag) {
        await DatabaseOperation.instance.updateSyncTabStatus(model.id.toString(), "3");
        await DatabaseOperation.instance.updateSyncMessageStatus(model.id.toString(), '');
      }
    }else{
      flag = false;
    }
  } else {
    flag = false;
  }

  if ((flag || model.sync_tab == "3") && id.isNotEmpty) {
    var jsonObject = {'trn_cs_appl_id' : id};
    flag = await syncSubTab(
        jsonObject, "saveDftFinalEntmtLicData/"+globals.loginSessionModel!.citizenRegistrationId!, model.id.toString(), "F");
  } else {
    flag = false;
  }

  return flag;
}

//OTHERS - ROAD CUTTING PERMISSION

Future<bool> saveRoadCuttingPerDetails(MstAddApplicationModel model) async {
  var jsonData = jsonDecode(model.aPPLICATIONDATA);
  bool flag = true;

  if (model.sync_tab.isEmpty &&
      jsonData.containsKey('1') &&
      jsonData["1"] != null) {
    var jsonObject = jsonData["1"];
    if(model.from_web.isNotEmpty && model.draft_id.isNotEmpty){
      jsonObject['trn_cs_appl_id'] = model.draft_id;
    }
    flag = await syncSubTab(
        jsonObject, "saveRoadCutAppData/"+globals.loginSessionModel!.citizenRegistrationId!, model.id.toString(), "0");
  } else {
    flag = false;
  }

 String id = model.draft_id.isNotEmpty
      ? model.draft_id
      : await DatabaseOperation.instance
          .getApplicationGeneratedIdUsingID(model.id.toString());

  if ((flag || model.sync_tab == "0") &&
      jsonData.containsKey('2') &&
      jsonData["2"] != null &&
      id.isNotEmpty) {
    var jsonObject = jsonData["2"];
    jsonObject['trn_cs_appl_id'] = id;
    print(id);
    flag = await syncSubTab(
        jsonObject, "saveRoadCutPropData/"+globals.loginSessionModel!.citizenRegistrationId!, model.id.toString(), "1");
  } else {
    flag = false;
  }

  if ((flag || model.sync_tab == "1") &&
      jsonData.containsKey('3') &&
      jsonData["3"] != null &&
      id.isNotEmpty) {
    var jsonObject = jsonData["3"];
    jsonObject['trn_cs_appl_id'] = id;
    print(id);
    flag = await syncSubTab(
        jsonObject, "saveRoadCutWorkData/"+globals.loginSessionModel!.citizenRegistrationId!, model.id.toString(), "2");
  } else {
    flag = false;
  }

  if ((flag || model.sync_tab == "2") && jsonData.containsKey('4') && jsonData["4"] != null && id.isNotEmpty) {
    // var jsonObject = jsonData["4"];
    // jsonObject['trn_cs_appl_id'] = id;
    // print(id);
    // flag = await syncWaterConTabWithDoc(jsonObject, "saveRoadCutUploadData/"+globals.loginSessionModel!.citizenRegistrationId!, model.id.toString(), "3");
    List<MstAppDocumentModel> docList = await DatabaseOperation.instance.getAllDocument(model.id.toString());

    if(docList.length > 0){
      for(int z=0;z<docList.length;z++){
        var jsonData = {
          'doc_temp':docList[z].document_path,
          'doc_type':docList[z].document_id,
          'doc_desc':docList[z].document_description,
          'trn_cs_appl_id':id,
        };
        print(jsonEncode(jsonData));
        flag = await syncTabWithDoc(jsonData, "saveRoadCutUploadData/"+globals.loginSessionModel!.citizenRegistrationId!, model.id.toString(), "3",docList[z].id.toString());
      }
      if (flag) {
        await DatabaseOperation.instance.updateSyncTabStatus(model.id.toString(), "3");
        await DatabaseOperation.instance.updateSyncMessageStatus(model.id.toString(), '');
      }
    }else{
      flag = false;
    }
  } else {
    flag = false;
  }

  if ((flag || model.sync_tab == "3") && id.isNotEmpty) {
    var jsonObject = {'trn_cs_appl_id' : id};
    flag = await syncSubTab(
        jsonObject, "saveFinalRoadCuttingApp/"+globals.loginSessionModel!.citizenRegistrationId!, model.id.toString(), "F");
  } else {
    flag = false;
  }

  return flag;
}

//ALPITA END
