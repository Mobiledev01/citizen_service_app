class DCWaterConnectionApplicantDetailsModel{
 String dtl_dc_water_conn_appl_dtl_id = '';
 String appl_name = '';
 String familty_id = '';
 String parent_spouse_name = '';
 String add_line_1 = '';
 String add_line_2 = '';
 String district_id = '';
 String state_id = '';
 String mobile_no = '';
 String pin_code = '';
 String crt_date = '';
 String crt_ip = '';
 String lst_upd_ip = '';
 String lst_upd_date = '';
 String lst_upd_user = '';
 String status = '';

 DCWaterConnectionApplicantDetailsModel(
     this.dtl_dc_water_conn_appl_dtl_id,
     this.appl_name,
     this.familty_id,
     this.parent_spouse_name,
     this.add_line_1,
     this.add_line_2,
     this.district_id,
     this.state_id,
     this.mobile_no,
     this.pin_code,
     this.crt_date,
     this.crt_ip,
     this.lst_upd_ip,
     this.lst_upd_date,
     this.lst_upd_user,
     this.status);

 DCWaterConnectionApplicantDetailsModel.fromJson(Map<String, dynamic> json) {
  //dtl_dc_water_conn_appl_dtl_id = json['dft_dc_water_conn_appl_dtl_id'];
  appl_name = json['appl_name'];
  familty_id = json['familty_id'];
  parent_spouse_name = json['parent_spouse_name'];
  add_line_1 = json['add_line_1'];
  add_line_2 = json['add_line_2'];
  mobile_no = json['mobile_no'];
  pin_code = json['pin_code'];
  district_id = json['district_id'];
  state_id = json['state_id'];
  // crt_date = json.containsKey('crt_date') ? json['crt_date'] : '';
  // crt_ip =  json.containsKey('crt_ip') ? json['crt_ip'] : '';
  // lst_upd_ip = json.containsKey('lst_upd_ip') ? json['lst_upd_ip'] : '';
  // lst_upd_date = json.containsKey('lst_upd_date') ? json['lst_upd_date'] : '';
  // lst_upd_user =  json.containsKey('lst_upd_user') ? json['lst_upd_user'] : '';
  // status =  json.containsKey('status') ? json['status'] : '';
 }

 Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
 // data['dft_dc_water_conn_appl_dtl_id'] = this.dtl_dc_water_conn_appl_dtl_id;
  data['appl_name'] = this.appl_name;
  data['familty_id'] = this.familty_id;
  data['parent_spouse_name'] = this.parent_spouse_name;
  data['add_line_1'] = this.add_line_1;
  data['add_line_2'] = this.add_line_2;
  data['mobile_no'] = this.mobile_no;
  data['pin_code'] = this.pin_code;
  data['state_id'] = this.state_id;
  data['district_id'] = this.district_id;
  // data['crt_date'] = this.crt_date;
  // data['crt_ip'] = this.crt_ip;
  // data['lst_upd_ip'] = this.lst_upd_ip;
  // data['lst_upd_date'] = this.lst_upd_date;
  // data['lst_upd_user'] = this.lst_upd_user;
  // data['status'] = this.status;
  return data;
 }
}