class VillageModel {
  int? id;
  String? village_id;
  String? village_name;
  String? district_id;
  String? taluka_id;
  String? panchayat_id;
  String? status;

  VillageModel(
      {
        required this.village_id,
        required this.village_name,
        required this.district_id,
        required this.taluka_id,
        required this.panchayat_id,
        required this.status
      });

  VillageModel.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    village_id = json['VILLAGE_ID'];
    village_name = json['VILLAGE_NAME'];
    district_id = json['DISTRICT_ID'];
    taluka_id = json['TALUKA_ID'];
    panchayat_id = json['PANCHAYAT_ID'];
    status = json['STATUS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.id;
    data['VILLAGE_ID'] = this.village_id;
    data['VILLAGE_NAME'] = this.village_name;
    data['DISTRICT_ID'] = this.district_id;
    data['TALUKA_ID'] = this.taluka_id;
    data['PANCHAYAT_ID'] = this.panchayat_id;
    data['STATUS'] = this.status;
    return data;
  }
}
