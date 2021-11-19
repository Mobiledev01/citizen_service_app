import 'package:citizen_service/Model/BusinessLicenseModel/BusinessLicenseApplicantDetailsModel.dart';
import 'package:citizen_service/Model/BusinessLicenseModel/BusinessLicenseBuildingDetailsModel.dart';
import 'package:citizen_service/Model/BusinessLicenseModel/BusinessLicenseDocumentDetailsModel.dart';
import 'package:citizen_service/Model/BusinessLicenseModel/BusinessLicensePropertyDetailsModel.dart';

class BusinessLicenseModel {
  BusinessLicenseApplicantDetailsModel? applicantDetailsModel;
  BusinessLicensePropertyDetailsModel? propertyDetailsModel;
  BusinessLicenseBuildingDetailsModel? buildingDetailsModel;
  BusinessLicenseDocumentDetailsModel? buildingDocumentModel;

  BusinessLicenseModel({required this.applicantDetailsModel,required this.propertyDetailsModel,required this.buildingDetailsModel,required this.buildingDocumentModel});

  BusinessLicenseModel.fromJson(Map<String, dynamic> json) {
    applicantDetailsModel = BusinessLicenseApplicantDetailsModel.fromJson(json['1']);
    propertyDetailsModel = BusinessLicensePropertyDetailsModel.fromJson(json['2']);
    buildingDetailsModel = BusinessLicenseBuildingDetailsModel.fromJson(json['3']);
    buildingDocumentModel = BusinessLicenseDocumentDetailsModel.fromJson(json['4']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['1'] = this.applicantDetailsModel;
    data['2'] = this.propertyDetailsModel;
    data['3'] = this.buildingDetailsModel;
    data['4'] = this.buildingDocumentModel;
    return data;
  }
}
