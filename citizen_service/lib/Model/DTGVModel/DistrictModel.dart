class DistrictModel {
  int? id;
  String? district_id;
  String? district_name;
  String? district_name_kn;
  String? status;

  DistrictModel(
      {required this.district_id,
        required this.district_name,
        required this.district_name_kn,
        required this.status
      });

  DistrictModel.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    district_id = json['DISTRICT_ID'];
    district_name = json['DISTRICT_NAME'];
    district_name_kn = json['DISTRICT_NAME_KN'];
    status = json['STATUS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.id;
    data['DISTRICT_ID'] = this.district_id;
    data['DISTRICT_NAME'] = this.district_name;
    data['DISTRICT_NAME_KN'] = this.district_name_kn;
    data['STATUS'] = this.status;
    return data;
  }
}
