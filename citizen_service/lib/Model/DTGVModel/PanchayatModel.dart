class PanchayatModel {
  int? id;
  String? panchayat_id;
  String? panchayat_name;
  String? district_id;
  String? taluka_id;
  String? status;

  PanchayatModel(
      {required this.panchayat_id,
        required this.panchayat_name,
        required this.district_id,
        required this.taluka_id,
        required this.status
      });

  PanchayatModel.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    panchayat_id = json['PANCHAYAT_ID'];
    panchayat_name = json['PANCHAYAT_NAME'];
    district_id = json['DISTRICT_ID'];
    taluka_id = json['TALUKA_ID'];
    status = json['STATUS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.id;
    data['PANCHAYAT_ID'] = this.panchayat_id;
    data['PANCHAYAT_NAME'] = this.panchayat_name;
    data['DISTRICT_ID'] = this.district_id;
    data['TALUKA_ID'] = this.taluka_id;
    data['STATUS'] = this.status;
    return data;
  }
}
