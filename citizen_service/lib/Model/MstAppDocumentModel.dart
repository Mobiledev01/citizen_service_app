class MstAppDocumentModel {

  int? id = null;
  String document_id = '';
  String document_type = '';
  String document_description = '';
  String document_name = '';
  String document_path = '';
  String app_trn_id = '';
  String sync_status = '';

  MstAppDocumentModel({required this.id, required this.document_id,required this.document_type,required this.document_description, required this.document_name,
    required this.document_path, required this.app_trn_id, required this.sync_status});

  MstAppDocumentModel.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    document_id = json['DOCUMENT_ID'];
    document_type = json['DOCUMENT_TYPE'];
    document_description = json['DOCUMENT_DESCRIPTION'];
    document_name = json['DOCUMENT_NAME'];
    document_path = json['DOCUMENT_PATH'];
    app_trn_id = json['APP_TRN_ID'];
    sync_status = json['SYNC_STATUS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.id;
    data['DOCUMENT_ID'] = this.document_id;
    data['DOCUMENT_TYPE'] = this.document_type;
    data['DOCUMENT_DESCRIPTION'] = this.document_description;
    data['DOCUMENT_NAME'] = this.document_name;
    data['DOCUMENT_PATH'] = this.document_path;
    data['APP_TRN_ID'] = this.app_trn_id;
    data['SYNC_STATUS'] = this.sync_status;
    return data;
  }
}
