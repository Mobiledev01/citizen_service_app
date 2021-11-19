import 'VillageSanitationApplication.dart';

class VillageSanitationModel {
  VillageSanitationApplication? villageSanitationApplication;

  VillageSanitationModel(this.villageSanitationApplication);

  VillageSanitationModel.fromJson(Map<String, dynamic> json) {
    villageSanitationApplication =
        VillageSanitationApplication.fromJson(json['1']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['1'] = this.villageSanitationApplication;
    return data;
  }
}
