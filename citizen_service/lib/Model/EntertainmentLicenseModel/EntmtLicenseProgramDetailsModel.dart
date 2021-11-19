class EntmtLicenseProgramDetailsModel {
  String dft_dtl_entmt_lic_prog_id = '';
  String ent_prog_conducted = '';
  String ent_prog_type_id = '';
  String crt_date = '';
  String crt_user = '';
  String crt_ip = '';
  String lst_upd_ip = '';
  String lst_upd_date = '';
  String lst_upd_user = '';
  String status = '';

  EntmtLicenseProgramDetailsModel(
      {required this.dft_dtl_entmt_lic_prog_id,
        required this.ent_prog_conducted,
        required this.ent_prog_type_id,
        required this.crt_date,
        required this.crt_user,
        required this.crt_ip,
        required this.lst_upd_ip,
        required this.lst_upd_date,
        required this.lst_upd_user,
        required this.status});

  EntmtLicenseProgramDetailsModel.fromJson(Map<String, dynamic> json) {
  //  dft_dtl_entmt_lic_prog_id = json['dft_dtl_entmt_lic_prog_id'];
    ent_prog_conducted = json['ent_prog_conducted'];
    ent_prog_type_id = json['ent_prog_type_id'];
    // crt_date = json['crt_date'];
    // crt_ip = json['crt_ip'];
    // lst_upd_ip = json['lst_upd_ip'];
    // lst_upd_date = json['lst_upd_date'];
    // lst_upd_user = json['lst_upd_user'];
    // status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    //data['dft_dtl_entmt_lic_prog_id'] = this.dft_dtl_entmt_lic_prog_id;
    data['ent_prog_conducted'] = this.ent_prog_conducted;
    data['ent_prog_type_id'] = this.ent_prog_type_id;
    // data['crt_date'] = this.crt_date;
    // data['crt_ip'] = this.crt_ip;
    // data['lst_upd_ip'] = this.lst_upd_ip;
    // data['lst_upd_date'] = this.lst_upd_date;
    // data['lst_upd_user'] = this.lst_upd_user;
    // data['status'] = this.status;
    return data;
  }
}
