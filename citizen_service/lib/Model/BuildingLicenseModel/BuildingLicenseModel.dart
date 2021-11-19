
import 'package:citizen_service/Model/BuildingLicenseModel/BuildingLicenseApplicantDetailsModel.dart';
import 'package:citizen_service/Model/BuildingLicenseModel/BuildingLicenseBuildingDetailsModel.dart';
import 'package:citizen_service/Model/BuildingLicenseModel/BuildingLicenseDocumentDetailsModel.dart';
import 'package:citizen_service/Model/BuildingLicenseModel/BuildingLicensePropertyDetailsModel.dart';

class BuildingLicenseModel {
  BuildingLicenseApplicantDetailsModel? applicantDetailsModel;
  BuildingLicensePropertyDetailsModel? propertyDetailsModel;
  BuildingLicenseBuildingDetailsModel? buildingDetailsModel;
  BuildingLicenseDocumentDetailsModel? buildingDocumentModel;

  BuildingLicenseModel({required this.applicantDetailsModel,required this.propertyDetailsModel,required this.buildingDetailsModel,required this.buildingDocumentModel});

  BuildingLicenseModel.fromJson(Map<String, dynamic> json) {
    applicantDetailsModel = BuildingLicenseApplicantDetailsModel.fromJson(json['1']);
    propertyDetailsModel = BuildingLicensePropertyDetailsModel.fromJson(json['2']);
    buildingDetailsModel = BuildingLicenseBuildingDetailsModel.fromJson(json['3']);
    buildingDocumentModel = BuildingLicenseDocumentDetailsModel.fromJson(json['4']);
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
