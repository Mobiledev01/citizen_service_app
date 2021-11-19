import 'package:citizen_service/Model/RoadCuttingPermissionModel/RoadCuttingApplicantDetailsModel.dart';
import 'package:citizen_service/Model/RoadCuttingPermissionModel/RoadCuttingDocumentDetailsModel.dart';
import 'package:citizen_service/Model/RoadCuttingPermissionModel/RoadCuttingPropertyDetailsModel.dart';
import 'package:citizen_service/Model/RoadCuttingPermissionModel/RoadCuttingWorkModel.dart';

class RoadCuttingModel {
  RoadCuttingApplicantDetailsModel? applicantDetailsModel;
  RoadCuttingPropertyDetailsModel? propertyDetailsModel;
  RoadCuttingWorkModel? roadCuttingWorkModel;
  RoadCuttingDocumentDetailsModel? roadCuttingDocumentDetailsModel;

  RoadCuttingModel({required this.applicantDetailsModel,required this.propertyDetailsModel,required this.roadCuttingWorkModel,required this.roadCuttingDocumentDetailsModel});

  RoadCuttingModel.fromJson(Map<String, dynamic> json) {
    applicantDetailsModel = RoadCuttingApplicantDetailsModel.fromJson(json['1']);
    propertyDetailsModel = RoadCuttingPropertyDetailsModel.fromJson(json['2']);
    roadCuttingWorkModel = RoadCuttingWorkModel.fromJson(json['3']);
    roadCuttingDocumentDetailsModel = RoadCuttingDocumentDetailsModel.fromJson(json['4']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['1'] = this.applicantDetailsModel;
    data['2'] = this.propertyDetailsModel;
    data['3'] = this.roadCuttingWorkModel;
    data['4'] = this.roadCuttingDocumentDetailsModel;
    return data;
  }
}
