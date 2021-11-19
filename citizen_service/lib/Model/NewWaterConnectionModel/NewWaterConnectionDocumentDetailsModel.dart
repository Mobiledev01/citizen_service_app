class NewWaterConnectionDocumentDetailsModel {
  String dft_dtl_new_water_conn_upload_id = '';
  String trn_doc_id = '';
  String doc_id = '';
  String doc_type_id = '';
  String doc_description = '';
  String crt_date = '';
  String crt_user = '';
  String crt_ip = '';
  String lst_upd_ip = '';
  String lst_upd_date = '';
  String lst_upd_user = '';
  String status = '';

  NewWaterConnectionDocumentDetailsModel(
      this.dft_dtl_new_water_conn_upload_id,
      this.trn_doc_id,
      this.doc_id,
      this.doc_type_id,
      this.doc_description,
      this.crt_date,
      this.crt_user,
      this.crt_ip,
      this.lst_upd_ip,
      this.lst_upd_date,
      this.lst_upd_user,
      this.status);

  NewWaterConnectionDocumentDetailsModel.fromJson(Map<String, dynamic> json) {
//    dft_dtl_new_water_conn_upload_id = json['dft_dtl_new_water_conn_upload_id'];
   // trn_doc_id = json['trn_doc_id'];
    doc_id = json['doc_id'];
    doc_type_id = json['doc_type_id'];
    doc_description = json['doc_description'];
    // crt_date = json['crt_date'];
    // crt_ip = json['crt_ip'];
    // lst_upd_ip = json['lst_upd_ip'];
    // lst_upd_date = json['lst_upd_date'];
    // lst_upd_user = json['lst_upd_user'];
    // status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
 //   data['dft_dtl_new_water_conn_upload_id'] = this.dft_dtl_new_water_conn_upload_id;
  //  data['trn_doc_id'] = this.trn_doc_id;
    data['doc_id'] = this.doc_id;
    data['doc_type_id'] = this.doc_type_id;
    data['doc_description'] = this.doc_description;
    // data['crt_date'] = this.crt_date;
    // data['crt_ip'] = this.crt_ip;
    // data['lst_upd_ip'] = this.lst_upd_ip;
    // data['lst_upd_date'] = this.lst_upd_date;
    // data['lst_upd_user'] = this.lst_upd_user;
    // data['status'] = this.status;
    return data;
  }
}
