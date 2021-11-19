import 'package:citizen_service/Model/FactoryClearanceModel/FactoryPerApplicantDetailsModel.dart';
import 'package:citizen_service/Model/FactoryClearanceModel/FactoryPerBuildingModel.dart';
import 'package:citizen_service/Model/FactoryClearanceModel/FactoryPerDocumentDetailsModel.dart';
import 'package:citizen_service/Model/FactoryClearanceModel/FactoryPerPropertyDetailsModel.dart';

class FactoryPerModel {
  FactoryPerApplicantDetailsModel? applicantDetailsModel;
  FactoryPerPropertyDetailsModel? propertyDetailsModel;
  FactoryPerBuildingModel? factoryPerBuildingModel;
  FactoryPerDocumentDetailsModel? factoryPerDocumentDetailsModel;

  FactoryPerModel({required this.applicantDetailsModel,required this.propertyDetailsModel,required this.factoryPerBuildingModel,required this.factoryPerDocumentDetailsModel});

  FactoryPerModel.fromJson(Map<String, dynamic> json) {
    applicantDetailsModel = FactoryPerApplicantDetailsModel.fromJson(json['1']);
    propertyDetailsModel = FactoryPerPropertyDetailsModel.fromJson(json['2']);
    factoryPerBuildingModel = FactoryPerBuildingModel.fromJson(json['3']);
    factoryPerDocumentDetailsModel = FactoryPerDocumentDetailsModel.fromJson(json['4']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['1'] = this.applicantDetailsModel;
    data['2'] = this.propertyDetailsModel;
    data['3'] = this.factoryPerBuildingModel;
    data['4'] = this.factoryPerDocumentDetailsModel;
    return data;
  }
}
