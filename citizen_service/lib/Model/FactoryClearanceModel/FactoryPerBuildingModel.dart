class FactoryPerBuildingModel {
  String dft_dtl_fac_per_build_id = '';
  String build_lic_no = '';
  String fac_purpose = '';
  String fac_type_id = '';
  String capital_invest = '';
  String crt_date = '';
  String crt_user = '';
  String crt_ip = '';
  String lst_upd_ip = '';
  String lst_upd_date = '';
  String lst_upd_user = '';
  String status = '';

  FactoryPerBuildingModel(
      {required this.dft_dtl_fac_per_build_id,
        required this.build_lic_no,
        required this.fac_purpose,
        required this.fac_type_id,
        required this.capital_invest,
        required this.crt_date,
        required this.crt_user,
        required this.crt_ip,
        required this.lst_upd_ip,
        required this.lst_upd_date,
        required this.lst_upd_user,
        required this.status});

  FactoryPerBuildingModel.fromJson(Map<String, dynamic> json) {
  //  dft_dtl_fac_per_build_id = json['dft_dtl_fac_per_build_id'];
    build_lic_no = json['build_lic_no'];
    fac_purpose = json['fac_purpose'];
    fac_type_id = json['fac_type_id'];
    capital_invest = json['capital_invest'];
    // crt_date = json['crt_date'];
    // crt_ip = json['crt_ip'];
    // lst_upd_ip = json['lst_upd_ip'];
    // lst_upd_date = json['lst_upd_date'];
    // lst_upd_user = json['lst_upd_user'];
    // status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['dft_dtl_fac_per_build_id'] = this.dft_dtl_fac_per_build_id;
    data['build_lic_no'] = this.build_lic_no;
    data['fac_purpose'] = this.fac_purpose;
    data['fac_type_id'] = this.fac_type_id;
    data['capital_invest'] = this.capital_invest;
    // data['crt_date'] = this.crt_date;
    // data['crt_ip'] = this.crt_ip;
    // data['lst_upd_ip'] = this.lst_upd_ip;
    // data['lst_upd_date'] = this.lst_upd_date;
    // data['lst_upd_user'] = this.lst_upd_user;
    // data['status'] = this.status;
    return data;
  }
}
