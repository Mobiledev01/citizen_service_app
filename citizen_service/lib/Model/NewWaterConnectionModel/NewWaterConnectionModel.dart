import 'NewWaterConnectionApplicantDetailsModel.dart';
import 'NewWaterConnectionDocumentDetailsModel.dart';
import 'NewWaterConnectionPropertyDetailsModel.dart';
import 'NewWaterConnectionWaterConnectionModel.dart';

class NewWaterConnectionModel {
  NewWaterConnectionApplicantDetailsModel? applicantDetailsModel;
  NewWaterConnectionPropertyDetailsModel? propertyDetailsModel;
  NewWaterConnectionWaterConnectionModel? waterConnectionModel;
  NewWaterConnectionDocumentDetailsModel? waterConnDocumentModel;

  NewWaterConnectionModel({required this.applicantDetailsModel,required this.propertyDetailsModel,required this.waterConnectionModel,required this.waterConnDocumentModel});

  NewWaterConnectionModel.fromJson(Map<String, dynamic> json) {
    applicantDetailsModel = NewWaterConnectionApplicantDetailsModel.fromJson(json['1']);
    propertyDetailsModel = NewWaterConnectionPropertyDetailsModel.fromJson(json['2']);
    waterConnectionModel = NewWaterConnectionWaterConnectionModel.fromJson(json['3']);
    waterConnDocumentModel = NewWaterConnectionDocumentDetailsModel.fromJson(json['4']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['1'] = this.applicantDetailsModel;
    data['2'] = this.propertyDetailsModel;
    data['3'] = this.waterConnectionModel;
    data['4'] = this.waterConnDocumentModel;
    return data;
  }
}
