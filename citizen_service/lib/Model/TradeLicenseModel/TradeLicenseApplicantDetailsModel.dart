class TradeLicenseApplicantDetailsModel {
  String dtl_trade_lic_id = '';
  String applicant_name = '';
  String occupancy_dtl = '';
  String family_id = '';
  String family_spouse_name = '';
  String address_line1 = '';
  String address_line2 = '';
  String mob_no = '';
  String pin_code = '';
  String crt_date = '';
  String crt_user = '';
  String crt_ip = '';
  String lst_upd_ip = '';
  String lst_upd_date = '';
  String lst_upd_user = '';
  String status = '';

  TradeLicenseApplicantDetailsModel(
      {required this.dtl_trade_lic_id,
      required this.applicant_name,
      required this.occupancy_dtl,
      required this.family_id,
      required this.family_spouse_name,
      required this.address_line1,
      required this.address_line2,
      required this.mob_no,
      required this.pin_code,
      required this.crt_date,
      required this.crt_user,
      required this.crt_ip,
      required this.lst_upd_ip,
      required this.lst_upd_date,
      required this.lst_upd_user,
      required this.status});

  TradeLicenseApplicantDetailsModel.fromJson(Map<String, dynamic> json) {
   // dtl_trade_lic_id = json['dtl_trade_lic_id'];
    applicant_name = json['appl_name'];
    occupancy_dtl = json['occupancy_dtl'];
    family_id = json['family_id'];
    family_spouse_name = json['parent_spouse_name'];
    address_line1 = json['address_line1'];
    address_line2 = json['address_line2'];
    mob_no = json['mob_no'];
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
   // data['dtl_trade_lic_id'] = this.dtl_trade_lic_id;
    data['appl_name'] = this.applicant_name;
    data['occupancy_dtl'] = this.occupancy_dtl;
    data['family_id'] = this.family_id;
    data['parent_spouse_name'] = this.family_spouse_name;
    data['address_line1'] = this.address_line1;
    data['address_line2'] = this.address_line2;
    data['mob_no'] = this.mob_no;
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
