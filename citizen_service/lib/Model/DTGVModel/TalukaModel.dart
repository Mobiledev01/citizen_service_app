class TalukaModel {
  int? id;
  String? taluka_id;
  String? taluka_name;
  String? district_id;
  String? status;

  TalukaModel(
      {required this.taluka_id,
        required this.taluka_name,
        required this.district_id,
        required this.status
      });

  TalukaModel.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    taluka_id = json['TALUKA_ID'];
    taluka_name = json['TALUKA_NAME'];
    district_id = json['DISTRICT_ID'];
    status = json['STATUS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.id;
    data['TALUKA_ID'] = this.taluka_id;
    data['TALUKA_NAME'] = this.taluka_name;
    data['DISTRICT_ID'] = this.district_id;
    data['STATUS'] = this.status;
    return data;
  }
}
