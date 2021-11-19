class NocEscomsApplicant {
  String dft_noc_escoms_appl_id = '';
  String appl_name = '';
  String parent_spouse_name = '';
  String family_id = '';
  String address_line_1 = '';
  String address_line_2 = '';
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

  NocEscomsApplicant(
      this.dft_noc_escoms_appl_id,
      this.appl_name,
      this.parent_spouse_name,
      this.family_id,
      this.address_line_1,
      this.address_line_2,
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

  NocEscomsApplicant.fromJson(Map<String, dynamic> json) {
   // dft_noc_escoms_appl_id = json['dft_noc_escoms_appl_id'];
    appl_name = json['appl_name'];
    parent_spouse_name = json['parent_spouse_name'];
    family_id = json['family_id'];
    address_line_1 = json['address_line_1'];
    address_line_2 = json['address_line_2'];
    mob_no = json['mob_no'];
    pin_code = json['pin_code'];
    // crt_date = json.containsKey('crt_date') ? json['crt_date'] : '';
    // crt_ip =  json.containsKey('crt_ip') ? json['crt_ip'] : '';
    // lst_upd_ip = json.containsKey('lst_upd_ip') ? json['lst_upd_ip'] : '';
    // lst_upd_date = json.containsKey('lst_upd_date') ? json['lst_upd_date'] : '';
    // lst_upd_user =  json.containsKey('lst_upd_user') ? json['lst_upd_user'] : '';
    // status =  json.containsKey('status') ? json['status'] : '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
  //  data['dft_noc_escoms_appl_id'] = this.dft_noc_escoms_appl_id;
    data['appl_name'] = this.appl_name;
    data['parent_spouse_name'] = this.parent_spouse_name;
    data['family_id'] = this.family_id;
    data['address_line_1'] = this.address_line_1;
    data['address_line_2'] = this.address_line_2;
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
