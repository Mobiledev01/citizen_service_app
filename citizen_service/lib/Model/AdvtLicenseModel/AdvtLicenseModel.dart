
import 'package:citizen_service/Model/AdvtLicenseModel/AdvtLicenseAdvertiseDetailsModel.dart';
import 'package:citizen_service/Model/AdvtLicenseModel/AdvtLicenseApplicantDetailsModel.dart';
import 'package:citizen_service/Model/AdvtLicenseModel/AdvtLicenseDocumentDetailsModel.dart';
import 'package:citizen_service/Model/AdvtLicenseModel/AdvtLicensePropertyDetailsModel.dart';

class AdvtLicenseModel {
  AdvtLicenseApplicantDetailsModel? applicantDetailsModel;
  AdvtLicensePropertyDetailsModel? propertyDetailsModel;
  AdvtLicenseAdvertiseDetailsModel? advertiseDetailsModel;
  AdvtLicenseDocumentDetailsModel? advertiseDocumentModel;

  AdvtLicenseModel({required this.applicantDetailsModel,required this.propertyDetailsModel,required this.advertiseDetailsModel,required this.advertiseDocumentModel});

  AdvtLicenseModel.fromJson(Map<String, dynamic> json) {
    applicantDetailsModel = AdvtLicenseApplicantDetailsModel.fromJson(json['1']);
    propertyDetailsModel = AdvtLicensePropertyDetailsModel.fromJson(json['2']);
    advertiseDetailsModel = AdvtLicenseAdvertiseDetailsModel.fromJson(json['3']);
    advertiseDocumentModel = AdvtLicenseDocumentDetailsModel.fromJson(json['4']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['1'] = this.applicantDetailsModel;
    data['2'] = this.propertyDetailsModel;
    data['3'] = this.advertiseDetailsModel;
    data['4'] = this.advertiseDocumentModel;
    return data;
  }
}
