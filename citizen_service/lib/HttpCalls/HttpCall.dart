import 'dart:convert';
import 'dart:io';
import 'package:citizen_service/Model/DTGVModel/DistrictModel.dart';
import 'package:citizen_service/Model/DTGVModel/PanchayatModel.dart';
import 'package:citizen_service/Model/DTGVModel/TalukaModel.dart';
import 'package:citizen_service/Model/DTGVModel/VillageModel.dart';
import 'package:citizen_service/Model/DropDownModel.dart';
import 'package:citizen_service/Model/DropDownModel/DropDownModel.dart';
import 'package:citizen_service/SqliteDatabase/DataBaseString.dart';
import 'package:citizen_service/SqliteDatabase/Database.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';

// String urlWS = 'https://sts.karnataka.gov.in/api-stsmobile/services';
   String urlWS = 'http://192.168.1.161:9999/CITIZEN_SERVICES';
// String urlWS = 'http://122.170.12.200/panchatantra';


Future<Map<String, dynamic>> httpPostMethod(String methodName, String data) async {
  Map<String, dynamic> map = Map();

  try {
    var url = Uri.parse(urlWS  + methodName);
    print(url);
    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: data);

    map.putIfAbsent('Status', () => response.statusCode);
    map.putIfAbsent('Body', () => response.body);

    return map;
  } on SocketException {
    map.putIfAbsent('Status', () => '404');
    map.putIfAbsent('Body', () => 'No Internet connection');
    return map;
  } on HttpException {
    map.putIfAbsent('Status', () => '404');
    map.putIfAbsent('Body', () => 'Could not find the post method');
    return map;
  } on FormatException {
    map.putIfAbsent('Status', () => '404');
    map.putIfAbsent('Body', () => 'Bad response format');
    return map;
  } on Exception {
    map.putIfAbsent('Status', () => '404');
    map.putIfAbsent('Body', () => 'Bad response format');
    return map;
  }
}

Future<Map<String, dynamic>> httpFromDataPostMethod(String methodName, var data) async {
  Map<String, dynamic> map = Map();

  try {
    var url = Uri.parse(urlWS + methodName);
    print(url);
    var request = http.MultipartRequest('POST', url);

    data.forEach((dynamicKey, list) async {
      request.fields[dynamicKey] = list;
    });

    var response = await request.send();

    if (response.statusCode == 200) {
      var resultJson = jsonDecode(await response.stream.bytesToString());
      map.putIfAbsent('Status', () => resultJson["status"]);
      map.putIfAbsent('Body', () => jsonEncode(resultJson));
    } else {
      map.putIfAbsent('Status', () => '404');
      map.putIfAbsent('Body', () => 'Something went wrong !');
    }


    return map;
  } on SocketException {
    map.putIfAbsent('Status', () => '404');
    map.putIfAbsent('Body', () => 'No Internet connection');
    return map;
  } on HttpException {
    map.putIfAbsent('Status', () => '404');
    map.putIfAbsent('Body', () => 'Could not find the post method');
    return map;
  } on FormatException {
    map.putIfAbsent('Status', () => '404');
    map.putIfAbsent('Body', () => 'Bad response format');
    return map;
  }on Exception {
    map.putIfAbsent('Status', () => '404');
    map.putIfAbsent('Body', () => 'Bad response format');
    return map;
  }
}

Future<Map<String, dynamic>> httpPostDropDownMethod(String methodName, String data) async {
  Map<String, dynamic> map = Map();

  try {
    var url = Uri.parse(urlWS + methodName);
    print(url);
    List<DropDownModal> categoryList = [];

    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: data);

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);

      if (json["status"] == 1000) {
        List list = jsonDecode(json["responseData"]);

        for (var data in list) {
          categoryList.add(DropDownModal(
              id: data['DATA_ID'], title: data['DATA_VALUE'], titleKn: 'kn'));
        }
        map.putIfAbsent('Status', () => response.statusCode);
        map.putIfAbsent('Body', () => jsonEncode(categoryList));

        return map;
      } else {
        return map;
      }
    } else {
      return map;
    }
  } on SocketException {
    map.putIfAbsent('Status', () => '404');
    map.putIfAbsent('Body', () => 'No Internet connection');
    return map;
  } on HttpException {
    map.putIfAbsent('Status', () => '404');
    map.putIfAbsent('Body', () => 'Could not find the post method');
    return map;
  } on FormatException {
    map.putIfAbsent('Status', () => '404');
    map.putIfAbsent('Body', () => 'Bad response format');
    return map;
  } on Exception {
    map.putIfAbsent('Status', () => '404');
    map.putIfAbsent('Body', () => 'Bad response format');
    return map;
  }
}

Future<Map<String, dynamic>> httpGetMethod(String methodName) async {
  Map<String, dynamic> map = Map();

  try {
    var url = Uri.parse(urlWS + methodName);
    print(url);
    var response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    map.putIfAbsent('Status', () => response.statusCode);
    map.putIfAbsent('Body', () => response.body);

    return map;
  } on SocketException {
    map.putIfAbsent('Status', () => '404');
    map.putIfAbsent('Body', () => 'No Internet connection');
    return map;
  } on HttpException {
    map.putIfAbsent('Status', () => '404');
    map.putIfAbsent('Body', () => 'Could not find the get method');
    return map;
  } on FormatException {
    map.putIfAbsent('Status', () => '404');
    map.putIfAbsent('Body', () => 'Bad response format');
    return map;
  } on Exception {
    map.putIfAbsent('Status', () => '404');
    map.putIfAbsent('Body', () => 'Bad response format');
    return map;
  }
}

Future<Map<String, dynamic>> httpPostMenu(String methodName, String data) async {
  Map<String, dynamic> map = Map();

  try {
    var url = Uri.parse(urlWS + methodName);
    print(url);
    List categoryList = [];

    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: data);

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);

      if (json["status"] == 1000) {
        List list = jsonDecode(json["responseData"]);

        for (var data in list) {
          categoryList.add({ 'id': data['DATA_ID'], 'title': data['SERVICE_TITLE'], 'titleKn': 'SERVICE_KND_NAME'});
        }
        map.putIfAbsent('Status', () => response.statusCode);
        map.putIfAbsent('Body', () => json["responseData"]);

        return map;
      } else {
        return map;
      }
    } else {
      return map;
    }
  } on SocketException {
    map.putIfAbsent('Status', () => '404');
    map.putIfAbsent('Body', () => 'No Internet connection');
    return map;
  } on HttpException {
    map.putIfAbsent('Status', () => '404');
    map.putIfAbsent('Body', () => 'Could not find the post method');
    return map;
  } on FormatException {
    map.putIfAbsent('Status', () => '404');
    map.putIfAbsent('Body', () => 'Bad response format');
    return map;
  } on Exception {
    map.putIfAbsent('Status', () => '404');
    map.putIfAbsent('Body', () => 'Bad response format');
    return map;
  }
}


Future<bool> httpPostDropDownMasterCall(String methodName, String data,String categoryId,String serviceId,String serviceName) async {

  try {
    var url = Uri.parse(urlWS + methodName);
    print(url);
    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: data);

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);

      if (json["status"] == 1000) {
        List list = jsonDecode(json["responseData"]);


        if (list.length > 0) {
          await DatabaseOperation.instance.deleteDropDownData(categoryId,serviceId,serviceName);
        }

        if(methodName.contains('getMstDocData') ){
          for (var data in list) {
            DropDownMasterModel model = new DropDownMasterModel(
                category_id: categoryId,
                service_id: serviceId,
                service_name: serviceName,
                item_id: data['DOC_ID'],
                item_title: data['DATA_VALUE'],
                item_title_kn: '',status: 'Y');

            await DatabaseOperation.instance.insertDropDownData(model);
          }
        }
        else{
          for (var data in list) {
            DropDownMasterModel model = new DropDownMasterModel(
                category_id: categoryId,
                service_id: serviceId,
                service_name: serviceName,
                item_id: data['DATA_ID'],
                item_title: data['DATA_VALUE'],
                item_title_kn: '',status: 'Y');

            await DatabaseOperation.instance.insertDropDownData(model);
          }
        }

        return true;
      }
      else {
        return false;
      }
    }
    else {
      return false;
    }
  } on SocketException {
    return false;
  } on HttpException {
    return false;
  } on FormatException {
    return false;
  }
}

Future<bool> httpPostDistrictCall() async {

  try {
    var url = Uri.parse(urlWS + '/ajax/getMasterServiceList?service_name=getMstDistrictData');
    print(url);
    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({}));

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);

      if (json["status"] == 1000) {
        List list = jsonDecode(json["responseData"]);

        if (list.length > 0) {
          await DatabaseOperation.instance.deleteDistrictData();
        }

        for (var data in list) {

          DistrictModel model = new DistrictModel(district_id: data['DATA_ID'],
              district_name: data['DATA_VALUE'],
              district_name_kn: data['DISTRICT_NAME_KND'],
              status: 'Y');

          await DatabaseOperation.instance.insertDistrict(model);
        }
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  } on SocketException {
    return false;
  } on HttpException {
    return false;
  } on FormatException {
    return false;
  }
}


Future<bool> httpPostTalukaCall() async {

  try {
    var url = Uri.parse(urlWS + '/ajax/getMasterServiceList?service_name=getMstTpById');
    print(url);
    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({}));

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);

      if (json["status"] == 1000) {
        List list = jsonDecode(json["responseData"]);

        if (list.length > 0) {
          await DatabaseOperation.instance.deleteTalukaData();
        }

        for (var data in list) {
          TalukaModel model = new TalukaModel(
              taluka_id: data['DATA_ID'],
              taluka_name: data['DATA_VALUE'],
              district_id: data['DIS_ID'],
              status: 'Y');

          await DatabaseOperation.instance.insertTaluka(model);
        }
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  } on SocketException {
    return false;
  } on HttpException {
    return false;
  } on FormatException {
    return false;
  }
}



Future<bool> httpPostPanchayatCall() async {

  try {
    var url = Uri.parse(urlWS + '/ajax/getMasterServiceList?service_name=getMstGpDataById');
    print(url);
    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({}));

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);

      if (json["status"] == 1000) {
        List list = jsonDecode(json["responseData"]);

        if (list.length > 0) {
          await DatabaseOperation.instance.deletePanchayatData();
        }

        final db = await DatabaseOperation.instance.database;
        Batch batch = db!.batch();

        for (var data in list) {
          PanchayatModel model = new PanchayatModel(
              panchayat_id: data['DATA_ID'],
              panchayat_name: data['DATA_VALUE'],
              district_id: data['DIST_ID'],
              taluka_id: data['TP_ID'],
              status: 'Y');

          batch.insert(mst_panchayat, model.toJson());
          // await DatabaseOperation.instance.insertPanchayat(model);
        }

        await batch.commit(noResult: true);

        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  } on SocketException {
    return false;
  } on HttpException {
    return false;
  } on FormatException {
    return false;
  }
}



Future<bool> httpPostVillageCall() async {

  try {
    var url = Uri.parse(urlWS + '/ajax/getMasterServiceList?service_name=getMstVillageDataById');
    print(url);
    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({}));

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);

      if (json["status"] == 1000) {
        List list = jsonDecode(json["responseData"]);

        if (list.length > 0) {
          await DatabaseOperation.instance.deleteVillageData();
        }

        final db = await DatabaseOperation.instance.database;
        Batch batch = db!.batch();

        for (var data in list) {
          VillageModel model = new VillageModel(
              village_id: data['DATA_ID'],
              village_name: data['DATA_VALUE'],
              district_id: data['DIST_ID'],
              taluka_id: data['TP_ID'],
              panchayat_id: data['GP_ID'],
              status: 'Y');

           batch.insert(mst_village, model.toJson());
        }

        await batch.commit(noResult: true);

        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  } on SocketException {
    return false;
  } on HttpException {
    return false;
  } on FormatException {
    return false;
  }
}

/*

Future<void> demo(BuildContext context) async {
  try {
    var data = {};

    var map = (await httpPostMethod(
        'getMasterServiceList?service_name=getMstServiceData',
        jsonEncode(data)));
    // var map = (await httpGetMethod('posts/1'));
    // var map = (await httpFromDataPostMethod('posts/1',data));

    if (map.length > 0 && map["Status"] == 200) {
      // Navigator.pop(context);
      print(map["Status"]);
      print(map["Body"]);
      showSuccessToast('successfully');
    } else {
      showErrorToast(map["Body"]);
    }
  } on SocketException {
    print('No Internet connection 😑');
  } on HttpException {
    print("Couldn't find the post 😱");
  } on FormatException {
    print("Bad response format 👎");
  }
}*/
