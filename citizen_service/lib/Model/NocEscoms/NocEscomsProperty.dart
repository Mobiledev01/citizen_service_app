class NocEcomsProperty {
  String dft_dtl_noc_escoms_prop_id = '';
  String district_id = '';
  String tp_id = '';
  String gp_id = '';
  String village_id = '';
  String search_by = '';
  String property = '';
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

  NocEcomsProperty(
      this.dft_dtl_noc_escoms_prop_id,
      this.district_id,
      this.tp_id,
      this.gp_id,
      this.village_id,
      this.search_by,
      this.property,
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

  NocEcomsProperty.fromJson(Map<String, dynamic> json) {
    //dft_dtl_noc_escoms_prop_id = json['dft_dtl_noc_escoms_prop_id'];
    district_id = json['district_id'];
    tp_id = json['tp_id'];
    gp_id = json['gp_id'];
    village_id = json['village_id'];
    search_by = json['search_by'];
    property = json['property'];
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
   // data['dft_dtl_noc_escoms_prop_id'] = this.dft_dtl_noc_escoms_prop_id;
    data['district_id'] = this.district_id;
    data['tp_id'] = this.tp_id;
    data['gp_id'] = this.gp_id;
    data['village_id'] = this.village_id;
    data['search_by'] = this.search_by;
    data['property'] = this.property;
    // data['trn_cs_appl_id'] = this.trn_cs_appl_id;
    // data['service_id'] = this.service_id;
    // data['sub_service_id'] = this.sub_service_id;
    // data['crt_date'] = this.crt_date;
    // data['crt_ip'] = this.crt_ip;
    // data['crt_user'] = this.crt_user;
    // data['lst_upd_ip'] = this.lst_upd_ip;
    // data['lst_upd_date'] = this.lst_upd_date;
    // data['lst_upd_user'] = this.lst_upd_user;
    // data['status'] = this.status;
    return data;
  }
}
