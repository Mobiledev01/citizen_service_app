class BuildingLicenseDocumentDetailsModel {
  String dft_bldg_lic_upload_id = '';
  String trn_doc_id = '';
  String doc_id = '';
  String doc_type = '';
  String doc_desc = '';
  String crt_date = '';
  String crt_user = '';
  String crt_ip = '';
  String lst_upd_ip = '';
  String lst_upd_date = '';
  String lst_upd_user = '';
  String status = '';

  BuildingLicenseDocumentDetailsModel(
      this.dft_bldg_lic_upload_id,
      this.trn_doc_id,
      this.doc_id,
      this.doc_type,
      this.doc_desc,
      this.crt_date,
      this.crt_user,
      this.crt_ip,
      this.lst_upd_ip,
      this.lst_upd_date,
      this.lst_upd_user,
      this.status);

  BuildingLicenseDocumentDetailsModel.fromJson(Map<String, dynamic> json) {
    // dft_bldg_lic_upload_id = json['dft_bldg_lic_upload_id'];
    // trn_doc_id = json['trn_doc_id'];
    doc_id = json['doc_id'];
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
    // data['dft_bldg_lic_upload_id'] = this.dft_bldg_lic_upload_id;
    // data['trn_doc_id'] = this.trn_doc_id;
    data['doc_id'] = this.doc_id;
    data['doc_desc'] = this.doc_desc;
    data['doc_type'] = this.doc_type;
    // data['crt_date'] = this.crt_date;
    // data['crt_ip'] = this.crt_ip;
    // data['lst_upd_ip'] = this.lst_upd_ip;
    // data['lst_upd_date'] = this.lst_upd_date;
    // data['lst_upd_user'] = this.lst_upd_user;
    // data['status'] = this.status;
    return data;
  }
}
