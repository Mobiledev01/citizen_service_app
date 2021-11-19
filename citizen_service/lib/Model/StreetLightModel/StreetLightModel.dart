import 'StreetLightApplication.dart';

class StreetLightModel {
  StreetLightApplication? streetLightApplication;

  StreetLightModel(this.streetLightApplication);

  StreetLightModel.fromJson(Map<String, dynamic> json) {
    streetLightApplication = StreetLightApplication.fromJson(json['1']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['1'] = this.streetLightApplication;
    return data;
  }
}
