class MstAppCategoryModel {
  int? id;
  String cATEGORYID = '';
  String aPPLICATIONNAME = '';
  String service_data_json = '';

  MstAppCategoryModel(
      {required this.id,
      required this.cATEGORYID,
      required this.aPPLICATIONNAME,
      required this.service_data_json});

  MstAppCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    cATEGORYID = json['CATEGORY_ID'];
    aPPLICATIONNAME = json['APPLICATION_NAME'];
    service_data_json = json['SERVICE_DATA_JSON'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.id;
    data['CATEGORY_ID'] = this.cATEGORYID;
    data['APPLICATION_NAME'] = this.aPPLICATIONNAME;
    data['SERVICE_DATA_JSON'] = this.service_data_json;
    return data;
  }
}
