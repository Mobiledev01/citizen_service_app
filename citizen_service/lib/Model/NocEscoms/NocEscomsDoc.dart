class NocEcomsDoc {
  String dft_dtl_noc_escoms_upload_id = '';
  String trn_doc_id = '';
  String doc_id = '';
  String doc_type_id = '';
  String doc_desc = '';
  String doc_name = '';
  String folder_name = '';
  String sub_folder_name = '';
  String doc_thumbnail_image = '';
  String is_used = '';
  String trn_cs_appl_id = '';
  String service_id = '';
  String sub_service_id = '';
  String crt_date = '';
  String crt_user = '';
  String crt_ip = '';
  String lst_upd_ip = '';
  String lst_upd_date = '';
  String lst_upd_user = '';
  String status = '';

  NocEcomsDoc(
      this.dft_dtl_noc_escoms_upload_id,
      this.trn_doc_id,
      this.doc_id,
      this.doc_type_id,
      this.doc_desc,
      this.doc_name,
      this.folder_name,
      this.sub_folder_name,
      this.doc_thumbnail_image,
      this.is_used,
      this.trn_cs_appl_id,
      this.service_id,
      this.sub_service_id,
      this.crt_date,
      this.crt_user,
      this.crt_ip,
      this.lst_upd_ip,
      this.lst_upd_date,
      this.lst_upd_user,
      this.status);

  NocEcomsDoc.fromJson(Map<String, dynamic> json) {
    // dft_dtl_noc_escoms_upload_id = json['dft_dtl_noc_escoms_upload_id'];
    // trn_doc_id = json['trn_doc_id'];
    doc_id = json['doc_id'];
    doc_type_id = json['doc_type_id'];
    doc_desc = json['doc_desc'];
    doc_name = json['doc_name'];
    folder_name = json['folder_name'];
    sub_folder_name = json['sub_folder_name'];
    doc_thumbnail_image = json['doc_thumbnail_image'];
    is_used = json['is_used'];
    // trn_cs_appl_id = json['trn_cs_appl_id'];
    // crt_date = json.containsKey('crt_date') ? json['crt_date'] : '';
    // crt_ip =  json.containsKey('crt_ip') ? json['crt_ip'] : '';
    // lst_upd_ip = json.containsKey('lst_upd_ip') ? json['lst_upd_ip'] : '';
    // lst_upd_date = json.containsKey('lst_upd_date') ? json['lst_upd_date'] : '';
    // lst_upd_user =  json.containsKey('lst_upd_user') ? json['lst_upd_user'] : '';
    // status =  json.containsKey('status') ? json['status'] : '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['dft_dtl_noc_escoms_upload_id'] = this.dft_dtl_noc_escoms_upload_id;
    // data['trn_doc_id'] = this.trn_doc_id;
    data['doc_id'] = this.doc_id;
    data['doc_type_id'] = this.doc_type_id;
    data['doc_desc'] = this.doc_desc;
    data['doc_name'] = this.doc_name;
    data['folder_name'] = this.folder_name;
    data['sub_folder_name'] = this.sub_folder_name;
    data['doc_thumbnail_image'] = this.doc_thumbnail_image;
    data['is_used'] = this.is_used;
    // data['service_id'] = this.service_id;
    // data['sub_service_id'] = this.sub_service_id;
    // data['trn_cs_appl_id'] = this.trn_cs_appl_id;
    // data['crt_date'] = this.crt_date;
    // data['crt_ip'] = this.crt_ip;
    // data['lst_upd_ip'] = this.lst_upd_ip;
    // data['lst_upd_date'] = this.lst_upd_date;
    // data['lst_upd_user'] = this.lst_upd_user;
    // data['status'] = this.status;
    return data;
  }
}
