class DropDownMasterModel {
  int? id;
  String? category_id;
  String? service_id;
  String? service_name;
  String? item_id;
  String? item_title;
  String? item_title_kn;
  String? status;

  DropDownMasterModel(
      {required this.category_id,
      required this.service_id,
      required this.service_name,
      required this.item_id,
      required this.item_title,
        required this.item_title_kn,
        required this.status
      });

  DropDownMasterModel.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    category_id = json['CATEGORY_ID'];
    service_id = json['SERVICE_ID'];
    service_name = json['SERVICE_NAME'];
    item_id = json['ITEM_ID'];
    item_title = json['ITEM_TITLE'];
    item_title_kn = json['ITEM_TITLE_KN'];
    status = json['STATUS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.id;
    data['CATEGORY_ID'] = this.category_id;
    data['SERVICE_ID'] = this.service_id;
    data['SERVICE_NAME'] = this.service_name;
    data['ITEM_ID'] = this.item_id;
    data['ITEM_TITLE'] = this.item_title;
    data['ITEM_TITLE_KN'] = this.item_title_kn;
    data['STATUS'] = this.status;
    return data;
  }
}
