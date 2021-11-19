import 'DCWaterConnectionApplicantDetailsModel.dart';
import 'DCWaterConnectionDocDetailsModel.dart';
import 'DCWaterConnectionPropertyDetailsModel.dart';

class DCWaterConnectionModel{
  DCWaterConnectionApplicantDetailsModel? dcWaterConnectionApplicantDetailsModel;
  DCWaterConnectionPropertyDetailsModel? dcWaterConnectionPropertyDetailsModel;
  DCWaterConnectionDocDetailsModel? dcWaterConnectionDocDetailsModel;

  DCWaterConnectionModel(
      this.dcWaterConnectionApplicantDetailsModel,
      this.dcWaterConnectionPropertyDetailsModel,
      this.dcWaterConnectionDocDetailsModel);

  DCWaterConnectionModel.fromJson(Map<String, dynamic> json) {
    dcWaterConnectionApplicantDetailsModel = DCWaterConnectionApplicantDetailsModel.fromJson(json['1']);
    dcWaterConnectionPropertyDetailsModel = DCWaterConnectionPropertyDetailsModel.fromJson(json['2']);
    dcWaterConnectionDocDetailsModel = DCWaterConnectionDocDetailsModel.fromJson(json['3']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['1'] = this.dcWaterConnectionApplicantDetailsModel;
    data['2'] = this.dcWaterConnectionPropertyDetailsModel;
    data['3'] = this.dcWaterConnectionDocDetailsModel;
    return data;
  }
}