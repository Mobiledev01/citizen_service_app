class NewWaterConnectionPropertyDetailsModel {
  String dft_new_water_conn_prop_dtl_id = '';
  String district_id = '';
  String tp_id = '';
  String gp_id = '';
  String village_id = '';
  String property_id = '';
  String crt_date = '';
  String crt_user = '';
  String crt_ip = '';
  String lst_upd_ip = '';
  String lst_upd_date = '';
  String lst_upd_user = '';
  String status = '';

  NewWaterConnectionPropertyDetailsModel(
      this.dft_new_water_conn_prop_dtl_id,
      this.district_id,
      this.tp_id,
      this.gp_id,
      this.village_id,
      this.property_id,
      this.crt_date,
      this.crt_user,
      this.crt_ip,
      this.lst_upd_ip,
      this.lst_upd_date,
      this.lst_upd_user,
      this.status);

  NewWaterConnectionPropertyDetailsModel.fromJson(Map<String, dynamic> json) {
    //dft_new_water_conn_prop_dtl_id = json['dft_new_water_conn_prop_dtl_id'];
    district_id = json['district_id'];
    tp_id = json['tp_id'];
    gp_id = json['gp_id'];
    village_id = json['village_id'];
    property_id = json['property_id'];
    // crt_date = json['crt_date'];
    // crt_user = json['crt_user'];
    // crt_ip = json['crt_ip'];
    // lst_upd_ip = json['lst_upd_ip'];
    // lst_upd_date = json['lst_upd_date'];
    // lst_upd_user = json['lst_upd_user'];
    // status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
  //  data['dft_new_water_conn_prop_dtl_id'] = this.dft_new_water_conn_prop_dtl_id;
    data['district_id'] = this.district_id;
    data['tp_id'] = this.tp_id;
    data['gp_id'] = this.gp_id;
    data['village_id'] = this.village_id;
    data['property_id'] = this.property_id;
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
