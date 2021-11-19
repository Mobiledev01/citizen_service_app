class FactoryPerPropertyDetailsModel {
  String dft_fac_per_prop_village_id = '';
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


  FactoryPerPropertyDetailsModel(
      {required this.dft_fac_per_prop_village_id,
      required this.district_id,
      required this.tp_id,
      required this.gp_id,
      required this.village_id,
      required this.property_id,
      required this.crt_date,
      required this.crt_user,
      required this.crt_ip,
      required this.lst_upd_ip,
      required this.lst_upd_date,
      required this.lst_upd_user,
      required this.status});

  FactoryPerPropertyDetailsModel.fromJson(Map<String, dynamic> json) {
   // dft_fac_per_prop_village_id = json['dft_fac_per_prop_village_id'];
    district_id = json['district_id'];
    tp_id = json['tp_id'];
    gp_id = json['gp_id'];
    village_id = json['village_id'];
    property_id = json['property_id'];
    // crt_date = json['crt_date'];
    // crt_ip = json['crt_ip'];
    // lst_upd_ip = json['lst_upd_ip'];
    // lst_upd_date = json['lst_upd_date'];
    // lst_upd_user = json['lst_upd_user'];
    // status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
  //  data['dft_fac_per_prop_village_id'] = this.dft_fac_per_prop_village_id;
    data['district_id'] = this.district_id;
    data['tp_id'] = this.tp_id;
    data['gp_id'] = this.gp_id;
    data['village_id'] = this.village_id;
    data['property_id'] = this.property_id;
    // data['crt_date'] = this.crt_date;
    // data['crt_ip'] = this.crt_ip;
    // data['lst_upd_ip'] = this.lst_upd_ip;
    // data['lst_upd_date'] = this.lst_upd_date;
    // data['lst_upd_user'] = this.lst_upd_user;
    // data['status'] = this.status;
    return data;
  }
}
