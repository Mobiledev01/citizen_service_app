import 'DrinkingWaterApplication.dart';

class DrinkingWaterModel {
  DrinkingWaterApplication? drinkingWaterApplication;

  DrinkingWaterModel(this.drinkingWaterApplication);

  DrinkingWaterModel.fromJson(Map<String, dynamic> json) {
    drinkingWaterApplication = DrinkingWaterApplication.fromJson(json['1']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['1'] = this.drinkingWaterApplication;
    return data;
  }
}
