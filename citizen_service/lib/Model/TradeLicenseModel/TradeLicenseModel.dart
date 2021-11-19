import 'package:citizen_service/Model/TradeLicenseModel/TradeLicenseApplicantDetailsModel.dart';
import 'package:citizen_service/Model/TradeLicenseModel/TradeLicenseDocumentDetailsModel.dart';
import 'package:citizen_service/Model/TradeLicenseModel/TradeLicensePropertyDetailsModel.dart';
import 'package:citizen_service/Model/TradeLicenseModel/TradeLicenseTypeAppModel.dart';

class TradeLicenseModel {
  TradeLicenseApplicantDetailsModel? applicantDetailsModel;
  TradeLicensePropertyDetailsModel? propertyDetailsModel;
  TradeLicenseTypeAppModel? tradeLicenseTypeAppModel;
  TradeLicenseDocumentDetailsModel? tradeLicenseDocumentDetailsModel;

  TradeLicenseModel({required this.applicantDetailsModel,required this.propertyDetailsModel,required this.tradeLicenseTypeAppModel,required this.tradeLicenseDocumentDetailsModel});

  TradeLicenseModel.fromJson(Map<String, dynamic> json) {
    applicantDetailsModel = TradeLicenseApplicantDetailsModel.fromJson(json['1']);
    propertyDetailsModel = TradeLicensePropertyDetailsModel.fromJson(json['2']);
    tradeLicenseTypeAppModel = TradeLicenseTypeAppModel.fromJson(json['3']);
    tradeLicenseDocumentDetailsModel = TradeLicenseDocumentDetailsModel.fromJson(json['4']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['1'] = this.applicantDetailsModel;
    data['2'] = this.propertyDetailsModel;
    data['3'] = this.tradeLicenseTypeAppModel;
    data['4'] = this.tradeLicenseDocumentDetailsModel;
    return data;
  }
}
