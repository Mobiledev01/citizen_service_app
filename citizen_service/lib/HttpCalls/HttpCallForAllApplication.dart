import 'dart:convert';
import 'dart:io';
import 'package:citizen_service/HttpCalls/HttpCall.dart';
import 'package:citizen_service/SqliteDatabase/Database.dart';
import 'package:http/http.dart' as http;

// for all common tab without Doc

Future<bool> syncSubTab(jsonData, String url, String id, String syncTab) async {
  bool flag = false;

  print(url);

  var request = http.MultipartRequest('POST', Uri.parse(urlWS + '/csAjax/' + url));
  // request.files.add(await http.MultipartFile.fromPath('image', filepath));

  jsonData.forEach((dynamicKey, list) {
    if (dynamicKey.toString() != 'crt_date' && dynamicKey.toString() != 'lst_upd_date') {
      request.fields[dynamicKey] = list;
    }
  });

  var response = await request.send();

  if (response.statusCode == 200) {
    var resultJson = jsonDecode(await response.stream.bytesToString());
    print(resultJson);
    if (resultJson["status"] == 1000 && resultJson["application_id"] != null) {

      var j = syncTab != 'F' ? await DatabaseOperation.instance.updateSyncDraftId(id, resultJson["application_id"]) : await DatabaseOperation.instance.updateSyncApplicationId(id, resultJson["application_id"]);

      if (j > 0) {
        var z = await DatabaseOperation.instance.updateSyncTabStatus(id, syncTab);
        if (z > 0) {
          await DatabaseOperation.instance.updateSyncMessageStatus(id, '');
          flag = true;
        }
      }
    }
    else if (resultJson["status"] == 1000 && syncTab != '0') {
      var z = await DatabaseOperation.instance.updateSyncTabStatus(id, syncTab);
      if (z > 0) {
        await DatabaseOperation.instance.updateSyncMessageStatus(id, '');
        flag = true;
      }
    }
    else if (resultJson["status"] == 200 || resultJson["status"] == 999) {
      await DatabaseOperation.instance.updateSyncMessageStatus(id, jsonEncode(resultJson["error_message"]));
      await DatabaseOperation.instance.updateFinalApplicationStatusEmpty(id);
      flag = false;
    }
  }

  return flag;
}

Future<bool> syncWaterConTabWithDoc(jsonData, String url, String id, String syncTab) async {
  bool flag = false;
  bool continueF = true;
  var request =   http.MultipartRequest('POST', Uri.parse(urlWS + '/csAjax/' + url));
 print(url);
  jsonData.forEach((dynamicKey, list) async {
    if (dynamicKey.toString() != 'crt_date' && dynamicKey.toString() != 'lst_upd_date') {
      if (dynamicKey.toString() == 'doc_id') {
        bool fileE = await new File(list.toString()).exists();
        if (fileE) {
          if(url.contains('saveOccuCertificateDocDetail')){
            request.files.add(await http.MultipartFile.fromPath('occp_doc_temp', list.toString()));
          }else{
            request.files.add(await http.MultipartFile.fromPath('doc_temp', list.toString()));
          }
        }
        else{
          continueF = false;
          var data ={'Message':'No File Found At Location.'};
          await DatabaseOperation.instance.updateSyncMessageStatus(id, jsonEncode(data));
        }
      }
      else {
        request.fields[dynamicKey] = list;
      }
    }
  });

  if(continueF){
    var response = await request.send();

    if (response.statusCode == 200) {
      var resultJson = jsonDecode(await response.stream.bytesToString());
      print(jsonEncode(resultJson));
      if (resultJson["status"] == 1000 && resultJson["application_id"] != null) {
        var j = syncTab != 'F' ? await DatabaseOperation.instance.updateSyncDraftId(id, resultJson["application_id"]) : await DatabaseOperation.instance.updateSyncApplicationId(id, resultJson["application_id"]);
        if (j > 0) {
          var z =
          await DatabaseOperation.instance.updateSyncTabStatus(id, syncTab);
          if (z > 0) {
            await DatabaseOperation.instance.updateSyncMessageStatus(id, '');
            flag = true;
          }
        }
      } else if (resultJson["status"] == 1000 && syncTab != '0') {
        var z = await DatabaseOperation.instance.updateSyncTabStatus(id, syncTab);
        if (z > 0) {
          await DatabaseOperation.instance.updateSyncMessageStatus(id, '');
          flag = true;
        }
      } else if (resultJson["status"] == 200) {
        await DatabaseOperation.instance
            .updateSyncMessageStatus(id, jsonEncode(resultJson["error_message"]));
        await DatabaseOperation.instance.updateFinalApplicationStatusEmpty(id);
        flag = false;
      }
    }
  }

  return flag;
}


Future<bool> syncTabWithDoc(jsonData, String url, String id, String syncTab,String mainId) async {
  bool flag = false;
  bool continueF = true;
  var request =   http.MultipartRequest('POST', Uri.parse(urlWS + '/csAjax/' + url));
  print(url);

 await jsonData.forEach((dynamicKey, list) async {
      if (dynamicKey.toString() == 'doc_temp') {
        bool fileE = await new File(list.toString()).exists();
        if (fileE) {
          if(url.contains('saveOccuCertificateDocDetail')){
            request.files.add(await http.MultipartFile.fromPath('occp_doc_temp', list.toString()));
          }else if(url.contains('savAdvLicDocDetail')){
            request.files.add(await http.MultipartFile.fromPath('advt_doc_temp', list.toString()));
          } else{
            request.files.add(await http.MultipartFile.fromPath('doc_temp', list.toString()));
          }
        }
        else{
          continueF = false;
          var data ={'Message':'No File Found At Location.'};
          await DatabaseOperation.instance.updateSyncMessageStatus(id, jsonEncode(data));
        }
      }
      else {
        request.fields[dynamicKey] = list;
      }
  });

  if(continueF){
    var response = await request.send();

    if (response.statusCode == 200) {
      var resultJson = jsonDecode(await response.stream.bytesToString());
      print(resultJson);
      if (resultJson["status"] == 1000 && resultJson["application_id"] != null) {
        var z = await DatabaseOperation.instance.updateSyncStatus(mainId);
        if (z > 0) {
          flag = true;
        }
      } else if (resultJson["status"] == 200 || resultJson["status"] == 999) {
        await DatabaseOperation.instance.updateSyncMessageStatus(id, jsonEncode(resultJson["error_message"]));
        await DatabaseOperation.instance.updateFinalApplicationStatusEmpty(id);
        flag = false;
      }
    }
  }else{
    flag = false;
  }

  return flag;
}
