class FactoryPerDocumentDetailsModel {
  String dft_dtl_fac_per_upload_id = '';
  String doc_id = '';
  String doc_name = '';
  String folder_name = '';
  String sub_folder_name = '';
  String doc_thumbnail_image = '';
  String is_used = '';
  String doc_type = '';
  String doc_desc = '';
  String crt_date = '';
  String crt_user = '';
  String crt_ip = '';
  String lst_upd_ip = '';
  String lst_upd_date = '';
  String lst_upd_user = '';
  String status = '';

  FactoryPerDocumentDetailsModel(
      {required this.dft_dtl_fac_per_upload_id,
        required this.doc_name,
        required this.folder_name,
        required this.sub_folder_name,
        required this.doc_thumbnail_image,
        required this.is_used,
        required this.doc_type,
        required this.doc_desc,
      required this.doc_id,
      required this.crt_date,
      required this.crt_user,
      required this.crt_ip,
      required this.lst_upd_ip,
      required this.lst_upd_date,
      required this.lst_upd_user,
      required this.status});

  FactoryPerDocumentDetailsModel.fromJson(Map<String, dynamic> json) {
    // dft_dtl_fac_per_upload_id = json['dft_dtl_fac_per_upload_id'];
    doc_id = json['doc_id'];
    doc_name = json['doc_name'];
    folder_name = json['folder_name'];
    sub_folder_name = json['sub_folder_name'];
    doc_thumbnail_image = json['doc_thumbnail_image'];
    is_used = json['is_used'];
    doc_type = json['doc_type'];
    doc_desc = json['doc_desc'];
    // crt_date = json['crt_date'];
    // crt_ip = json['crt_ip'];
    // lst_upd_ip = json['lst_upd_ip'];
    // lst_upd_date = json['lst_upd_date'];
    // lst_upd_user = json['lst_upd_user'];
    // status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
   // data['dft_dtl_fac_per_upload_id'] = this.dft_dtl_fac_per_upload_id;
    data['doc_id'] = this.doc_id;
    data['doc_name'] = this.doc_name;
    data['folder_name'] = this.folder_name;
    data['sub_folder_name'] = this.sub_folder_name;
    data['doc_thumbnail_image'] = this.doc_thumbnail_image;
    data['is_used'] = this.is_used;
    data['doc_type'] = this.doc_type;
    data['doc_desc'] = this.doc_desc;
    // data['crt_date'] = this.crt_date;
    // data['crt_ip'] = this.crt_ip;
    // data['lst_upd_ip'] = this.lst_upd_ip;
    // data['lst_upd_date'] = this.lst_upd_date;
    // data['lst_upd_user'] = this.lst_upd_user;
    // data['status'] = this.status;
    return data;
  }
}
