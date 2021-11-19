import 'package:citizen_service/Model/EntertainmentLicenseModel/EntmtLicenseApplicantDetailsModel.dart';
import 'package:citizen_service/Model/EntertainmentLicenseModel/EntmtLicenseDocumentDetailsModel.dart';
import 'package:citizen_service/Model/EntertainmentLicenseModel/EntmtLicenseProgramDetailsModel.dart';
import 'package:citizen_service/Model/EntertainmentLicenseModel/EntmtLicensePropertyDetailsModel.dart';

class EntmtLicenseModel {
  EntmtLicenseApplicantDetailsModel? applicantDetailsModel;
  EntmtLicensePropertyDetailsModel? propertyDetailsModel;
  EntmtLicenseProgramDetailsModel? programDetailsModel;
  EntmtLicenseDocumentDetailsModel? entertainmentDocumentModel;

  EntmtLicenseModel({required this.applicantDetailsModel,required this.propertyDetailsModel,required this.programDetailsModel,required this.entertainmentDocumentModel});

  EntmtLicenseModel.fromJson(Map<String, dynamic> json) {
    applicantDetailsModel = EntmtLicenseApplicantDetailsModel.fromJson(json['1']);
    propertyDetailsModel = EntmtLicensePropertyDetailsModel.fromJson(json['2']);
    programDetailsModel = EntmtLicenseProgramDetailsModel.fromJson(json['3']);
    entertainmentDocumentModel = EntmtLicenseDocumentDetailsModel.fromJson(json['4']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['1'] = this.applicantDetailsModel;
    data['2'] = this.propertyDetailsModel;
    data['3'] = this.programDetailsModel;
    data['4'] = this.entertainmentDocumentModel;
    return data;
  }
}
