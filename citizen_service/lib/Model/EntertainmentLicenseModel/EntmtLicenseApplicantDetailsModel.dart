class EntmtLicenseApplicantDetailsModel {
  String DFT_DTL_ENTMT_LIC_APPL_DTL_ID = '';
  String appl_org_name = '';
  String familty_id = '';
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

  EntmtLicenseApplicantDetailsModel(
      {required this.DFT_DTL_ENTMT_LIC_APPL_DTL_ID,
      required this.appl_org_name,
      required this.familty_id,
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

  EntmtLicenseApplicantDetailsModel.fromJson(Map<String, dynamic> json) {
    // DFT_DTL_ENTMT_LIC_APPL_DTL_ID = json['DFT_DTL_ENTMT_LIC_APPL_DTL_ID'];
    appl_org_name = json['appl_name'];
    familty_id = json['family_id'];
    parent_spouse_name = json['parent_spouse_name'];
    add_line_1 = json['add_line_1'];
    add_line_2 = json['add_line_2'];
    mobile_no = json['mobile_no'];
    pin_code = json['pin_code'];
    //crt_date = json['crt_date'];
    // crt_ip = json['crt_ip'];
    // lst_upd_ip = json['lst_upd_ip'];
    // lst_upd_date = json['lst_upd_date'];
    // lst_upd_user = json['lst_upd_user'];
    // status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
  //  data['DFT_DTL_ENTMT_LIC_APPL_DTL_ID'] = this.DFT_DTL_ENTMT_LIC_APPL_DTL_ID;
    data['appl_name'] = this.appl_org_name;
    data['family_id'] = this.familty_id;
    data['parent_spouse_name'] = this.parent_spouse_name;
    data['add_line_1'] = this.add_line_1;
    data['add_line_2'] = this.add_line_2;
    data['mobile_no'] = this.mobile_no;
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
