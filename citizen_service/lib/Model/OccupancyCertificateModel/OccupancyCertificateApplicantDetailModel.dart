class OccupancyCertificateApplicantDetail {
  String dft_occp_certi_appl_dtl_id = "";
  String appl_name = '';
  String family_id = '';
  String parent_spouse_name = '';
  String add_line_1 = '';
  String add_line_2 = '';
  String mob_no = '';
  String pin_code = '';
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

  OccupancyCertificateApplicantDetail(
      this.dft_occp_certi_appl_dtl_id,
      this.appl_name,
      this.family_id,
      this.parent_spouse_name,
      this.add_line_1,
      this.add_line_2,
      this.mob_no,
      this.pin_code,
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

  OccupancyCertificateApplicantDetail.fromJson(Map<String, dynamic> json) {
    //dft_occp_certi_appl_dtl_id = json['dft_occp_certi_appl_dtl_id'];
    appl_name = json['appl_name'];
    family_id = json['family_id'];
    parent_spouse_name = json['parent_spouse_name'];
    add_line_1 = json['add_line_1'];
    add_line_2 = json['add_line_2'];
    mob_no = json['mob_no'];
    pin_code = json['pin_code'];
  //  trn_cs_appl_id = json['trn_cs_appl_id'];
    // service_id = json['service_id'];
    // sub_service_id = json['sub_service_id'];
    // crt_date = json['crt_date'];
    // crt_ip = json['crt_ip'];
    // lst_upd_ip = json['lst_upd_ip'];
    // lst_upd_date = json['lst_upd_date'];
    // lst_upd_user = json['lst_upd_user'];
    // status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
   // data['dft_occp_certi_appl_dtl_id'] = this.dft_occp_certi_appl_dtl_id;
    data['appl_name'] = this.appl_name;
    data['family_id'] = this.family_id;
    data['parent_spouse_name'] = this.parent_spouse_name;
    data['add_line_1'] = this.add_line_1;
    data['add_line_2'] = this.add_line_2;
    data['mob_no'] = this.mob_no;
    data['pin_code'] = this.pin_code;
    // data['trn_cs_appl_id'] = this.trn_cs_appl_id;
    // data['service_id'] = this.service_id;
    // data['sub_service_id'] = this.sub_service_id;
    // data['crt_date'] = this.crt_date;
    // data['crt_ip'] = this.crt_ip;
    // data['lst_upd_ip'] = this.lst_upd_ip;
    // data['lst_upd_date'] = this.lst_upd_date;
    // data['lst_upd_user'] = this.lst_upd_user;
    // data['status'] = this.status;
    return data;
  }
}
