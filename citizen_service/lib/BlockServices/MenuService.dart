import 'dart:convert';
import 'dart:io';

import 'package:citizen_service/HttpCalls/HttpCall.dart';
import 'package:citizen_service/Model/DropDownModel.dart';
import 'package:citizen_service/Utility/Utility.dart';

abstract class ServiceApi {
  Future<List<DropDownModal>> getCategoryMenu();
}

class MenuService extends ServiceApi {

  @override
  Future<List<DropDownModal>> getCategoryMenu() async {
    try {
      var data = {};
      // showDialogWithLoad(context);
      var map = (await httpPostDropDownMethod(
          '/ajax/getMasterServiceList?service_name=getMstServiceData',
          jsonEncode(data)));

      if (map.length > 0 && map["Status"] == 200) {
        // Navigator.pop(context);
        var jsonData = jsonDecode(map["Body"]) as List;
        List<DropDownModal> list =
            jsonData.map((tagJson) => DropDownModal.fromJson(tagJson)).toList();

        if (list.length > 0) {
          return list;
        } else {
          showErrorToast('Something went wrong !');
          return List<DropDownModal>.empty();
        }
      } else {
        // Navigator.pop(context);
        showErrorToast(map["Body"]);
        return List<DropDownModal>.empty();
      }
    } on SocketException {
      // Navigator.pop(context);
      print('No Internet connection 😑');
      return List<DropDownModal>.empty();
    } on HttpException {
      // Navigator.pop(context);
      print("Couldn't find the post 😱");
      return List<DropDownModal>.empty();
    } on FormatException {
      // Navigator.pop(context);
      print("Bad response format 👎");
      return List<DropDownModal>.empty();
    }
  }
}
