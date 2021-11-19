class BusinessLicenseApplicantDetailsModel {
  String dft_bldg_lic_appl_dtl_id = '';
  String appl_name = '';
  String family_id = '';
  String parent_spouse_name = '';
  String add_line_1 = '';
  String add_line_2 = '';
  String mobile_no = '';
  String pin_code = '';
  String crt_date = '';
  String crt_user = '';
  String crt_ip = '';
  String lst_upd_ip = '';
  String lst_upd_date = '';
  String lst_upd_user = '';
  String status = '';

  BusinessLicenseApplicantDetailsModel(
      {required this.dft_bldg_lic_appl_dtl_id,
      required this.appl_name,
      required this.family_id,
      required this.parent_spouse_name,
      required this.add_line_1,
      required this.add_line_2,
      required this.mobile_no,
      required this.pin_code,
      required this.crt_date,
      required this.crt_user,
      required this.crt_ip,
      required this.lst_upd_ip,
      required this.lst_upd_date,
      required this.lst_upd_user,
      required this.status});

  BusinessLicenseApplicantDetailsModel.fromJson(Map<String, dynamic> json) {
    //dft_bldg_lic_appl_dtl_id = json['dft_bldg_lic_appl_dtl_id'];
    appl_name = json['appl_name'];
    family_id = json['family_id'];
    parent_spouse_name = json['parent_spouse_name'];
    add_line_1 = json['address_line_1'];
    add_line_2 = json['address_line_2'];
    mobile_no = json['mob_no'];
    pin_code = json['pin_code'];
    // crt_date = json['crt_date'];
    // crt_ip = json['crt_ip'];
    // lst_upd_ip = json['lst_upd_ip'];
    // lst_upd_date = json['lst_upd_date'];
    // lst_upd_user = json['lst_upd_user'];
    // status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    //data['dft_bldg_lic_appl_dtl_id'] = this.dft_bldg_lic_appl_dtl_id;
    data['appl_name'] = this.appl_name;
    data['family_id'] = this.family_id;
    data['parent_spouse_name'] = this.parent_spouse_name;
    data['address_line_1'] = this.add_line_1;
    data['address_line_2'] = this.add_line_2;
    data['mob_no'] = this.mobile_no;
    data['pin_code'] = this.pin_code;
    // data['crt_date'] = this.crt_date;
    // data['crt_ip'] = this.crt_ip;
    // data['lst_upd_ip'] = this.lst_upd_ip;
    // data['lst_upd_date'] = this.lst_upd_date;
    // data['lst_upd_user'] = this.lst_upd_user;
    // data['status'] = this.status;
    return data;
  }
}
